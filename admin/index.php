<?php
session_start();
//verific daca user ul e admin
include '../php/UserRepository.php';
include '../php/ProductRepository.php';

$_SESSION['user'] = UserRepository::findUserById($_SESSION['user_id']);
if($_SESSION['user']['admin'] != 1){
    $_SESSION['user']['admin'] = 0;
    echo '<meta http-equiv="refresh" content="0; url=https://makeupapp.ro/index.html">';
    exit();
}

$product = new ProductRepository();
$products = [];
$products = $product->getAllProducts();
$user = new UserRepository();
$users = [];
$users = $user->getAllUsers();
?>

<!DOCTYPE html>
<html lang="ro">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css-files/login.css">
    <link rel="stylesheet" href="/css-files/profile.css">
    <link rel="stylesheet" href="/css-files/index-page.css">


</head>

<body style="background: linear-gradient(to bottom, #e3d1dd, white);">
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
<div class="content">
    <div class="account">
        <p>Aplicatia are <?php echo count($users)?> user</p>
    </div>
    <div class="account">
    <p>Aplicatia are <?php echo count($products) ?> produse </p>
    </div>

</div>
    <div class="footer" style="position: absolute; bottom: 0;">
        <div class="left">
            <p>Phone:076755775</p>
        </div>
        <div class="center">
            <p>Email: web@gmail.com</p>
        </div>
        <div class="right">
            <p>location: online</p>
        </div>
    </div>
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
</body>

</html>