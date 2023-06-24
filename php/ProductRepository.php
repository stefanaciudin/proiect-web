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
        $stmt->store_result();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);

        // create an array to store the products
        $products = array();
        // fetch the products and create Product objects
        while ($stmt->fetch()) {
            static::updateTimesRec($product_id);
            $product = static::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
            $products[] = $product;
        }

        $stmt->close();
        return $products;
    }

    /**
     * @param $productId - the product id for which the update needs to be done
     * @return void - updates the times_rec field in the database for the given product
     */
    public static function updateTimesRec($productId): void
    {
        global $conn;
        $stmt = $conn->prepare("UPDATE products SET times_rec = times_rec + 1 WHERE product_id = ?");
        $stmt->bind_param("i", $productId);
        $stmt->execute();
        $stmt->close();
    }

    /**
     * @param mysqli_stmt $stmt
     * @return array - an array of Product objects, containing the products fetched from the database
     */
    public static function executeAndFetchProducts(mysqli_stmt $stmt): array
    {
        $stmt->execute();
        $stmt->store_result();
        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);

        // create an array to store the products
        $products = array();
        // fetch the products and create Product objects
        while ($stmt->fetch()) {
            $product = static::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
            $products[] = $product;
        }

        $stmt->close();
        return $products;

    }

    /**
     * @param $age - the age for the user request
     * @return array - an array of Product objects, with the most recommended products for the given age
     */
    public static function findMostRecProductsByAge($age): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE age = ? ORDER BY times_rec DESC LIMIT 10");
        $stmt->bind_param("i", $age);
        return static::executeAndFetchProducts($stmt);

    }

    /**
     * @param  $min_price - the minimum price for the user request
     * @param  $max_price - the maximum price for the user request
     * @return array - an array of Product objects, with the most recommended products for the given price range
     */
    public static function findMostRecProductsByPrice( $min_price,  $max_price): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE price BETWEEN ? AND ? ORDER BY times_rec DESC LIMIT 10");
        $stmt->bind_param("ii", $min_price, $max_price);
        return static::executeAndFetchProducts($stmt);
    }

    /**
     * @param $productId - the product id that is being searched for
     * @return Product|null - the product with the given id, or null if it doesn't exist
     */

    public static function findProductById($productId): ?Product
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE product_id = ?");
        $stmt->bind_param("i", $productId);
        $stmt->execute();

        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
        $stmt->fetch();
        $stmt->close();
        $conn->close();

        if (!$product_id) {
            return null;
        }
        return static::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
    }

    /**
     * @return array - an array of brands, that contains all product brands from the database
     */
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

        return $brands;
    }

    public static function getAllProducts(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT product_id, name, price FROM products ORDER BY name");
        $stmt->execute();
        $stmt->bind_result($product_id, $name, $price);

        $products = array();
        while ($stmt->fetch()) {
            $product = array(
                'product_id' => $product_id,
                'name' => $name,
                'price' => $price
            );
            $products[] = $product;
        }

        return $products;
    }

     /**
     * @param int $prodId - the product id to be deleted
     * @return bool - if the product was deleted successfully or not
     */
    public static function delete(int $prodId): bool
    {
        global $conn;
        $stmt = $conn->prepare("DELETE FROM products WHERE product_id = ?");
        $stmt->bind_param("i", $prodId);
        return $stmt->execute();
    }

    /**
     * @param  $product_id
     * @param  $name
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
     * @param $times_rec
     * @return Product - a product object with all of its information available in the database
     */
    public static function getProduct( $product_id,  $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec): Product
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
        $product->setTimesRecommended($times_rec);
        return $product;
    }

    /**
     * @param  $brandName - the brand name for the user request
     * @param  $isMakeup - whether the user is looking for makeup or skincare products
     * @return array - an array of Product objects, with all products from the given brand
     */

    public static function getProductsByBrand( $brandName,  $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN brands b on p.brand_id = b.brand_id WHERE b.name = ? and p.is_makeup = ?");
        $stmt->bind_param("si", $brandName, $isMakeup);
        return static::executeAndFetchProducts($stmt);

    }

    /**
     * @param  $product_type - the product type for the user request
     * @param  $isMakeup - whether the user is looking for makeup or skincare products
     * @return array - an array of Product objects, with all products from the given type
     */

    public static function getProductsByType( $product_type,  $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE pt.product_type = ? and p.is_makeup=?");
        $stmt->bind_param("si", $product_type, $isMakeup);
        return static::executeAndFetchProducts($stmt);
    }

    /**
     * @param  $age - the age for the user request
     * @return array - an array of Product objects, with all products for the given age
     */
    public static function getProductsByAge( $age): array
    {
        // get only the first 2 letters of age - the age is sent weird here for some reason
        $age = substr($age, 0, 2);
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE (age = ? OR age = 0) AND is_makeup = 0 ORDER BY age DESC");
        $stmt->bind_param("i", $age);
        return static::executeAndFetchProducts($stmt);

    }

    /**
     * @param  $skintype_id - the skintype for the user request
     * @return array - an array of Product objects, with all products for the given skintype
     */

    public static function getProductsBySkintype( $skintype_id): array
    {
        $skintype_id = substr($skintype_id, 0, 1);
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE (skintype_id = ? OR skintype_id = 5) AND is_makeup = 0 ORDER BY skintype_id, type_id");
        $stmt->bind_param("i", $skintype_id);
        return static::executeAndFetchProducts($stmt);
    }

    /**
     * @param  $min_price - the minimum price for the user request
     * @param  $max_price - the maximum price for the user request
     * @return array - an array of Product objects, with all products for the given price range
     */
    public static function getProductsByPrice( $min_price,  $max_price): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE price BETWEEN ? AND ? ORDER BY price, is_makeup");
        $stmt->bind_param("ii", $min_price, $max_price);
        return static::executeAndFetchProducts($stmt);
    }

    /**
     * @param  $usage_type - the usage type for the user request
     * @param  $isMakeup - whether the user is looking for makeup or skincare products
     * @return array - an array of Product objects, with all products for the given usage type
     */

    public static function getProductsByUsageType( $usage_type,  $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE pt.usage_type = ? and p.is_makeup=?");
        $stmt->bind_param("si", $usage_type, $isMakeup);
        return static::executeAndFetchProducts($stmt);
    }

    /**
     * @param  $is_makeup - whether the user is looking for makeup or skincare products
     * @return array - an array of Product objects, with all products for the given is_makeup
     */
    public static function getUsageTypes( $is_makeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT pt.usage_type,pt.type_id FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE p.is_makeup=?");
        $stmt->bind_param("i", $is_makeup);
        $stmt->execute();
        $stmt->bind_result($usage_type, $type_id);
        $usageTypes = array();
        while ($stmt->fetch()) {
            $usage_type = array(
                'usage_type_name' => $usage_type,
                'type_id' => $type_id
            );
            $usageTypes[] = $usage_type;
        }

        $stmt->close();
        $conn->close();
        return $usageTypes;
    }

    /**
     * @param  $is_makeup - whether the user is looking for makeup or skincare products
     * @return array - an array of Product objects, with all products that are makeup or not, per user request
     */
    public static function getBrandsForMakeup( $is_makeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT b.name,b.brand_id FROM products p JOIN brands b on p.brand_id = b.brand_id WHERE p.is_makeup=? ORDER BY b.name");
        $stmt->bind_param("i", $is_makeup);
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

    /**
     * @return array - an array of product brands
     */
    public function getProductsByBrands(): array
    {
        global $conn;
        $brand_id = 1;
        $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where brand_id =?");
        $stmt->bind_param("i", $brand_id);
        $stmt->execute();
        $stmt->bind_result($product_id, $name, $price, $image_path, $description, $link);
        $results = array();
        while ($stmt->fetch()) {
            $makeup = array(
                'id' => $product_id,
                'name' => $name,
                'price' => $price,
                'image_path' => $image_path,
                'description' => $description,
                'link' => $link
            );
            $results[] = $makeup;
        }
        return $results;
    }

    /**
     * @return array - an array of brands with makeup products
     */
    public function getMakeUpBrands(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT b.name, b.brand_id from brands b JOIN products p on b.brand_id = p.brand_id where p.is_makeup =1");
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

        return $brands;
    }

    /**
     * @return array - an array of brands with skincare products
     */

    public function getSkincareBrands(): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT b.name, b.brand_id from brands b JOIN products p on b.brand_id = p.brand_id where p.is_makeup =0");
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

        return $brands;
    }
    /**
     * @return array - an array of skincare with skincare products
     */

     public function getAllSkincare(): array
     {
         global $conn;
         $stmt = $conn->prepare("SELECT skintype_id, skin_type FROM skintypes;");
         $stmt->execute();
         $stmt->bind_result($skintype_id, $skin_type);
         $brands = array();
         while ($stmt->fetch()) {
             $brand = array(
                 'skintype_id' => $skintype_id,
                 'skin_type' => $skin_type
             );
             $brands[] = $brand;
         }
 
         return $brands;
     }

    /**
     * @return array - an array of products_type with skincare products
     */

     public function getAllProductsType(): array
     {
         global $conn;
         $stmt = $conn->prepare("SELECT type_id, usage_type FROM product_types");
         $stmt->execute();
         $stmt->bind_result($type_id, $usage_type);
         $brands = array();
         while ($stmt->fetch()) {
             $brand = array(
                 'type_id' => $type_id,
                 'usage_type' => $usage_type
             );
             $brands[] = $brand;
         }
 
         return $brands;
     }
    /**
     * @param $isMakeup - whether the user is looking for makeup or skincare products
     * @return array - an array of usage types
     */
    public static function getProductsType($isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT pt.usage_type, pt.type_id FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE p.is_makeup=?");
        $stmt->bind_param("i", $isMakeup);
        $stmt->execute();
        $stmt->bind_result($usage_type, $type_id);
        $usage_types = array();
        while ($stmt->fetch()) {
            $usage_type = array(
                'id_type' => $type_id,
                'name_type' => $usage_type
            );
            $usage_types[] = $usage_type;
        }

        return $usage_types;

    }

    /**
     * @param $product_type - the kind of product the user is looking for
     * @return array - an array of usage types by product type
     */
    public static function getUsageTypeByProductType($product_type): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT distinct usage_type,product_types.type_id FROM  product_types join products p on product_types.type_id = p.type_id  WHERE product_type=? and p.is_makeup=1 ORDER BY usage_type");
        $stmt->bind_param("s", $product_type);
        $stmt->execute();
        $stmt->bind_result($usage_type, $type_id);
        $usage_types = array();
        while ($stmt->fetch()) {
            $usage_type = array(
                'id_type' => $type_id,
                'name_type' => $usage_type
            );
            $usage_types[] = $usage_type;
        }

        return $usage_types;

    }

    /**
     * @return array - an array of products, with all products that are makeup or not, per user request. The products are sorted.
     * The method was created to be used in the mobile version of the app.
     */
    public static function getProductsBySort(): array
    {
        $selectedBox = "";
        $selectedBrand = $_POST['select1'];
        $checkboxes = $_POST['checkboxGroup'] ?? array();
        if (!is_array($checkboxes)) {
            $checkboxes = [$checkboxes];
        }
        $checkbox1 = in_array('checkbox1', $checkboxes);
        $checkbox2 = in_array('checkbox2', $checkboxes);
        $checkbox3 = in_array('checkbox3', $checkboxes);
        $checkbox4 = in_array('checkbox4', $checkboxes);


        if ($checkbox1) {
            $selectedBox = $_POST['select2'] ?? "";
        } elseif ($checkbox2) {
            $selectedBox = $_POST['select3'] ?? "";
        } elseif ($checkbox3) {
            $selectedBox = $_POST['select4'] ?? "";
        }elseif($checkbox4){
            $selectedBox = $_POST['select5'] ?? "";
            global $conn;
        
            $videoR = new VideoRepository(); 
            $video = $videoR->getVideosByOccasionArray($selectedBox);  
            return $video;


        }


        global $conn;
        if ($selectedBox == "") {
            $stmt = $conn->prepare("SELECT product_id, name, price, image_path, description,link FROM products  WHERE brand_id=?");
            $stmt->bind_param("i", $selectedBrand);
        } else {
            $stmt = $conn->prepare("SELECT product_id, name, price, image_path, description,link FROM products  WHERE brand_id=? and type_id = ?");
            $stmt->bind_param("ii", $selectedBrand, $selectedBox);
        }
        $stmt->execute();
        $stmt->bind_result($product_id, $name, $price, $image_path, $description, $link);
        $results = array();
        while ($stmt->fetch()) {
            $makeup = array(
                'id' => $product_id,
                'name' => $name,
                'price' => $price,
                'image_path' => $image_path,
                'description' => $description,
                'link' => $link
            );
            $results[] = $makeup;
        }
        return $results;
    }


    /**
     * @return array - an array of filtered products by user requests. Made for the mobile version of the app.
     */

    public static function getProductsByFilter(): array
    {
        $selectedSort = $_POST['select_sort'];
        global $conn;
        if ($selectedSort == "crescator") {
            $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products WHERE is_makeup=1 ORDER BY price");
        } else if ($selectedSort == "descrescator") {
            $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products WHERE is_makeup=1 ORDER BY price DESC");
        } else if ($selectedSort == "rating") {
            $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products WHERE is_makeup=1 ORDER BY times_rec");
        }
        $stmt->execute();
        $stmt->bind_result($product_id, $name, $price, $image_path, $description, $link);
        $results = array();
        while ($stmt->fetch()) {
            $makeup = array(
                'id' => $product_id,
                'name' => $name,
                'price' => $price,
                'image_path' => $image_path,
                'description' => $description,
                'link' => $link
            );
            $results[] = $makeup;
        }


        return $results;
    }

    /**
     * @return array - an array of sorted products by general products. Made for the mobile version of the app.
     */

    public static function getProductsBySortGeneralProducts(): array
    {
        $selectedBox = "";
        $checkboxes = $_POST['checkboxGroup'] ?? array();
        if (!is_array($checkboxes)) {
            $checkboxes = [$checkboxes];
        }
        $checkbox1 = in_array('checkbox1', $checkboxes);
        $checkbox2 = in_array('checkbox2', $checkboxes);
        $checkbox3 = in_array('checkbox3', $checkboxes);
        $checkbox4 = in_array('checkbox4', $checkboxes);
        $checkbox5 = in_array('checkbox5', $checkboxes);
        $checkbox6 = in_array('checkbox6', $checkboxes);
        $checkbox7 = in_array('checkbox7', $checkboxes);
        $checkbox8 = in_array('checkbox8', $checkboxes);
        $checkbox9 = in_array('checkbox9', $checkboxes);
        global $conn;
        if ($checkbox1) {
            $is_makeup = 1;
            $selectedBox = $_POST['select_tip_machiaj'] ?? "";
            $stmt = $conn->prepare("SELECT p.product_id, p.name, p.price, p.image_path, p.description, p.link FROM products p JOIN product_types pt on p.type_id = pt.type_id where pt.product_type = ? and p.is_makeup = ?");
            $stmt->bind_param("si", $selectedBox, $is_makeup);
        } elseif ($checkbox2) {
            $is_makeup = 0;
            $selectedBox = $_POST['select_prod_ing'] ?? "";
            $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products WHERE age IN (0, ?) and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox3) {
            $is_makeup = 1;
            $selectedBox = $_POST['select_ten_type'] ?? "";
            $stmt = $conn->prepare("SELECT p.product_id, p.name, p.price,  p.image_path, p.description, p.link FROM products p JOIN skintypes s on p.skintype_id = s.skintype_id where s.skin_type = ?");
            $stmt->bind_param("s", $selectedBox);
        } elseif ($checkbox4) {
            $is_makeup = 1;
            $selectedBox = $_POST['select_brand_makeup'] ?? "";
            $stmt = $conn->prepare("SELECT product_id, name, price, image_path, description,link FROM products  WHERE brand_id=? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox5) {
            $is_makeup = 0;
            $selectedBox = $_POST['select_brand_ingrijire'] ?? "";
            $stmt = $conn->prepare("SELECT product_id, name, price, image_path, description,link FROM products  WHERE brand_id=? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox6) {
            $selectedBox = $_POST['select_pret'] ?? "";
            if ($selectedBox == 0) {
                $maximPrice = 50;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            } else if ($selectedBox == 50) {
                $maximPrice = 100;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            } else if ($selectedBox == 100) {
                $maximPrice = 200;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            } else {
                $stmt = $conn->prepare("SELECT product_id,name, price,  image_path, description,link FROM products where price > ?");
                $stmt->bind_param("i", $selectedBox);
            }

        } elseif ($checkbox7) {
            $is_makeup = 1;
            $selectedBox = $_POST['select_utilizare_makeup'] ?? "";
            $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where type_id =? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox8) {
            $selectedBox = $_POST['select_utilizare_skincare'] ?? "";
            $is_makeup = 0;
            $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where type_id =? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox9) {
            $selectedBox = $_POST['select_tipul_skincare'] ?? "";
            if ($selectedBox == 0) {
                $maximPrice = 50;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            } else if ($selectedBox == 50) {
                $maximPrice = 100;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            } else if ($selectedBox == 100) {
                $maximPrice = 200;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            } else if ($selectedBox == 200) {
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products where price > ?");
                $stmt->bind_param("i", $selectedBox);
            } else {
                $is_makeup = 0;
                $stmt = $conn->prepare("SELECT product_id,name, price, image_path, description,link FROM products WHERE age= ? and is_makeup=?");
                $stmt->bind_param("ii", $selectedBox, $is_makeup);
            }
        }
        $stmt->execute();
        $stmt->bind_result($product_id, $name, $price, $image_path, $description, $link);
        $results = array();
        while ($stmt->fetch()) {
            $makeup = array(
                'id' => $product_id,
                'name' => $name,
                'price' => $price,
                'image_path' => $image_path,
                'description' => $description,
                'link' => $link
            );
            $results[] = $makeup;
        }
        return $results;
    }

    public function upload_file($file = null, $folder = "src/img")
    {
        if ($file === null) {
            $file = $_FILES['image'];
        }

        $server_path = '/home/makeupapp/public_html';
        $target_dir = $server_path . "/" . $folder . "/";
                
        if (!file_exists($target_dir)) {
            mkdir($target_dir, 0777, true);
        }

        $target_file = $target_dir . basename($file["name"]);
        $file_extension = strtolower(pathinfo($target_file, PATHINFO_EXTENSION));
        $file["name"] = basename($file["name"]);
        $target_file = $target_dir . basename($file["name"]);
        move_uploaded_file($file["tmp_name"], $target_file);

        $file_path = "/" . $folder . "/" . $file["name"];
        return $file_path;
    }

    public function saveProduct(){        
        $name = $_POST['name'];
        $price = $_POST['price'];
        $age = $_POST['age'];
        $link = $_POST['link'];
        $brand_id = $_POST['brand_id'];
        $skintype_id = $_POST['skintype_id'];
        $type_id = $_POST['type_id'];
        $times_rec = $_POST['times_rec'];
        $description = $_POST['description'];
        $ingredients = $_POST['ingredients'];
        $how_to_use = $_POST['how_to_use'];
        $is_makeup = $_POST['is_makeup'];
        $image_path = $this->upload_file();
        global $conn;
        $stmt = $conn->prepare("INSERT INTO products (name, price, image_path, is_makeup, age, brand_id, skintype_id, type_id, ingredients, description, how_to_use, link, times_rec) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssiiiiissssi", $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
        if ($stmt->execute()) {
            $stmt->close();
            return true;
        } else {
            $stmt->close();
            return false;
        }

    }

}