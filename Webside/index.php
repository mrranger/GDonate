<?php

require_once('db.php');
require_once('lib/Short.class.php');
$sql = 'SELECT * FROM short_urls';

$shortener = new Shortener($db);
$shortCode = $_GET["c"];

try{
// Get URL by short code
$url = $shortener->shortCodeToUrl($shortCode);

// Redirect to the original URL
header("Location: ".$url);
exit;
}catch(Exception $e){
// Display error
echo $e->getMessage();
}