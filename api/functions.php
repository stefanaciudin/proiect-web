<?php
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