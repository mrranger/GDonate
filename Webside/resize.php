<?php
    header('Content-Type: image/png');
    require_once('lib/Resize.class.php');
    $image = new Resize();
    $image->load('image.png'); //$_GET['link']
    $image->resize($_GET['width'], $_GET['height']);
    $image->output();