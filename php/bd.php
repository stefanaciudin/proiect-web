<?php
$user='meow';
$pass='P6hegTYFwcHerTP543ThGhyU5';
$conn = mysqli_init();
mysqli_ssl_set($conn, NULL, NULL, "DigiCertGlobalRootCA.crt.pem", NULL, NULL);
mysqli_real_connect($conn, '34.175.252.199', $user, $pass, 'database_web', 3306, MYSQLI_CLIENT_SSL,MYSQLI_CLIENT_SSL_DONT_VERIFY_SERVER_CERT);
// if ($conn->connect_error) {
//    echo "Connection failed: " . $conn->connect_error;
// } else {
//    echo "Successfully connected to DB ";
// }
