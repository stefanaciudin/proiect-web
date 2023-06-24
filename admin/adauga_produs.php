<?php
session_start();
//verific daca user ul e admin
include '../php/UserRepository.php';
include "../php/ProductRepository.php";
include "../php/VideoRepository.php";
$_SESSION['user'] = UserRepository::findUserById($_SESSION['user_id']);
if($_SESSION['user']['admin'] != 1){
    $_SESSION['user']['admin'] = 0;
    echo '<meta http-equiv="refresh" content="0; url=https://makeupapp.ro/index.html">';
    exit();
}
$prod = new ProductRepository;
if(isset($_POST['save'])){
    $prod->saveProduct();
}

?>

<!DOCTYPE html>
<html lang="ro">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css-files/admin.css">
</head>

<header>
        <div class="logo">
            <img src="/src/img/logo.png" alt="Logo" width="125" height="100">
        </div>
        <div class="topnav" id="myTopnav">
            <a href="produse.php">Produse</a>
            <a href="utilizatori.php">Utilizatori</a>
            <a href="../profile_page.php">My Account</a>
            <a href="javascript:void(0);" class="icon" onclick="myFunction()">
                <i class="fa fa-bars"></i>
            </a>
        </div>

</header>

<body class="container">
<div class="form">
    <div class="account">
        Adauga Produs
    </div>
    <p></p>
    <form action="adauga_produs.php" method="POST" class="login-form" enctype="multipart/form-data">
        <input type="text" name="name" placeholder="Nume Produs">
        <input type="number" name="price" placeholder="Pret">
        <input type="text" name="age" placeholder="Varsta">
        <input type="text" name="link" placeholder="Link produs">
        <select name="brand_id" class="select_brands">
            <?php
            $brands = $prod->getAllProductBrands();
                foreach ($brands as $brand) {
                    $id = $brand['brand_id'];
                    $name = $brand['brand_name'];
                    echo "<option value='$id'>$name</option>";
                }
            ?>
         </select><br>
         <select name="skintype_id" class="select_skin">
            <?php
            $skins = $prod->getAllSkincare();
                foreach ($skins as $skin) {
                    $id = $skin['skintype_id'];
                    $name = $skin['skin_type'];
                    echo "<option value='$id'>$name</option>";
                }
            ?>
         </select><br>
         <select name="type_id" class="select_type">
            <?php
            $types = $prod->getAllProductsType();
                foreach ($types as $type) {
                    $id = $type['type_id'];
                    $name = $type['usage_type'];
                    echo "<option value='$id'>$name</option>";
                }
            ?>
         </select><br>
        <input type="text" name="times_rec" placeholder="Reating">
        <textarea id="message" name="description" placeholder="Descriere"></textarea>
        <textarea id="message" name="ingredients" placeholder="Ingrediente"></textarea>
        <textarea id="message" name="how_to_use" placeholder="Mod de utilizare"></textarea>
        <div class="radio-group">
          <label>
            <input type="radio" name="is_makeup" value="1">Produs MakeUp
          </label>
          <label>
            <input type="radio" name="is_makeup" value="0">Produs Skincare
          </label>
        </div>
        <div class="form-group">
            <input type="file" id="image" name="image" accept="image/*">
        </div>
        <input type="submit" class="button" name="save" value="Salveaza Produsul">
    </form>
</div>

    
</body>   
    <script>
        function myFunction() {
            var x = document.getElementById("myTopnav");
            if (x.className === "topnav") {
                x.className += " responsive";
            } else {
                x.className = "topnav";
            }
        }
    </script>

</html>