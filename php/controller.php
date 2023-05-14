<?php

// Require the User class and initialize the database connection
require_once 'User.php';
require_once 'bd.php';

// Define the endpoint for GET requests to /users/username
if ($_SERVER['REQUEST_METHOD'] === 'GET' && preg_match('/^\/users\/(.+)/', $_SERVER['REQUEST_URI'], $matches)) {
    $username = $matches[1];
    $user = User::findByUsername($username);
    if ($user) {
        header('Content-Type: application/json');
        echo json_encode([
            'name' => $user->getName(),
            'username' => $user->getUsername(),
        ]);
    } else {
        http_response_code(404);
    }
}
// Define the endpoint for GET requests to /users/id/username
if ($_SERVER['REQUEST_METHOD'] === 'GET' && preg_match('/^\/users\/(\d+)\/username/', $_SERVER['REQUEST_URI'], $matches)) {
    $id = $matches[1];
    $user = User::findUsernameById($id);
    if ($user) {
        header('Content-Type: application/json');
        echo json_encode([
            'username' => $user->getUsername(),
        ]);
    } else {
        http_response_code(404);
    }
}