<?php
/* Allows a user to specify a remote calendar by URL that can
 * be imported manually into the NUC calendar specified. The user
 * will also be allowed to create a layer to display this calendar 
 * on top of their own calendar.
 *
 * @author Ray Jones <rjones@umces.edu>
 * @copyright Craig Knudsen, <cknudsen@cknudsen.com>, http://www.k5n.us/cknudsen
 * @license http://www.gnu.org/licenses/gpl.html GNU GPL
 * @version $Id$
 * @package WebCalendar
 * @subpackage Edit Remotes
 *
 * Security
 * $REMOTES_ENABLED must be enabled under System Settings and if
 * if UAC is enabled, then the user must be allowed to ACCESS_IMPORT 
*/
include_once 'includes/init.php';
$INC = array('edit_remotes.js', 'visible.js');
build_header ( $INC, '', '', 5 );

$error = '';

if ( ! getPref ( 'REMOTES_ENABLED', 2 )  || 
  ! access_can_access_function ( ACCESS_IMPORT ) ) {
  $error = print_not_auth ();
}

if ( $error ) {
  echo print_error ( $error );
  echo "</body>\n</html>";
  exit;
}
$nid = $WC->getValue ( 'nid' );
$smarty->assign ( 'nid', $nid );
$smarty->assign ( 'add', $WC->getValue ( 'add' ) );


if ( ! empty ( $nid ) ) {
  $nidData = $WC->User->loadVariables ( $nid );
	 $smarty->assign ( 'rmt_name', htmlspecialchars ( $nidData['fullname'] ) );
	 $smarty->assign ( 'rmt_url', htmlspecialchars ( $nidData['url'] ) );
}

$smarty->assign ( 'confirmStr', str_replace ( 'XXX', translate ( 'entry' ),
  translate ( 'Are you sure you want to delete this XXX?' ) ) );

$smarty->display ( 'edit_remotes.tpl' );

?>
