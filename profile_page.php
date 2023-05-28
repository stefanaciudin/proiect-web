<!DOCTYPE html>
<html lang="en">

<?php
session_start();

// check if the logout button was clicked
if (isset($_POST['logout'])) {
    // clear all session variables
    session_unset();
    // destroy the session
    session_destroy();
    // redirect to login page
    header('Location: login_page.php');
    exit();
}
?>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
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
        <a href="rutina_ta.html">Rutina Mea</a>
        <a href="general_products.html">Recomandari Generale</a>
        <a href="makeup.html">Make Up</a>
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
        My Account
    </div>
    <div class="info">
        <p id="name-placeholder">
            Name
        </p>
        <p id="username-placeholder">
            @username
        </p>
    </div>
    <p>
        <label class="message" for="age"><b>Vârstă:</b></label>
    </p>
    <select name="age" id="age">
        <option value="younger_than_18">mai puțin de 18</option>
        <option value="18-25" selected>18-25</option>
        <option value="25-30">25-30</option>
        <option value="30-40">30-40</option>
        <option value="40-50">40-50</option>
        <option value="50-60">50-60</option>
        <option value="60+">peste 60</option>
    </select>

    <p>
        <label class="message" for="skin_type"><b>Tip de ten:</b></label>
    </p>
    <select name="skin_type" id="skin_type">
        <option value="oily" selected>Ten gras</option>
        <option value="normal">Ten normal</option>
        <option value="dry">Ten uscat</option>
        <option value="combination">Ten mixt</option>
    </select>
    <p>
        <label class="message" for="location"><b>Locație:</b></label>
    </p>
    <select name="location" id="location">
        <option value="europe" selected>Europa</option>
        <option value="asia">Asia</option>
        <option value="africa">Africa</option>
        <option value="north_america">America de nord</option>
        <option value="south_america">America de sud</option>
        <option value="australia">Australia</option>
        <option value="antarctica">Antarctica</option>
    </select>
    <form method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" class="logout-form">
        <p>
            <button type="submit" name="logout" class="button">Logout</button>
        </p>
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
<script type="text/javascript">
    var xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function () {
        if (xhr.readyState === XMLHttpRequest.DONE) {
            if (xhr.status === 200) {
                var response = JSON.parse(xhr.responseText);
                var username = response.username;
                var name = response.name;
                var surname = response.surname;
                // update the placeholder with the actual username
                document.getElementById("name-placeholder").innerHTML = name + " " + surname;
                document.getElementById("username-placeholder").innerHTML = "@" + username;
            } else {
                // Handle error case
                var errorMessage = "Error: " + xhr.status + " - " + xhr.statusText;
                console.error(errorMessage);
            }
        }
    };
    var user_id = "<?php
        error_log($_SESSION['user_id']);echo $_SESSION['user_id']; ?>";
    xhr.open("GET", "http://127.0.0.1:8000/api/find-user-by-id.php?id=" + user_id, true);
    xhr.send();

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