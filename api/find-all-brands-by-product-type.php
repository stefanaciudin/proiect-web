<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';

if (isset($_GET['product_category'])) {
    $product_category = $_GET['product_category'];
    $brands = ProductRepository::getBrandsForMakeup($product_category);

    if (!empty($brands)) {
        $response = array(
            'brands' => $brands,
            'message' => 'Brands found.'
        );
        echo json_encode($response);
    }
} else {
    http_response_code(404);
    echo json_encode(
        array('message' => 'No brands found.')
    );
}
