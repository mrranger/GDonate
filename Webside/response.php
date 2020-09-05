<?php

/** @var array $config */
require_once('db.php');
require_once('lib/Player.class.php');

$player = new Player($db, $_POST['sid'], $_POST['token'],$config);

try{
    //var_dump($_POST);
    $player->getPlayerBalance($_POST['balance']);
}catch(Exception $e){
    // Display error$e->getMessage()
    echo($e->getMessage());
}