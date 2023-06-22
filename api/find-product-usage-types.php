<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';

if (isset($_GET['product_category'])) {
    $product_category = $_GET['product_category'];
    $usage_types = ProductRepository::getUsageTypes($product_category);

    if (!empty($usage_types)) {
        $response = array(
            'usage_types' => $usage_types,
            'message' => 'Usage types found.'
        );
        echo json_encode($response);
    }
} else {
    http_response_code(404);
    echo json_encode(
        array('message' => 'No usage types found.')
    );
}