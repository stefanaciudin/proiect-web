<?php
require_once '../../php/ProductRepository.php';
require_once '../functions.php';
header('Content-Type: text/html; charset=utf-8');

if (isset($_GET['age'])) {
    $age = $_GET['age'];
    $products = ProductRepository::findMostRecProductsByAge($age);
    $html = '<html lang="ro">';
    $html .= '<head></head>';
    $html .= '<title>Cele mai populare produse dupa varsta</title>';
    createPage($html, $products);
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Age is missing.')
    );
}