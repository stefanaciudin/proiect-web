<?php

include_once 'bd.php';
include_once 'UserRepository.php';

$name = $_POST['firstname'];
$surname = $_POST['lastname'];
$username = $_POST['username'];
$email = $_POST['email'];
$password = password_hash($_POST['password'], PASSWORD_DEFAULT);

// validate email input
// did that in the html page, but I'll keep it here, for some reason I can send
// things like mail@mail from there
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    session_start();
    $error_message = 'Invalid email format';
    $_SESSION['email_error'] = $error_message;
    header('Location: ../register_page.php');
    error_log($error_message);
    exit();
}

// check if the email or username already exists in the database
if (UserRepository::findByEmail($email)) {
    session_start();
    $error_message = 'Email already exists. Please use a different email.';
    $_SESSION['email_error'] = $error_message;
    header('Location: ../register_page.php');
    error_log($error_message);
    exit();
}

if (UserRepository::findByUsername($username)) {
    session_start();
    $error_message = 'Username already exists. Please choose a different username.';
    $_SESSION['username_error'] = $error_message;
    header('Location: ../register_page.php');
    error_log($error_message);
    exit();
}

$user = new User($name, $surname, $username, $email, $password);

// save the user to the database
if (UserRepository::save($user)) {
    session_start();
    $_SESSION['username'] = $user->getUsername();
    $_SESSION['name'] = $user->getName();

// redirect the user to the profile page
    header('Location: ../profile_page.php');
} else {
    $error_message = 'Error while saving user';
    $_SESSION['error_message'] = $error_message;
    error_log($error_message);
    header('Location: ../register_page.php');
    exit();
}
