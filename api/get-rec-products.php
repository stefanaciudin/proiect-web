<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

require_once '../php/Product.php';
require_once '../php/ProductRepository.php';
require_once '../php/bd.php';

session_start();

$skintype_id = 1;
$type_id = 1;
$age = 0;
$is_makeup = 0;
$usage_time = 'oricand';

$recommendedProducts = ProductRepository::getRecProducts($skintype_id, $type_id, $age, $is_makeup, $usage_time);

$response = array();
if ($skintype_id) {

    foreach ($recommendedProducts as $product) {
        $productData = array(
            'product_id' => $product->getProductId(),
            'name' => $product->getName(),
            'price' => $product->getPrice(),
            'image_path' => $product->getImagePath(),
            'is_makeup' => $product->getIsMakeup(),
            'age' => $product->getAge(),
            'brand_id' => $product->getBrandId(),
            'skintype_id' => $product->getSkintypeId(),
            'type_id' => $product->getTypeId(),
            'ingredients' => $product->getIngredients(),
            'description' => $product->getDescription(),
            'how_to_use' => $product->getHowToUse(),
            'link' => $product->getLink()
        );
        $response[] = $productData;
    }

    echo json_encode($response);
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Required parameters are missing.')
    );
}