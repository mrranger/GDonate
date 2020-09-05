<?php


/** @var array $config */
require_once('db.php');
require_once('lib/Log.class.php');

$log = new Log($db, $_POST['pltoken']);

if (!empty($_POST['desc']))
{
    $log->setPlayerLog($_POST['desc'], $_POST['sid']);
    //var_dump('true');
}
else
{

    try{
        $log->getLog();
    }catch(Exception $e){
        // Display error$e->getMessage()
        echo($e->getMessage());
    }
}