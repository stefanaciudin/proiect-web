<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

include_once '../php/UserRepository.php';
if (isset($_GET['id'])) {
    $userId = $_GET['id'];
    $user = UserRepository::findUserById($userId);
    if ($user) {
        $response = array(
            'username' => $user->getUsername(),
            'name' => $user->getName(),
            'surname' => $user->getSurname(),
            'email' => $user->getEmail(),
            'age' => $user->getAge(),
            'gender' => $user->getGender(),
            'skin_type' => $user->getSkinType(),
            'location' => $user->getLocation(),
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

