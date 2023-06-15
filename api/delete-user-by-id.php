<?php
include_once '../php/UserRepository.php';
if (!isset($_GET['id'])) {
    http_response_code(400); // bad Request
    exit();
}

$user_id = $_GET['id'];

if (UserRepository::deleteUser($user_id)) {
    http_response_code(200);
} else {
    http_response_code(500);
}
