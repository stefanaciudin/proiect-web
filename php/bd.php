<?php
$user='makeupapp_makeupapp';
$pass='Makeupapp21!';
$conn = mysqli_init();
mysqli_ssl_set($conn, NULL, NULL, NULL, NULL, NULL);
mysqli_real_connect($conn, 'makeupapp.ro', $user, $pass, 'makeupapp_database_web', 3306);
// if ($conn->connect_error) {
//    echo "Connection failed: " . $conn->connect_error;
// } else {
//    echo "Successfully connected to DB ";
// }


?>

