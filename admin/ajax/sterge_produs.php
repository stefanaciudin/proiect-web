<?php
session_start();
//verific daca user ul e admin
include '../../php/UserRepository.php';
include "../../php/ProductRepository.php";
$_SESSION['user'] = UserRepository::findUserById($_SESSION['user_id']);
if($_SESSION['user']['admin'] != 1){
    $_SESSION['user']['admin'] = 0;
    echo '<meta http-equiv="refresh" content="0; url=https://makeupapp.ro/index.html">';
    exit();
}

if(isset($_POST['id']) && $_POST['id'] != ''){
    $product_id = $_POST['id'];
    if(ProductRepository :: delete($product_id)){
        echo 1;
    }else{
        echo 0;
    }
}