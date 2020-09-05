<?php
require_once('config.php');
/** @var array $config */

$db = new PDO('mysql:host='. $config['db'][0]['host'] .';dbname='. $config['db'][0]['dbname'], $config['db'][0]['user'], $config['db'][0]['pass'],[PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
$db1 = new PDO('mysql:host='. $config['db'][1]['host'] .';dbname='. $config['db'][1]['dbname'], $config['db'][1]['user'], $config['db'][1]['pass'],[PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]);
