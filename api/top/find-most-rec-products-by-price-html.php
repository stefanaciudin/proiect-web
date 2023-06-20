<?php
require_once '../../php/ProductRepository.php';
require_once '../functions.php';
header('Content-Type: text/html; charset=utf-8');

if (isset($_GET['min_price']) && isset($_GET['max_price'])) {
    $minPrice = $_GET['min_price'];
    $maxPrice = $_GET['max_price'];
    $products = ProductRepository::findMostRecProductsByPrice($minPrice, $maxPrice);
    $html = '<html lang="ro">';
    $html .= '<head></head>';
    $html .= '<title>Cele mai populare produse dupa pret</title>';
    createPage($html, $products);
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Prices are missing.')
    );
}