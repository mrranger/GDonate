<?php
require_once('db.php');
require_once('lib/Log.class.php');

$log = new Log($db, "");

if (!empty($_GET['log']))
{
    echo($log->GetAll());
}
else{?>
    <!doctype html>
    <html lang="">
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">

        <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

        <title>Document</title>
    </head>
    <body>
    <table>
        <thead>
        <tr>
            <th>Name</th>
            <th>Item Name</th>
            <th>Item Price</th>
        </tr>
        </thead>

        <tbody>
        <tr>
            <td>Alvin</td>
            <td>Eclair</td>
            <td>$0.87</td>
        </tr>
        <tr>
            <td>Alan</td>
            <td>Jellybean</td>
            <td>$3.76</td>
        </tr>
        <tr>
            <td>Jonathan</td>
            <td>Lollipop</td>
            <td>$7.00</td>
        </tr>
        </tbody>
    </table>
    <script>
        $(document).ready(function () {

            $.getJSON('ajax/test.json', function(data){
                var items = [];

                $.each(data, function(key, val){
                    items.push('<li id="' + key + '">' + val + '</li>');
                });

                $('<ul/>', {
                    'class': 'my-new-list',
                    html: items.join('')
                }).appendTo('body');
            });
        })
    </script>
    </body>
    </html>
    <?php } ?>