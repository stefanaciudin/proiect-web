<?php
include_once 'Product.php';
include_once 'bd.php';

class ProductRepository
{
    /**
     * @param $skintype_id - the user's skin type
     * @param $type_id - the product type
     * @param $age - user's age
     * @param $is_makeup - whether the user wants makeup products or not
     * @param $usage_time - when the user wants to use the product
     * @return array - an array of Product objects, containing the recommended products. Three of them are selected randomly from the database,
     * according to the user's preferences.
     */
    public static function getRecProducts($skintype_id, $type_id, $age, $is_makeup, $usage_time): array
    {
        global $conn;
        error_log("Getting recommended products for: " . $skintype_id . " " . $type_id . " " . $age . " " . $is_makeup . " " . $usage_time);
        $stmt = $conn->prepare("SELECT p.* FROM products p 
                        JOIN product_types pt on p.type_id = pt.type_id 
                        WHERE pt.usage_time = ? AND
                        (skintype_id = ? OR skintype_id = 5) AND 
                        p.type_id = ? AND 
                        (age = ? OR age = 0) AND 
                        is_makeup = ?
                        ORDER BY RAND() 
                        LIMIT 3");
        $stmt->bind_param("siiii", $usage_time, $skintype_id, $type_id, $age, $is_makeup);
        $stmt->execute();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);

        // create an array to store the products
        $products = array();
        // fetch the products and create Product objects
        while ($stmt->fetch()) {
            $product = new Product();
            $product->setProductId($product_id);
            $product->setName($name);
            $product->setPrice($price);
            $product->setImagePath($image_path);
            $product->setIsMakeup($is_makeup);
            $product->setAge($age);
            $product->setBrandId($brand_id);
            $product->setSkintypeId($skintype_id);
            $product->setTypeId($type_id);
            $product->setIngredients($ingredients);
            $product->setDescription($description);
            $product->setHowToUse($how_to_use);
            $product->setLink($link);
            $products[] = $product;
        }

        $stmt->close();
        $conn->close();
        return $products;
    }
}
