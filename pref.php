<?php
/* $Id$ */
include_once 'includes/init.php';

function save_pref( $prefs, $src) {
  global $my_theme, $prefuser;
  while ( list ( $key, $value ) = each ( $prefs ) ) {
    if ( $src == 'post' ) {
      $setting = substr ( $key, 5 );
      $prefix = substr ( $key, 0, 5 );
      if ( $prefix != 'pref_')
        continue;
      // validate key name.  should start with "pref_" and not include
      // any unusual characters that might cause SQL injection
      if ( ! preg_match ( '/pref_[A-Za-z0-9_]+$/', $key ) ) {
        die_miserable_death ( 'Invalid pref setting name "' .
        $key . '"' );
      }
    } else {
      $setting = $key;
      $prefix = 'pref_';    
    }
    //echo "Setting = $setting, key = $key, value = $value <br />\n";
    if ( strlen ( $setting ) > 0 && $prefix == 'pref_' ) {
      if ( $setting == 'THEME' &&  $value != 'none' )
        $my_theme = strtolower ( $value ); 
      $sql = 'DELETE FROM webcal_user_pref WHERE cal_login_id = ? ' .
        'AND cal_setting = ?';
      dbi_execute ( $sql, array ( $prefuser, $setting ) );
      if ( strlen ( $value ) > 0 ) {
      $setting = strtoupper ( $setting );
        $sql = 'INSERT INTO webcal_user_pref ' .
          '( cal_login_id, cal_setting, cal_value ) VALUES ' .
          '( ?, ?, ? )';
        if ( ! dbi_execute ( $sql, array ( $prefuser, $setting, $value ) ) ) {
          $error = 'Unable to update preference: ' . dbi_error () .
   '<br /><br /><span class="bold">SQL:</span>' . $sql;
          break;
        }
      }
    }
  }
	generate_CSS ( true );
}
$currenttab = 'settings';

if ( $WC->isLogin( $WC->userId() ) && 
  ($WC->isAdmin() || $WC->isNonuserAdmin() ) ) {
  $prefuser = $WC->userId();
} else {
  $prefuser = $WC->loginId();
}

if ( ! empty ( $_POST ) && empty ( $error )) {
  $my_theme = '';
  $currenttab = $WC->getPOST ( 'currenttab', 'settings' ); 
  save_pref ( $_POST, 'post' );
  
  if ( ! empty ( $my_theme ) ) {
    $theme = 'themes/'. $my_theme . '_pref.php';
    include_once $theme;
    save_pref ( $webcal_theme, 'theme' );  
  }
}

$user = $WC->userLoginId ();

// Get system settings first then merge user settings.
$smarty->LoadVars( $user, false );

//this will force LANGUAGE to to the current value and eliminate having
//to double click the 'SAVE' button
$translation_loaded = false;
reset_language ( getPref ( 'LANGUAGE', 4 ) );
//move this include here to allow proper translation
include 'includes/date_formats.php';

//get list of theme files from /themes directory
$themes = array();
$dir = 'themes/';
if ( @is_dir($dir) ) {
   if ($dh = opendir($dir)) {
       while (($file = readdir($dh)) !== false) {
         if ( strpos ( $file, '_pref.php' ) )
           $themes[] = str_replace ( '_pref.php', '', $file );
       }
       sort ( $themes );
       closedir($dh);
   }
}

// If user is admin of a non-user cal, and non-user cal is "public"
// (meaning it is a public calendar that requires no login), then allow
// the current user to modify prefs for that nonuser cal
if ( $WC->isUser( false ) )
  $nulist = get_my_nonusers ( $WC->loginId() );
	
$smarty->assign ('minutesStr', translate( 'minutes' ) );
$prefStr = translate( 'Preferences' );
$smarty->assign ('nonUserStr', str_replace ( 'XXX', $prefStr, 
  translate ( 'Modify Non User Calendar XXX' ) ) );
$smarty->assign ('myPrefStr',str_replace ( 'XXX', $prefStr, 
  translate ( 'Return to My XXX' ) ) );  
//allow css_cache to display public or NUC values
@session_start (); 
$_SESSION['webcal_tmp_login'] = $prefuser;
$openStr ="\"window.open('edit_template.php?type=%s','cal_template','dependent,menubar,scrollbars,height=500,width=500,outerHeight=520,outerWidth=520');\"";


$tabs_ar = array('settings'=>translate( 'Settings' ));
if ( getPref ( 'ALLOW_USER_THEMES', 2 ) || $WC->isAdmin() )
  $tabs_ar['themes'] = translate( 'Themes' );
if ( getPref ( 'SEND_EMAIL', 2 ) )
 $tabs_ar['email'] = translate( 'Email' );

$tabs_ar['boss'] = translate( 'When I am the boss' );
if ( getPref ( 'PUBLISH_ENABLED' ) || getPref ( 'RSS_ENABLED' ) ) {
 $tabs_ar['subscribe'] = translate( 'Subscribe/Publish' );
}
if ( getPref ( 'ALLOW_USER_HEADER' ) && ( getPref ( 'CUSTOM_SCRIPT' ) || 
  getPref ( 'CUSTOM_HEADER' ) || getPref ( 'CUSTOM_TRAILER' ) ) ) 
 $tabs_ar['header'] = translate( 'Custom Scripts' );
if ( getPref ( 'ALLOW_COLOR_CUSTOMIZATION' ) ) {
 $tabs_ar['colors'] = translate( 'Colors' );
 $smarty->assign ( 'allow_color_customization', true );
}

if ( getPref ( 'RSS_ENABLED' ) ) 
 $smarty->assign ( 'rss_enabled', true );

if ( getPref ( 'PUBLISH_ENABLED' ) ) 
 $smarty->assign ( 'publish_enabled', true );


$smarty->assign ( 'tabs_ar', $tabs_ar );
		

$smarty->assign ( 'choices', array ( 'day.php'=>translate ( 'Day' ),
  'week.php'=>translate ( 'Week' ),
  'month.php'=>translate ( 'Month' ),
  'year.php'=>translate ( 'Year' ) ) );

$smarty->assign ( 'views', loadViews ( ) );
	
$BodyX = 'onload="altrows();showTab(\''. $currenttab . '\');"';
$INC = array('visible.js', 'pref.js');
build_header ($INC, '', $BodyX);

  $smarty->assign ( 'qryStr',( ! empty ( $_SERVER['QUERY_STRING'] ) ? '?' 
	  . $_SERVER['QUERY_STRING'] : '' ) );
	$smarty->assign ( 'server_url', getPref ( 'SERVER_URL' ) );
	$smarty->assign ( 'user', $prefuser );
	$smarty->assign ( 'languages', define_languages () );
	$smarty->assign ( 'themes', $themes );
	$smarty->assign ( 'can_set_timezone', set_env ( 'TZ', getPref ( 'TIMEZONE' ) ) );
  $smarty->assign ( 'selected', SELECTED );
  $smarty->assign ( 'currenttab', $currenttab );
	$smarty->assign ( 'openS', sprintf ( $openStr, 'S' ) );
	$smarty->assign ( 'openH', sprintf ( $openStr, 'H' ) );
	$smarty->assign ( 'openT', sprintf ( $openStr, 'T' ) );
	$smarty->assign ( 'time_format_array', 
	  array ( '12'=>translate( '12 hour' ), '24'=>translate( '24 hour' ) ) );
	$smarty->assign ( 'timed_evt_len_array', 
	  array ('D'=>translate( 'Duration' ), 'E'=>translate( 'End Time' ) ) );
		
$smarty->display ( 'pref.tpl' );

?>