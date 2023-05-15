<?php
$CONFIG = [
    'servername' => "localhost",
    'username' => "root",
    'password' => "root",
    'db' => 'database_web'
];

$conn = new mysqli($CONFIG["servername"], $CONFIG["username"], $CONFIG["password"], $CONFIG["db"]);
//if ($conn->connect_error) {
//    echo "Connection failed: " . $conn->connect_error;
//} else {
//    echo "Successfully connected to DB ";
//}

