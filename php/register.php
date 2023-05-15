<?php
include_once 'bd.php';
include_once 'User.php';

$name = $_POST['firstname'];
$surname = $_POST['lastname'];
$username = $_POST['username'];
$email = $_POST['email'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);

// validate email input
// did that in the html page but ill keep it here, for some reason i can send
// things like mail@mail from there
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $error_message = 'Invalid email format';
    echo $error_message;
    exit();
}

$user = new User($name, $surname, $username, $email, $password);

// save the user to the database
if ($user->save()) {
    session_start();
    header('Location: ../profile.html');
    //$_SESSION['user_id'] = $user->getUserId(); ???
    exit();
} else {
    echo "Error while saving user";
}

