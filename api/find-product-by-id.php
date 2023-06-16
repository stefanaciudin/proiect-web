<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';
include_once 'functions.php';
// Check if the product ID is provided
if (isset($_GET['id'])) {
    $productId = $_GET['id'];

    // Find the product by ID
    $product = ProductRepository::findProductById($productId);

    if ($product) {
        $response = getArr($product);
        echo json_encode($response);
    } else {
        http_response_code(404);
        echo json_encode(
            array('message' => 'Product not found.')
        );
    }
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Product ID is missing.')
    );
}
