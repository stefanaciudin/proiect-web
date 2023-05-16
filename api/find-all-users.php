<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/UserRepository.php';
$users = UserRepository::getAllUsers();

if (!empty($users)) {
    $userArray = array();
    foreach ($users as $user) {
        $userItem = array(
            "name" => $user->getName(),
            "surname" => $user->getSurname(),
            "username" => $user->getUsername(),
            "email" => $user->getEmail(),
            "password" => $user->getPassword()
        );
        $userArray[] = $userItem;
    }

    $response = array();
    $response["body"] = $userArray;
    $response["itemCount"] = count($users);

    echo json_encode($response);
} else {
    http_response_code(404);
    echo json_encode(
        array("message" => "No users found.")
    );
}
