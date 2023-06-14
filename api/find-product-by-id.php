<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/ProductRepository.php';

// Check if the product ID is provided
if (isset($_GET['id'])) {
    $productId = $_GET['id'];

    // Find the product by ID
    $product = ProductRepository::findProductById($productId);

    if ($product) {
        $response = array(
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
