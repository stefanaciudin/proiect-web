<?php
header("Content-Type: application/x-www-form-urlencoded; charset=UTF-8");
include_once 'bd.php';
include_once 'UserRepository.php';
session_start();

$name = $_POST['firstname'];
$surname = $_POST['lastname'];
$username = $_POST['username'];
$email = $_POST['email'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);
$token = bin2hex(random_bytes(50));
error_log("Token:" . $token);

// validate email input
// did that in the html page, but I'll keep it here, for some reason I can send
// things like mail@mail from there
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $error_message = 'Invalid email format';
    $_SESSION['email_error'] = $error_message;
    session_write_close();
    header('Location: ../register_page.php');
    error_log($error_message);
    exit();
}

// check if the email or username already exists in the database
if (UserRepository::findByEmail($email)) {
    $error_message = 'Există deja un cont cu acest email.';
    $_SESSION['email_error'] = $error_message;
    session_write_close();
    header('Location: ../register_page.php');
    error_log($error_message);
    exit();
}

if (UserRepository::findByUsername($username)) {
    $error_message = 'Există deja un cont cu acest username.';
    $_SESSION['username_error'] = $error_message;
    session_write_close();
    header('Location: ../register_page.php');
    error_log($error_message);
    exit();
}

$user = new User($name, $surname, $username, $email, $password, $token);

// save the user to the database

if (UserRepository::save($user)) {
    // set the session id
    $_SESSION['user_id'] = UserRepository::returnMaxId();
    $_SESSION['username'] = $user->getUsername();
    $_SESSION['name'] = $user->getName();
    $_SESSION['token'] = $user->getToken();
    // redirect the user to the profile page
    session_write_close();
    header('Location: ../profile_page.php');
} else {
    $error_message = 'Error while saving user';
    $_SESSION['error_message'] = $error_message;
    error_log($error_message);
    session_write_close();
    header('Location: ../register_page.php');
    exit();
}