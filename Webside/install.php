<?php

require_once('db.php');
require_once('lib/Install.class.php');

$install = new Install($db,$db1);
$install->install($config);