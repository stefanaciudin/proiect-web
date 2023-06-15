<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';

function getArr(mixed $product): array
{
    return array(
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
        'link' => $product->getLink(),
        'message' => 'Product found.'
    );
}

if (isset($_GET['brand_name'])) {
    $brandName = $_GET['brand_name'];
    $products = ProductRepository::getProductsByBrand($brandName,1); //return all makeup products

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
        array('message' => 'Bad request. Brand name is missing.')
    );
}