<?php
$config['db'][0] =
[
    'user' => '',
    'pass' => '',
    'host' => '',
    'dbname' => '',
];
$config['db'][1] =
    [
        'user' => '',
        'pass' => '',
        'host' => '',
        'dbname' => '',
        'table_bans' => ''
    ];
/**
 * @var $config['domain'] domain for short link service
 */
$config['domain']['name'] = "payment.user-api.site"; // URL Без HTTPS или HTTP
$config['domain']['http'] = "http://payment.user-api.site/";// URL Тут с HTTP
$config['domain']['https'] = "https://payment.user-api.site/";// URL Тут с HTTPS
$config['domain']['surl'] = "https://payment.user-api.site/"; //путь до обработчика сейчас это index.php


/**
 * @var $config['product'] Product id from degiseller
 */
$config['digiseller']['product']['id'] = ; //Код товара
$config['digiseller']['id_seller'] = ; // Ид продавца
$config['digiseller']['password'] = ''; // Пароль от Digiseller



//GAME CONFIG
$config['unban']['allow'] = true;
$config['unban']['price'] = 150; //указывать int число

$config['token'] = '123123'; 
$config['currency'] = "рубль(-ей)";