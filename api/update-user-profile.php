<?php
include_once '../php/UserRepository.php';
session_start();
if (!isset($_SESSION['user_id'])) {
    // redirect to login page - display an error message
    header('Location: ../login_page.php');
    exit();
}

$user_id = $_SESSION['user_id'];

$user = UserRepository::findUserById($user_id);

if (!$user) {
    // user not found
    http_response_code(404);
    exit();
}

$age = $_POST['age'];
$gender = $_POST['gender'];
$skinType = $_POST['skin_type'];
$location = $_POST['location'];

if ($age === '18-35') {
    $age = 18;
} elseif ($age === '35+') {
    $age = 35;
} else {
    $age = 0;
}

if ($gender === 'masc') {
    $gender = 'm';
} elseif ($gender === 'fem') {
    $gender = 'f';
} else {
    $gender = 'n';
}

$skinType = match ($skinType) {
    'normal' => 2,
    'oily' => 1,
    'combination' => 3,
    'dry' => 4,
    default => 5,
};

$user->setAge($age);
$user->setGender($gender);
$user->setSkinType($skinType);
$user->setLocation($location);
$_SESSION['age'] = $age;
$_SESSION['gender'] = $gender;
$_SESSION['skin_type'] = $skinType;
$_SESSION['location'] = $location;

// save to database
if (UserRepository::update($user, $user_id)) {
    http_response_code(200);
} else {
    http_response_code(500);
}
exit();
