<?php
require_once 'bd.php';
require_once 'UserRepository.php';

session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // retrieve user from database
    $user = null;
    if (filter_var($username, FILTER_VALIDATE_EMAIL)) {
        $user = UserRepository::findByEmail($username);
    } else {
        $user = UserRepository::findByUsername($username);
    }
    if ($user && password_verify($password, $user->getPassword())) {
        // password is correct, log in user
        $_SESSION['user_id'] = $user->getUserId();
        $_SESSION['username'] = $user->getUsername();
        $_SESSION['name'] = $user->getName();

        header('Location: ../profile_page.php');
    } else {
        $_SESSION['error_message'] = 'Invalid username or password';
        //print in the console the error message
        error_log($_SESSION['error_message']);
        header('Location: ../login.html');
    }
    exit();
}
