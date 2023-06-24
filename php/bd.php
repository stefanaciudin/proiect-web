<?php
$servername = "localhost";
$dbname = "makeupapp_database_web";
$username = "makeupapp_makeupapp";
$password = "Makeupapp21!";

$conn = mysqli_init();
mysqli_real_connect($conn, $servername, $username, $password, $dbname);

// if ($conn->connect_error) {
//     die('Connection failed: ' . $conn->connect_error);
// } else {
//     echo 'Successfully connected to the database.';
// }

?>
