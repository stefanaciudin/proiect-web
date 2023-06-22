<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';
include 'functions.php';
if (isset($_GET['brand_name']) && isset($_GET['product_category'])) {
    $brandName = $_GET['brand_name'];
    $product_category = $_GET['product_category'];
    $products = ProductRepository::getProductsByBrand($brandName, $product_category); //return all makeup products

    if ($products) {
        foreach ($products as $product) {
            $productData = getArr($product);
            $response[] = $productData;
        }
        echo json_encode($response);
    } else {
        http_response_code(404);
        echo json_encode(
            array('message' => 'No products found for the given brand.')
        );
    }
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Brand name or product category is missing.')
    );
}