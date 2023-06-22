<?php
include "php/UserRepository.php";
?>
<!DOCTYPE html>
<html lang="en">

<?php
session_start();
$user = [];
$userRepository = new UserRepository();
if (isset($_POST['logout'])) {
    session_unset();
    session_destroy();
    header('Location: login_page.php');
    exit();
} else if (isset($_POST['save'])) {
    $token = $_POST['token'];
    if ($token == $_SESSION['form-token']) {
        $_SESSION['form-token'] = '';
        $userRepository->update($_SESSION['user_id']);

    } else {
        header('Location: login_page.php');
        exit();
    }

} else if (isset($_POST['delete'])) {
    $userRepository->deleteUser($_SESSION['user_id']);
    header('Location: login_page.php');
    exit();
}

if (isset($_SESSION['user'])) {
    $user = $userRepository->findUserById($_SESSION['user_id']);
}

$token = bin2hex(random_bytes(50));
$_SESSION['form-token'] = $token;

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
<?php
if (!isset($_SESSION['user'])) {
    echo "<p>Pentru a vedea această pagină, trebuie să intrați în cont.</p>";
} else {
    ?>
    <div class="form">
        <div class="account">
            My Account
        </div>
        <div class="info">
            <p id="username-placeholder">
                <?php
                if ($user != []) {
                    echo $user['username'];
                } else {
                    echo "@username";
                }
                ?>

            </p>
        </div>
        <form action="profile_page.php" method="POST">
            <p>
                <label class="message" for="age"><b>Vârstă:</b></label>
            </p>
            <select name="age" id="age">
                <option value="18" <?php if (isset($user['age']) && $user['age'] == '18') echo 'selected'; ?>>Ten tânăr:
                    18-35 de ani
                </option>
                <option value="35" <?php if (isset($user['age']) && $user['age'] == '35') echo 'selected'; ?>>Ten matur:
                    peste 35 de ani
                </option>
                <option value="0" <?php if (isset($user['age']) && $user['age'] == '0') echo 'selected'; ?>>Nu doresc să
                    specific
                </option>
            </select>

            <p>
                <label class="message" for="gender"><b>Gen:</b></label>
            </p>
            <select name="gender" id="gender">
                <option value="f" <?php if (isset($user['gender']) && $user['gender'] == 'f') echo 'selected'; ?>>
                    Feminin
                </option>
                <option value="m" <?php if (isset($user['gender']) && $user['gender'] == 'm') echo 'selected'; ?>>
                    Masculin
                </option>
                <option
                    value="not-spec" <?php if (isset($user['gender']) && $user['gender'] == 'not-spec') echo 'selected'; ?>>
                    Nu doresc să specific
                </option>
            </select>
            <p>
                <label class="message" for="skin_type"><b>Tip de ten:</b></label>
            </p>
            <select name="skin_type" id="skin_type">
                <option
                    value="gras" <?php if (isset($user['skintype_id']) && $user['skintype_id'] == 1) echo 'selected'; ?>>
                    Ten gras
                </option>
                <option
                    value="normal" <?php if (isset($user['skintype_id']) && $user['skintype_id'] == 2) echo 'selected'; ?>>
                    Ten normal
                </option>
                <option
                    value="uscat" <?php if (isset($user['skintype_id']) && $user['skintype_id'] == 4) echo 'selected'; ?>>
                    Ten uscat
                </option>
                <option
                    value="mixt" <?php if (isset($user['skintype_id']) && $user['skintype_id'] == 3) echo 'selected'; ?>>
                    Ten mixt
                </option>
            </select>
            <p>
                <label class="message" for="location"><b>Locație:</b></label>
            </p>
            <select name="location" id="location">
                <option
                    value="europe" <?php if (isset($user['location']) && $user['location'] == 'europe') echo 'selected'; ?>>
                    Europa
                </option>
                <option
                    value="asia" <?php if (isset($user['location']) && $user['location'] == 'asia') echo 'selected'; ?>>
                    Asia
                </option>
                <option
                    value="africa" <?php if (isset($user['location']) && $user['location'] == 'africa') echo 'selected'; ?>>
                    Africa
                </option>
                <option
                    value="north_america" <?php if (isset($user['location']) && $user['location'] == 'north_america') echo 'selected'; ?>>
                    America de nord
                </option>
                <option
                    value="south_america" <?php if (isset($user['location']) && $user['location'] == 'south_america') echo 'selected'; ?>>
                    America de sud
                </option>
                <option
                    value="australia" <?php if (isset($user['location']) && $user['location'] == 'australia') echo 'selected'; ?>>
                    Australia
                </option>
                <option
                    value="antarctica" <?php if (isset($user['location']) && $user['location'] == 'antarctica') echo 'selected'; ?>>
                    Antarctica
                </option>
            </select>
            <input type="hidden" value="<?php echo $token; ?>" name="token"/>
            <p>
                <input type="submit" class="button" value="Save" name="save">
            </p>
            <p>
                <input type="submit" class="button" value="Logout" name="logout">
            </p>
            <p>
                <input type="submit" class="button" value="Delete" name="delete">
            </p>

        </form>
    </div>
    <?php
} // End of if(isset($_SESSION['user']))
?>
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