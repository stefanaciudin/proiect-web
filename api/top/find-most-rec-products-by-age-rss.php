<?php
header('Content-Type: application/rss+xml; charset=utf-8');

require_once '../../php/ProductRepository.php';
require_once '../functions.php';

if (isset($_GET['age'])) {
    $age = $_GET['age'];
    $products = ProductRepository::findMostRecProductsByAge($age);

    createRss($products,"Cele mai populare produse dupa varsta","Cele mai populare produse dupa varsta");
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Age is missing.')
    );
}
