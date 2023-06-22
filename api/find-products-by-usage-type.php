<?php

header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';
include 'functions.php';

if (isset($_GET['usage_type']) && isset($_GET['product_category'])) {
    $product_type = $_GET['usage_type'];
    $product_category = $_GET['product_category'];
    $products = ProductRepository::getProductsByUsageType($product_type,$product_category); //return all makeup products

    if ($products) {
        $response = array();
        foreach ($products as $product) {
            $productData = getArr($product);
            $response[] = $productData;
        }
        echo json_encode($response);
    } else {
        http_response_code(404);
        echo json_encode(
            array('message' => 'No products found for the given type.')
        );
    }
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Product type or product category is missing.')
    );
}