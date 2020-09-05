<?php

/** @var array $config */
require_once('db.php');
require_once('lib/Payment.class.php');
require_once('lib/Unban.class.php');
$unban = new Unban($db1);
$digi = new Payment($db, $config,$unban);
try{

    $digi->SuccessPayment($_GET['uniquecode'], $config['digiseller']['id_seller'] , $config['digiseller']['password'],$_GET['sid']);
}catch(Exception $e){
    // Display error$e->getMessage()
    echo($e->getMessage());
}