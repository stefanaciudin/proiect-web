<?php
$user='databaseAdmin';
$pass='Parola1234Server';
$conn= mysqli_init();
mysqli_ssl_set($conn, NULL, NULL, "DigiCertGlobalRootCA.crt.pem", NULL, NULL);
mysqli_real_connect($conn, 'coolmakeupserver.mysql.database.azure.com', $user, $pass, 'database_web', 3306, MYSQLI_CLIENT_SSL,MYSQLI_CLIENT_SSL_DONT_VERIFY_SERVER_CERT);
// if ($conn->connect_error) {
//    echo "Connection failed: " . $conn->connect_error;
// } else {
//    echo "Successfully connected to DB ";
// }