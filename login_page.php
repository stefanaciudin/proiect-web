<!DOCTYPE html>
<html lang="ro">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css-files/login.css">
    <link rel="stylesheet" href="css-files/profile.css">
    <link rel="stylesheet" href="css-files/index-page.css">


</head>

<body style="background: linear-gradient(to bottom, #e3d1dd, white);">
<header>
    <div class="logo">
        <img src="src/img/logo.png" alt="Logo" width="125" height="100">
    </div>
    <div class="topnav" id="myTopnav">
        <a href="index.html">Home</a>
        <a href="about.html">About</a>
        <a href="rutina_ta.php">Rutina Mea</a>
        <a href="general_products.php">Recomandari Generale</a>
        <a href="makeup.php">Make Up</a>
        <a href="login_page.php">Login</a>
        <a href="register_page.php">Register</a>
        <a href="profile_page.php">My Account</a>
        <a href="contact.html">Contact</a>
        <a href="javascript:void(0);" class="icon" onclick="myFunction()">
            <i class="fa fa-bars"></i>
        </a>
    </div>
</header>
<div class="form">
    <div class="account">
        Login
    </div>
    <p></p>
    <form action="php/login.php" method="POST" class="login-form">
        <input type="text" name="username" placeholder="Username / Email" required>
        <input type="password" name="password" placeholder="Parolă" required>
        <button type="submit" class="button">Login</button>
        <?php
        session_start();
        if (isset($_SESSION['error_message'])) {
            echo '<p class="message"><b>' . $_SESSION['error_message'] . '</b></p>';
            unset($_SESSION['error_message']);
        }
        ?>
        <p class="message"><b>User nou?<a href="register_page.php"> Creați un cont aici.</a></b></p>
    </form>
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