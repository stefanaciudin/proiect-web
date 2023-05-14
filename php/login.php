<?php
require_once 'bd.php';
require_once 'User.php';

session_start();

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $username = $_POST['username'];
    $password = $_POST['password'];

    // retrieve user from database
    $user = null;
    if (filter_var($username, FILTER_VALIDATE_EMAIL)) {
        $user = User::findByEmail($username);
    } else {
        $user = User::findByUsername($username);
    }
    if ($user && password_verify($password, $user->getPassword())) {
        // password is correct, log in user
        $_SESSION['user_id'] = $user->getUserId();
        header('Location: ../profile.html');
        exit();
    } else {
        $error_message = 'Invalid username or password';
        echo($error_message);
    }
}