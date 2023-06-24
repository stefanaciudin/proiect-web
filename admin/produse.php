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

$product = new ProductRepository();
$products = [];
$products = $product->getAllProducts();
?>
<!DOCTYPE html>
<html lang="ro">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
    <p>Aplicatia are <?php echo count($products); ?> produse </p>
    <button><a href="adauga_produs.php">Adauga Produs</a></button>
    <div class="table_content" >
        <table>
            <th>
                <tr>
                    <td>Nume</td>
                    <td>Pret</td>
                    <td>Delete</td>
                </tr>
            </th>
            <tbody>
                <?php 
                foreach($products as $product){
                    echo '<tr>';
                    // echo '<td>'.$product['product_id'].'</td>';
                    echo '<td>'.$product['name'].'</td>';
                    echo '<td>'.$product['price'].'</td>';
                    echo '<td><button class="delete" data-id="'.$product['product_id'].'" data-name="'.$product['name'].'">Delete</button></td>';
                    echo '</tr>';
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
<script>

    $(document).ready(function(){

        // Delete 
        $('.delete').click(function(){
        var el = this;

        // Delete id
        var deleteid = $(this).data('id');
        var productName = $(this).data('name');
        var confirmalert = confirm("Esti sigur ca vrei sa stergi "+ productName +" ?");
          if (confirmalert == true) {
             // AJAX Request
             $.ajax({
               url: '/admin/ajax/sterge_produs.php',
               type: 'POST',
               data: { id:deleteid },
               success: function(response){
                console.log(response);
                 if(response == 1){
                    alert('Produs sters');
                    location.reload();
                }else{
               alert('Invalid ID.');
                }
                }
             });
          }

        });
});
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