<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';
include 'functions.php';
if (isset($_GET['min_price']) && isset($_GET['max_price'])) {
    $minPrice = $_GET['min_price'];
    $maxPrice = $_GET['max_price'];
    $products = ProductRepository::getProductsByPrice($minPrice, $maxPrice);

    if ($products) {
        foreach ($products as $product) {
            $productData = getArr($product);
            $response[] = $productData;
        }
        echo json_encode($response);
    } else {
        http_response_code(404);
        echo json_encode(
            array('message' => 'No products found for the given price.')
        );
    }
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Prices are missing.')
    );
}