<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
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
        Register
    </div>
    <p></p>
    <form name="register-form" action="php/register.php" method="POST" class="login-form"
          onsubmit="return validateForm()">
        <input type="email" name="email" placeholder="Adresă email" required>
        <input type="text" name="firstname" placeholder="Nume" required>
        <input type="text" name="lastname" placeholder="Prenume" required>
        <input type="text" name="username" placeholder="Username" required pattern="^[a-zA-Z0-9]{6,20}$"
               title="Username must be at least 6 characters long and contain only alphanumeric characters">
        <input type="password" name="password" id="password" placeholder="Password" required
               pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}"
               title="Password must be at least 6 characters long, contain at least one lowercase letter, one uppercase letter, and one number">
        <input type="password" name="password_retype" id="password_retype" placeholder="Reintroduceți parola" required>
        <button type="submit" class="button">Register</button>
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
</body>

</html>