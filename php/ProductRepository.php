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
            $product = self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);
            $products[] = $product;
        }

        $stmt->close();
        $conn->close();
        return $products;
    }

    public static function findProductById($productId): ?Product
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE product_id = ?");
        $stmt->bind_param("i", $productId);
        $stmt->execute();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);
        $stmt->fetch();
        $stmt->close();
        $conn->close();

        if (!$product_id) {
            return null;
        }

        //error_log("Returning product: " . $product->getName() . " " . $product->getPrice() . " " . $product->getImagePath() . " " . $product->getIsMakeup() . " " . $product->getAge() . " " . $product->getBrandId() . " " . $product->getSkintypeId() . " " . $product->getTypeId() . " " . $product->getIngredients() . " " . $product->getDescription() . " " . $product->getHowToUse() . " " . $product->getLink());
        return self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);
    }

    public static function getAllProductBrands(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT brand_id, name FROM brands ORDER BY name");
        $stmt->execute();
        $stmt->bind_result($brandId, $brandName);

        $brands = array();
        while ($stmt->fetch()) {
            $brand = array(
                'brand_id' => $brandId,
                'brand_name' => $brandName
            );
            $brands[] = $brand;
        }

        $stmt->close();
        $conn->close();
        return $brands;
    }

    /**
     * @param mixed $product_id
     * @param mixed $name
     * @param $price
     * @param $image_path
     * @param $is_makeup
     * @param $age
     * @param $brand_id
     * @param $skintype_id
     * @param $type_id
     * @param $ingredients
     * @param $description
     * @param $how_to_use
     * @param $link
     * @return Product
     */
    public static function getProduct(mixed $product_id, mixed $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link): Product
    {
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
        return $product;
    }

    public static function getProductsByBrand(mixed $brandName, mixed $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN brands b on p.brand_id = b.brand_id WHERE b.name = ? and p.is_makeup = ?");
        $stmt->bind_param("si", $brandName, $isMakeup);
        $stmt->execute();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);

        $products = array();
        while ($stmt->fetch()) {
            $product = self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);
            $products[] = $product;
        }

        $stmt->close();
        $conn->close();
        return $products;

    }

    public static function getProductsByType(mixed $product_type, mixed $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE pt.product_type = ? and p.is_makeup=?");
        $stmt->bind_param("si", $product_type, $isMakeup);
        $stmt->execute();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);

        $products = array();
        while ($stmt->fetch()) {
            $product = self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);
            $products[] = $product;
        }

        $stmt->close();
        $conn->close();
        return $products;
    }

    public static function getProductsByUsageType(mixed $usage_type, mixed $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE pt.usage_type = ? and p.is_makeup=?");
        $stmt->bind_param("si", $usage_type, $isMakeup);
        $stmt->execute();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);

        $products = array();
        while ($stmt->fetch()) {
            $product = self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link);
            $products[] = $product;
        }

        $stmt->close();
        $conn->close();
        return $products;
    }

    public static function getUsageTypesForMakeup(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT pt.usage_type FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE p.is_makeup=1");
        $stmt->execute();
        $stmt->bind_result($usage_type);

        $usageTypes = array();
        while ($stmt->fetch()) {
            $usageTypes[] = $usage_type;
        }

        $stmt->close();
        $conn->close();
        return $usageTypes;
    }

    public static function getBrandsForMakeup(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT b.name,b.brand_id FROM products p JOIN brands b on p.brand_id = b.brand_id WHERE p.is_makeup=1 ORDER BY b.name");
        $stmt->execute();
        $stmt->bind_result($name, $brand_id);


        $brands = array();
        while ($stmt->fetch()) {
            $brand = array(
                'brand_id' => $brand_id,
                'brand_name' => $name
            );
            $brands[] = $brand;
        }

        $stmt->close();
        $conn->close();
        return $brands;

    }

}
