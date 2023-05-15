<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/bd.php';
include_once '../php/User.php';
if (isset($_GET['id'])) {
    $userId = $_GET['id'];
    $user = User::findUsernameById($userId);
    if ($user) {
        $response = array(
            'username' => $user->getUsername(),
            'name' => $user->getName(),
            'message' => 'User found.'
        );
        echo json_encode($response);
    } else {
        http_response_code(404);
        echo json_encode(
            array('message' => 'User not found.')
        );
    }
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. User ID is missing.')
    );
}

