#!/usr/local/bin/php -q
<?php
/* $Id$
 *
 * Description:
 * This is a command-line script that will reload all user's
 * remote calendars
 *
 * Usage:
 * php reload_remotes.php
 *
 * Setup:
 * This script should be setup to run periodically on your system.
 * You should not run this more a once per hour for performance reasons
 *
 * To set this up in cron, add a line like the following in your crontab
 * to run it every hour:
 *   1 * * * * php /some/path/here/reload_remotes.php
 * Of course, change the path to where this script lives.  If the
 * php binary is not in your $PATH, you may also need to provide
 * the full path to "php".
 * On Linux, just type crontab -e to edit your crontab.
 *
 * If you're a Windows user, you'll either need to find a cron clone
 * for Windows (they're out there) or use the Windows Task Scheduler.
 * (See docs/WebCalendar-SysAdmin.html for instructions.)
 * 
 * Comments:
 * You will need access to the PHP binary (command-line) rather than
 * the module-based version that is typically installed for use with
 * a web server.to build as a CGI (rather than an Apache module) for
 *
 * If running this script from the command line generates PHP
 * warnings, you can disable error_reporting by adding
 * "-d error_reporting=0" to the command line:
 *   php -d error_reporting=0 /some/path/here/tools/reload_remotes.php
 *
 *********************************************************************/




// Load include files.
// If you have moved this script out of the WebCalendar directory,
// which you probably should do since it would be better for security
// reasons, you would need to change $includedir to point to the
// webcalendar include directory.
$basedir = '..'; // points to the base WebCalendar directory relative to
                 // current working directory
$includedir = '../includes';
$old_path = ini_get('include_path');
$delim = ( strstr ( $old_path, ';' )? ';': ':');
ini_set('include_path', $old_path . $delim . $includedir . $delim);

require_once "$includedir/classes/WebCalendar.class";

$WebCalendar =& new WebCalendar ( __FILE__ );

include "$includedir/config.php";
include "$includedir/dbi4php.php";
include "$includedir/functions.php";

$WebCalendar->initializeFirstPhase();

include "$includedir/$user_inc";
include "$includedir/xcal.php";


$WebCalendar->initializeSecondPhase();

$debug = false; // set to true to print debug info...

// Establish a database connection.
$c = dbi_connect ( $db_host, $db_login, $db_password, $db_database, true );
if ( ! $c ) {
  echo 'Error connecting to database: ' . dbi_error ();
  exit;
}

load_global_settings ();

if ( $debug )
  echo '<br />Include Path=' . ini_get('include_path') . " <br />\n";

if ( $REMOTES_ENABLED == 'Y' ) {
   $res = dbi_execute ( "SELECT cal_login, cal_url, cal_admin FROM webcal_nonuser_cals " .
     " WHERE cal_url IS NOT NULL " );  

  if ( $res ) {
    while ( $row = dbi_fetch_row ( $res ) ) {
      $calUser = $row[0];
      $cal_url = $row[1];
      $login = $row[2];
      $type = 'remoteics';
      $overwrite = true;
      $data = parse_ical( $cal_url, $type );
      if (! empty ($data) && empty ($errormsg) ) {
        //delete existing events
        if ( $debug )
          echo "<br />Deleting events for: $calUser<br />\n";
        delete_events ( $calUser );
        //import new events
        if ( $debug )
          echo "Importing events for: $calUser<br />\nFrom: $cal_url<br />\n";
        import_data ( $data, $overwrite, $type );
        if ( $debug )
          echo "Events successfully imported: $count_suc<br /><br />\n";
      }  
    }
    dbi_free_result ( $res );
  }
}
//just in case
$login = '';

function delete_events ( $nid ){

  // Get event ids for all events this user is a participant
  $events = array ();
  $res = dbi_execute ( "SELECT webcal_entry.cal_id " .
    "FROM webcal_entry, webcal_entry_user " .
    "WHERE webcal_entry.cal_id = webcal_entry_user.cal_id " .
    "AND webcal_entry_user.cal_login = ?", array( $nid ) );
  if ( $res ) {
    while ( $row = dbi_fetch_row ( $res ) ) {
      $events[] = $row[0];
    }
  }

  // Now count number of participants in each event...
  // If just 1, then save id to be deleted
  $delete_em = array ();
  $cnt = count ( $events );
  for ( $i = 0; $i < $cnt; $i++ ) {
    $res = dbi_execute ( "SELECT COUNT(*) FROM webcal_entry_user " .
      "WHERE cal_id = ?", array( $events[$i] ) );
    if ( $res ) {
      if ( $row = dbi_fetch_row ( $res ) ) {
        if ( $row[0] == 1 )
   $delete_em[] = $events[$i];
      }
      dbi_free_result ( $res );
    }
  }
  // Now delete events that were just for this user
  $cnt = count ( $delete_em );
  for ( $i = 0; $i < $cnt; $i++ ) {
    dbi_execute ( "DELETE FROM webcal_entry_repeats WHERE cal_id = ?", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_entry_repeats_not WHERE cal_id = ?", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_entry_log WHERE cal_entry_id = ?", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_import_data WHERE cal_id = ?", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_site_extras WHERE cal_id = ?", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_entry_ext_user WHERE cal_id = ?", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_reminders WHERE cal_id =? ", 
      array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_blob WHERE cal_id = ?", 
     array( $delete_em[$i] ) );
    dbi_execute ( "DELETE FROM webcal_entry WHERE cal_id = ?", 
      array( $delete_em[$i] ) );
  }
  // Delete user participation from events
  dbi_execute ( "DELETE FROM webcal_entry_user WHERE cal_login = ?", 
    array( $nid ) );

}
?>