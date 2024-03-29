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

// if(isset($_POST['save'])){

// }
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
    <form action="save_user.php" method="POST" class="register-form" enctype="multipart/form-data" onsubmit="return validateForm()">
    <input type="email" name="email" placeholder="Adresă email" required>
        <input type="text" name="firstname" placeholder="Nume" required>
        <input type="text" name="lastname" placeholder="Prenume" required>
        <input type="text" name="username" placeholder="Username" required pattern="^[a-zA-Z0-9]{6,20}$"
               title="Username must be at least 6 characters long and contain only alphanumeric characters">
        <input type="password" name="password" id="password" placeholder="Password" required
               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
               title="Password must be at least 6 characters long, contain at least one lowercase letter, one uppercase letter, and one number">
        <input type="password" name="password_retype" id="password_retype" placeholder="Reintroduceți parola" required>
        <div class="radio-group">
          <label>
            <input type="radio" name="is_admin" value="1">Admin
          </label>
          <label>
            <input type="radio" name="is_admin" value="0">User
          </label>
        </div>
        <input type="submit" class="button" name="save" value="Salveaza User">
        <?php
        session_start();
        if (isset($_SESSION['email_error'])) {
            echo '<p class="message"><b>' . $_SESSION['email_error'] . '</b></p>';
            unset($_SESSION['email_error']);
        }
        if (isset($_SESSION['username_error'])) {
            echo '<p class="message"><b>' . $_SESSION['username_error'] . '</b></p>';
            unset($_SESSION['username_error']);
        }
        if (isset($_SESSION['error_message'])) {
            echo '<p class="message"><b>' . $_SESSION['error_message'] . '</b></p>';
            unset($_SESSION['error_message']);
        }
        ?>
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
        function validateForm() {
        const password = document.querySelector('input[name=password]');
        const confirm = document.querySelector('input[name=password_retype]');
        if (confirm.value === password.value) {
            confirm.setCustomValidity('');
            return true; // allow the form to submit
        } else {
            confirm.setCustomValidity('Passwords do not match');
            password.addEventListener('input', () => {
                if (confirm.value === password.value) {
                    confirm.setCustomValidity('');
                } else {
                    confirm.setCustomValidity('Passwords do not match');
                }
            });
            confirm.addEventListener('input', () => {
                if (confirm.value === password.value) {
                    confirm.setCustomValidity('');
                } else {
                    confirm.setCustomValidity('Passwords do not match');
                }
            });
            return false; // prevent the form from submitting
        }
    }
    </script>

</html>