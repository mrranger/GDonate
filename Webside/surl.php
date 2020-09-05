<?php
require_once('db.php');
require_once('lib/Short.class.php');
$sql = 'SELECT * FROM short_urls';

$shortener = new Shortener($db);
/**
 * @var array $config
 */
if($config['token'] == $_POST['token'])
{
    $shortURL_Prefix = $config['domain']['surl'] . '?c=';
    $longURL = empty($_POST['longurl'])? $_GET['longurl'] : $_POST['longurl'];
    try{
        $shortCode = $shortener->urlToShortCode($longURL);

        $shortURL = $shortURL_Prefix.$shortCode;
        $result = [
            'short_url' => $shortURL
        ];
        echo(json_encode($result));
    }catch(Exception $e){
        // Display error
        $result = [
            'error' => $e->getMessage(),
        ];
        echo(json_encode($result));
    }
}



?>
