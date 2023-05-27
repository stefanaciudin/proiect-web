<?php
$CONFIG = [
    'servername' => "coolmakeupserver.mysql.database.azure.com",
    'username' => "databaseAdmin",
    'password' => "Parola1234Server",
    'db' => 'database_web',
    'ssl' => true
];

$conn = new mysqli($CONFIG["servername"], $CONFIG["username"], $CONFIG["password"], $CONFIG["db"], 3306, );
if ($conn->connect_error) {
    echo "Connection failed: " . $conn->connect_error;
} else {
    echo "Successfully connected to DB ";
}

