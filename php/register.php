<?php
include_once 'bd.php';
include_once 'UserRepository.php';

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
if (UserRepository::save($user)) {
    session_start();
    //$_SESSION['user_id'] = $user->getUserId(); this returns an error
    $_SESSION['username'] = $user->getUsername();
    $_SESSION['name'] = $user->getName();

// redirect the user to the profile page
    header('Location: ../profile.html');
    exit();
} else {
    echo "Error while saving user";
}
