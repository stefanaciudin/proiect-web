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
            self::updateTimesRec($product_id);
            $product = self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
            $products[] = $product;
        }

        $stmt->close();
        return $products;
    }

    public static function updateTimesRec($productId): void
    {
        global $conn;
        $stmt = $conn->prepare("UPDATE products SET times_rec = times_rec + 1 WHERE product_id = ?");
        $stmt->bind_param("i", $productId);
        $stmt->execute();
        $stmt->close();
    }

    public static function executeAndFetchProducts(mysqli_stmt $stmt): array
    {
        $stmt->execute();
        $stmt->store_result();
        $stmt->bind_result($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);

        // create an array to store the products
        $products = array();
        // fetch the products and create Product objects
        while ($stmt->fetch()) {
            $product = self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
            $products[] = $product;
        }

        $stmt->close();
        return $products;

    }

    public static function findMostRecProductsByAge($age): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE age = ? ORDER BY times_rec DESC LIMIT 10");
        $stmt->bind_param("i", $age);
        return self::executeAndFetchProducts($stmt);

    }

    public static function findMostRecProductsByPrice(mixed $min_price, mixed $max_price)
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE price BETWEEN ? AND ? ORDER BY times_rec DESC LIMIT 10");
        $stmt->bind_param("ii", $min_price, $max_price);
        return self::executeAndFetchProducts($stmt);
    }

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
        //error_log("Returning product: " . $product->getName() . " " . $product->getPrice() . " " . $product->getImagePath() . " " . $product->getIsMakeup() . " " . $product->getAge() . " " . $product->getBrandId() . " " . $product->getSkintypeId() . " " . $product->getTypeId() . " " . $product->getIngredients() . " " . $product->getDescription() . " " . $product->getHowToUse() . " " . $product->getLink());
        return self::getProduct($product_id, $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec);
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
     * @param $times_rec
     * @return Product
     */
    public static function getProduct(mixed $product_id, mixed $name, $price, $image_path, $is_makeup, $age, $brand_id, $skintype_id, $type_id, $ingredients, $description, $how_to_use, $link, $times_rec): Product
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

    public static function getProductsByBrand(mixed $brandName, mixed $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN brands b on p.brand_id = b.brand_id WHERE b.name = ? and p.is_makeup = ?");
        $stmt->bind_param("si", $brandName, $isMakeup);
        return self::executeAndFetchProducts($stmt);

    }


    public
    static function getProductsByType(mixed $product_type, mixed $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE pt.product_type = ? and p.is_makeup=?");
        $stmt->bind_param("si", $product_type, $isMakeup);
        return self::executeAndFetchProducts($stmt);
    }

    public
    static function getProductsByAge(mixed $age): array
    {
        // get only the first 2 letters of age - the age is sent weird here for some reason
        $age = substr($age, 0, 2);
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE (age = ? OR age = 0) AND is_makeup = 0 ORDER BY age DESC");
        $stmt->bind_param("i", $age);
        return self::executeAndFetchProducts($stmt);

    }

    public
    static function getProductsBySkintype(mixed $skintype_id): array
    {
        $skintype_id = substr($skintype_id, 0, 1);
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE (skintype_id = ? OR skintype_id = 5) AND is_makeup = 0 ORDER BY skintype_id, type_id");
        $stmt->bind_param("i", $skintype_id);
        return self::executeAndFetchProducts($stmt);
    }

    public
    static function getProductsByPrice(mixed $min_price, mixed $max_price): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT * FROM products WHERE price BETWEEN ? AND ? ORDER BY price, is_makeup");
        $stmt->bind_param("ii", $min_price, $max_price);
        return self::executeAndFetchProducts($stmt);
    }

    public
    static function getProductsByUsageType(mixed $usage_type, mixed $isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT p.* FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE pt.usage_type = ? and p.is_makeup=?");
        $stmt->bind_param("si", $usage_type, $isMakeup);
        return self::executeAndFetchProducts($stmt);
    }

    public
    static function getUsageTypes(mixed $is_makeup): array
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

    public
    static function getBrandsForMakeup(mixed $is_makeup): array
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
    public function getAllBrands(): array 
    {
        global $conn;
        $stmt = $conn->prepare("SELECT name, brand_id FROM brands ORDER BY name");
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
    public static function getProductsType($isMakeup): array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT DISTINCT pt.usage_type, pt.type_id FROM products p JOIN product_types pt on p.type_id = pt.type_id WHERE p.is_makeup=?");
        $stmt->bind_param("i" ,$isMakeup);
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
    public static function getUsageTypeByProductType($product_type) : array
    {
        global $conn;
        $stmt = $conn->prepare("SELECT usage_type,type_id FROM product_types  WHERE product_type=? ORDER BY usage_type");
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

    public static function getProductsBySort(): array
    {
        $selectedBox = "";
        $selectedBrand = $_POST['select1'];
        $checkboxes = isset($_POST['checkboxGroup']) ? $_POST['checkboxGroup'] : array();        
        if (!is_array($checkboxes)) {
            $checkboxes = [$checkboxes];
        }
        $checkbox1 = in_array('checkbox1', $checkboxes);
        $checkbox2 = in_array('checkbox2', $checkboxes);
        $checkbox3 = in_array('checkbox3', $checkboxes);

        if ($checkbox1) {
            $selectedBox = isset($_POST['select2']) ? $_POST['select2'] : "";
        } elseif ($checkbox2) {
            $selectedBox = isset($_POST['select3']) ? $_POST['select3'] : "";
        } elseif ($checkbox3) {
            $selectedBox = isset($_POST['select4']) ? $_POST['select4'] : "";
        } 

    
      global $conn;
      if($selectedBox == ""){
        $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products  WHERE brand_id=?");
        $stmt->bind_param("i", $selectedBrand);
      }else{
        $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products  WHERE brand_id=? and type_id = ?");
        $stmt->bind_param("ii", $selectedBrand, $selectedBox);
      }
      $stmt->execute();
      $stmt->bind_result($product_id,$name, $image_path, $description, $link);
      $results = array();
      while ($stmt->fetch()) {
          $makeup = array(
              'id' => $product_id,
              'name' => $name,
              'image_path' => $image_path,
              'description' => $description,
              'link' => $link
          );
          $results[] = $makeup;
      }

   
      return $results;
    }

    public static function getProductsByFilter(): array
    {
    $selectedSort = $_POST['select_sort'];           
    global $conn;   
    if($selectedSort == "crescator"){
        $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products ORDER BY price ASC");
    }else if ($selectedSort == "descrescator"){
        $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products ORDER BY price DESC");
    }else if($selectedSort == "rating"){
        $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products ORDER BY times_rec ASC");
    }
    $stmt->execute();
    $stmt->bind_result($product_id,$name, $image_path, $description, $link);
    $results = array();
    while ($stmt->fetch()) {
        $makeup = array(
            'id' => $product_id,
            'name' => $name,
            'image_path' => $image_path,
            'description' => $description,
            'link' => $link
        );
        $results[] = $makeup;
    }

   
      return $results;
    }

    public static function getProductsBySortGeneralProducts(): array
    {
        $selectedBox = "";
        $checkboxes = isset($_POST['checkboxGroup']) ? $_POST['checkboxGroup'] : array();        
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
            $selectedBox = isset($_POST['select_tip_machiaj']) ? $_POST['select_tip_machiaj'] : "";
            $stmt = $conn->prepare("SELECT p.product_id, p.name, p.image_path, p.description, p.link FROM products p JOIN product_types pt on p.type_id = pt.type_id where pt.product_type = ? and p.is_makeup = ?");
            $stmt->bind_param("si", $selectedBox ,$is_makeup );
        } elseif ($checkbox2) {
            $is_makeup = 0;
            $selectedBox = isset($_POST['select_prod_ing']) ? $_POST['select_prod_ing'] : "";
            $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products WHERE age IN (0, ?) and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox ,$is_makeup );
        } elseif ($checkbox3) {
            $is_makeup = 1;
            $selectedBox = isset($_POST['select_ten_type']) ? $_POST['select_ten_type'] : "";
            $stmt = $conn->prepare("SELECT p.product_id, p.name, p.image_path, p.description, p.link FROM products p JOIN skintypes s on p.skintype_id = s.skintype_id where s.skin_type = ?");
            $stmt->bind_param("s", $selectedBox );
        } elseif ($checkbox4) {
            $is_makeup = 1;
            $selectedBox = isset($_POST['select_brand_makeup']) ? $_POST['select_brand_makeup'] : "";
            $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products  WHERE brand_id=? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox,$is_makeup);
        } elseif ($checkbox5) {
            $is_makeup = 0;
            $selectedBox = isset($_POST['select_brand_ingrijire']) ? $_POST['select_brand_ingrijire'] : "";
            $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products  WHERE brand_id=? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox,$is_makeup);           
        } elseif ($checkbox6) {
            $selectedBox = isset($_POST['select_pret']) ? $_POST['select_pret'] : "";
            if($selectedBox == 0){
                $maximPrice = 50;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            }else if ($selectedBox == 50){
                $maximPrice = 100;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            }else if($selectedBox == 100){
                $maximPrice = 200;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            }else{
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ?");
                $stmt->bind_param("i", $selectedBox);
            }
            
        } elseif ($checkbox7) {
            $is_makeup = 1;
            $selectedBox = isset($_POST['select_utilizare_makeup']) ? $_POST['select_utilizare_makeup'] : "";
            $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where type_id =? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox8) {
            $selectedBox = isset($_POST['select_utilizare_skincare']) ? $_POST['select_utilizare_skincare'] : "";
            $is_makeup = 0;
            $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where type_id =? and is_makeup=?");
            $stmt->bind_param("ii", $selectedBox, $is_makeup);
        } elseif ($checkbox9) {
            $selectedBox = isset($_POST['select_tipul_skincare']) ? $_POST['select_tipul_skincare'] : "";
            if($selectedBox == 0){
                $maximPrice = 50;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            }else if ($selectedBox == 50){
                $maximPrice = 100;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            }else if($selectedBox == 100){
                $maximPrice = 200;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ? and price < ?");
                $stmt->bind_param("ii", $selectedBox, $maximPrice);
            }else if($selectedBox == 200){
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products where price > ?");
                $stmt->bind_param("i", $selectedBox);
            }
            else{
                $is_makeup = 0;
                $stmt = $conn->prepare("SELECT product_id,name, image_path, description,link FROM products WHERE age= ? and is_makeup=?");
                $stmt->bind_param("ii", $selectedBox ,$is_makeup );
            }
        } 

    
      $stmt->execute();
      $stmt->bind_result($product_id,$name, $image_path, $description, $link);
      $results = array();
      while ($stmt->fetch()) {
          $makeup = array(
              'id' => $product_id,
              'name' => $name,
              'image_path' => $image_path,
              'description' => $description,
              'link' => $link
          );
          $results[] = $makeup;
      }
      return $results;
    }
}
