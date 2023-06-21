<?php
header('Content-Type: application/rss+xml; charset=utf-8');

require_once '../../php/ProductRepository.php';
require_once '../functions.php';

if (isset($_GET['min_price']) && isset($_GET['max_price'])) {
    $minPrice = $_GET['min_price'];
    $maxPrice = $_GET['max_price'];
    $products = ProductRepository::findMostRecProductsByPrice($minPrice, $maxPrice);
    createRss($products,"Cele mai populare produse dupa pret","Cele mai populare produse dupa pret");
}else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Prices are missing.')
    );
}


