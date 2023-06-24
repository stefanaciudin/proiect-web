<?php
session_start();
//verific daca user ul e admin
include '../php/UserRepository.php';
include "../php/ProductRepository.php";
include "../php/VideoRepository.php";
$_SESSION['user'] = UserRepository::findUserById($_SESSION['user_id']);
if ($_SESSION['user']['admin'] != 1) {
    $_SESSION['user']['admin'] = 0;
    echo '<meta http-equiv="refresh" content="0; url=https://makeupapp.ro/index.html">';
    exit();
}

$user = new UserRepository();
$users = [];
$users = $user->getAllUsers();

?>

<!DOCTYPE html>
<html lang="ro">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="/css-files/admin.css">
</head>
<header>
    <div class="logo">
        <img src="/src/img/logo.png" alt="Logo" width="125" height="100">
    </div>
    <div class="topnav" id="myTopnav">
        <a href="produse.php">Produse</a>
        <a href="utilizatori.php">Utilizatori</a>
        <a href="../profile_page.php">My Account</a>
        <a href="javascript:void(0);" class="icon" onclick="myFunction()">
            <i class="fa fa-bars"></i>
        </a>
    </div>
</header>

<body class="container">
    <div class="table_content">
        <p>Aplicatia are <?php echo count($users); ?> utilizatori </p>
        <button><a href="adauga_utilizator.php">Adauga Utilizator</a></button>
        <table>
            <th>
                <tr>
                    <td>Nume</td>
                    <td>Username</td>
                    <td>Email</td>
                    <td>Delete</td>
                </tr>

            </th>

            <tbody>
                <?php
                foreach ($users as $user) {
                    echo '<tr>';
                    // echo '<td>'.$product['product_id'].'</td>';
                    echo '<td>' . $user['name'] . '</td>';
                    echo '<td>' . $user['username'] . '</td>';
                    echo '<td>' . $user['email'] . '</td>';
                    echo '<td><button class="delete" data-id="' . $user['user_id'] . '" data-name="' . $user['name'] . '">Delete</button></td>';
                    echo '</tr>';
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
<script>
    $(document).ready(function() {

        // Delete 
        $('.delete').click(function() {
            var el = this;

            // Delete id
            var deleteid = $(this).data('id');
            var userName = $(this).data('name');
            var confirmalert = confirm("Esti sigur ca vrei sa stergi utilizatorul " + userName + " ?");
            if (confirmalert == true) {
                // AJAX Request
                $.ajax({
                    url: '/admin/ajax/sterge_utilizator.php',
                    type: 'POST',
                    data: {
                        id: deleteid
                    },
                    success: function(response) {
                        console.log(response);
                        if (response == 1) {
                            alert('User sters');
                            location.reload();
                        } else {
                            alert('Actiune nepermisa');
                        }
                    }
                });
            }

        });

    });

    function myFunction() {
        var x = document.getElementById("myTopnav");
        if (x.className === "topnav") {
            x.className += " responsive";
        } else {
            x.className = "topnav";
        }
    }
</script>

</html>