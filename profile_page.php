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
        <a href="rutina_ta.php">Rutina Mea</a>
        <a href="general_products.html">Recomandari Generale</a>
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
        My Account
    </div>
    <div class="info">
        <p id="username-placeholder">
            @username
        </p>
    </div>
    <p>
        <label class="message" for="age"><b>Vârstă:</b></label>
    </p>
    <select name="age" id="age">
        <option value="18-35" selected>Ten tânăr: 18-35 de ani</option>
        <option value="35+">Ten matur: peste 35 de ani</option>
        <option value="not-spec">Nu doresc să specific</option>
    </select>

    <p>
        <label class="message" for="gender"><b>Gen:</b></label>
    </p>
    <select name="gender" id="gender">
        <option value="fem" selected>Feminin</option>
        <option value="masc">Masculin</option>
        <option value="not-spec">Nu doresc să specific</option>
    </select>
    <p>
        <label class="message" for="skin_type"><b>Tip de ten:</b></label>
    </p>
    <select name="skin_type" id="skin_type">
        <option value="oily">Ten gras</option>
        <option value="normal" selected>Ten normal</option>
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
    <form method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" class="logout-form">
        <p>
            <button type="submit" name="delete" class="button">Delete Account</button>
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
    function deleteUser() {
        // confirm the deletion
        if (confirm("Are you sure you want to delete your account? This action cannot be undone.")) {
            // create an XMLHttpRequest object
            var deleteXhr = new XMLHttpRequest();
            deleteXhr.onreadystatechange = function() {
                if (deleteXhr.readyState === XMLHttpRequest.DONE) {
                    if (deleteXhr.status === 200) {
                        // user deleted successfully
                        alert("User deleted successfully.");
                        // redirect to the login page
                        window.location.href = "login_page.php";
                    } else {
                        // error occurred while deleting the user
                        alert("Error deleting the user.");
                    }
                }
            };

            var user_id = "<?php echo $_SESSION['user_id']; ?>";
            var deleteUrl = "http://127.0.0.1:8000/api/delete-user-by-id.php?id=" + user_id;
            deleteXhr.open("GET", deleteUrl, true);
            deleteXhr.send();
        }
    }

    // Add the click event listener to the delete button
    var deleteButton = document.querySelector('button[name="delete"]');
    deleteButton.addEventListener("click", deleteUser);
    // Fetch user profile information on page load
    var profileXhr = new XMLHttpRequest();
    profileXhr.onreadystatechange = function () {
        if (profileXhr.readyState === XMLHttpRequest.DONE) {
            if (profileXhr.status === 200) {
                var response = JSON.parse(profileXhr.responseText);
                var username = response.username;
                var name = response.name;
                var surname = response.surname;

                // Update the placeholder with the actual username
                document.getElementById("username-placeholder").innerHTML = name + " " + surname + ", " + "@" + username;

                // Populate the form with the retrieved user profile information
                document.getElementById("age").value = response.age;
                document.getElementById("gender").value = response.gender;
                document.getElementById("skin_type").value = response.skin_type;
                document.getElementById("location").value = response.location;
            } else {
                // Handle error case
                var errorMessage = "Error: " + profileXhr.status + " - " + profileXhr.statusText;
                console.error(errorMessage);
            }
        }
    };

    var user_id = "<?php echo $_SESSION['user_id']; ?>";
    profileXhr.open("GET", "http://127.0.0.1:8000/api/find-user-by-id.php?id=" + user_id, true);
    profileXhr.send();

    // Update profile information on form submission
    document.getElementById('age').addEventListener('change', updateProfile);
    document.getElementById('gender').addEventListener('change', updateProfile);
    document.getElementById('skin_type').addEventListener('change', updateProfile);
    document.getElementById('location').addEventListener('change', updateProfile);

    function updateProfile() {
        var age = document.getElementById('age').value;
        var gender = document.getElementById('gender').value;
        var skinType = document.getElementById('skin_type').value;
        var location = document.getElementById('location').value;

        var updateXhr = new XMLHttpRequest();
        updateXhr.onreadystatechange = function () {
            if (updateXhr.readyState === XMLHttpRequest.DONE) {
                if (updateXhr.status === 200) {
                    // Handle success case
                    console.log('Profile updated successfully.');
                } else {
                    // Handle error case
                    var errorMessage = 'Error: ' + updateXhr.status + ' - ' + updateXhr.statusText;
                    console.error(errorMessage);
                }
            }
        };

        var updateUrl = 'http://127.0.0.1:8000/api/update-user-profile.php?id=' + user_id;
        var params = 'age=' + encodeURIComponent(age) + '&gender=' + encodeURIComponent(gender) + '&skin_type=' + encodeURIComponent(skinType) + '&location=' + encodeURIComponent(location);

        updateXhr.open('POST', updateUrl, true);
        updateXhr.setRequestHeader('Content-type', 'application/x-www-form-urlencoded');
        updateXhr.send(params);
    }

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