<?php
require_once '../../php/ProductRepository.php';
header('Content-Type: text/html; charset=utf-8');

if (isset($_GET['age'])) {
    $age = $_GET['age'];
// Get the top recommended products by age
    $products = ProductRepository::findMostRecProductsByAge($age);

// Generate the HTML page
    $html = '<html lang="ro">';
    $html .= '<head></head>';
    $html .= '<title>Cele mai populare produse dupa varsta</title>';
    $html .= '</head>';
    $html .= '<body>';
    $html .= '<h1>Top produse: </h1>';

// Add the products to the HTML page
    $html .= '<ul>';
    foreach ($products as $product) {
        $html .= '<li>';
        $html .= '<h2>' . $product->getName() . '</h2>';
        $html .= '<p>Pret: ' . $product->getPrice() . '</p>';
        $html .= '<p>Descriere: ' . $product->getDescription() . '</p>';
        $html .= '</li>';
    }
    $html .= '</ul>';
    $html .= '</body>';
    $html .= '</html>';

    echo $html;
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Age is missing.')
    );
}