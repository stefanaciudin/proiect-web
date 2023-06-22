<!doctype html>
<html lang="ro">
<head>
    <?php
    include "php/UserRepository.php";
    session_start();
    $user = [];
    $products_1 = [];
    $products_2 = [];
    $products_3 = [];
    $products_4 = [];
    $products_5 = [];
    $products_6 = [];
    $userRepository = new UserRepository();
    if (isset($_SESSION['user_id'])) {
        $user = $userRepository->findUserById($_SESSION['user_id']);
        $products_1 = $userRepository->findByUsageType($_SESSION['user_id'], 1, 'oricand');
        $products_2 = $userRepository->findByUsageType($_SESSION['user_id'], 3, 'oricand');
        $products_3 = $userRepository->findByUsageType($_SESSION['user_id'], 8, 'zi');
        $products_4 = $userRepository->findByUsageType($_SESSION['user_id'], 27, 'seara');
        $products_5 = $userRepository->findByUsageType($_SESSION['user_id'], 4, 'oricand');
        $products_6 = $userRepository->findByUsageType($_SESSION['user_id'], 2, 'oricand');

    }
    ?>
    <meta charset="UTF-8">
    <title>Rutina ta</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css-files/rutina_ta.css">
</head>

<body>
<header>
    <div class="logo">
        <img src="src/img/logo.png" alt="Logo" width="125" height="100">
    </div>

    <div class="topnav" id="myTopnav">
        <a href="index.html">Home</a>
        <a href="about.html">About</a>
        <a href="rutina_ta.php">Rutina Mea</a>
        <a href="general_products.php">Recomandari Generale</a>
        <a href="makeup.php">Make Up</a>
        <a href="login_page.php">Login</a>
        <a href="register_page.php">Register</a>
        <a href="profile_page.php">My Account</a>
        <a href="contact.html">Contact</a>
        <a href="javascript:void(0);" class="icon" onclick="myFunction()">
            <i class="fa fa-bars"></i>
        </a>
    </div>
</header>

<div class="content">

    <div id="introduction">
        <img src="src/img/first.jpg" alt="">

        <h1 class="first-text">Rutina ta de zi cu zi</h1>

        <p>Pielea și anexele sale, mai precis părul, unghiile, glandele sudoripare, sebacee și mamare
            alcătuiesc sistemul
            tegumentar. Principalul său rol este acela de a proteja organele interne de factorii externi dăunători, mai
            precis de bacterii, substanțe chimice și temperatură.

            Având în vedere faptul că pielea este cel mai mare organ al corpului uman, este necesar să știi cum să o
            îngrijești corespunzător, astfel încât să fie într-o condiție cât mai bună, o perioadă îndelungată de timp.
            De
            aceea, o rutina zilnică a feței, potrivită pentru tipul tău, de ten trebuie să reprezinte o necesitate în
            stilul
            tău de viață și să o realizezi zilnic.</p>

    </div>

    <div id="dimi">
        <h2 class="second-text">Dimineata</h2>
        <div class="lista">

            <div class="model_style_1">
                <img class="second-photo" src="src/img/dim1.avif" alt="">
                <div class="text">
                    <h4 class="bold">Pasul 1- Curatarea tenului</h4>
                    <p>Chiar dacă ai realizat această acțiune cu o seară în urmă, nu trebuie să treci la următorul pas,
                        deoarece
                        pe timpul
                        nopții, de pe fața de pernă, poți să iei pe ten diverse bacterii sau chiar praf. Alege din gama
                        de
                        produse a
                        magazinului unul pentru curățarea tenului și pentru îndepărtarea impurităților, potrivit pentru
                        tipul
                        tău de ten.
                        Acesta trebuie masat ușor în piele, fără a fi bruscată.</p>
                </div>
            </div>

            <h4 class="bold">Produse recomandate</h4>
            <div class="container" id="product-container-1">
                <?php
                showProducts($products_1);
                ?>
            </div>
        </div>

        <div class="lista">

            <div class="model_style_1">
                <div class="text">
                    <h4 class="bold">Pasul 2 - Exfolierea tenului</h4>
                    <p>Această acțiune este importantă, întrucât permite îndepărtarea celulelor moarte, conferind o bază
                        netedă
                        ideală
                        pentru aplicarea machiajului. Astfel, acesta se va așeza mult mai bine pe ten. Selectează unul
                        dintre
                        produsele
                        pentru exfoliere de la skinseen.ro, care poate fi aplicat pe față, gât și decolteu. Nu în
                        ultimul
                        rând,
                        pentru a-și
                        face efectul, trebuie ales în funcție de tipul tău de ten.</p>

                </div>
                <img class="second-photo" src="src/img/dim2.jpg" alt="">
            </div>


            <h4 class="bold">Produse recomandate</h4>
            <div class="container" id="product-container-2">
                <?php
                showProducts($products_2);
                ?>
            </div>
        </div>

        <div class="lista">
            <div class="model_style_1">
                <img class="second-photo" src="src/img/dim3.jpg" alt="">
                <div class="text">
                    <h4 class="bold">Pasul 3 - Hidratarea și protejarea tenului</h4>
                    <p>Acest pas presupune aplicarea unei creme hidratante cu SPF. Dacă aceasta nu conține SPF, trebuie
                        să
                        aplici o cremă
                        cu protecție solară după ce ai masat-o pe cea de dinainte bine în piele. E important de știut
                        faptul că,
                        un rol
                        esențial în îngrijirea zilnică a tenului îl are crema de față, întrucât hidratează tenul.
                        Totodată,
                        poate să
                        regenereze, să prevină și să amelioreze ridurile. Acest produs trebuie ales cu atenție, pe baza
                        nevoilor
                        tenului
                        tău. În plus, poți aplica un produs pentru buze, cum ar fi un balsam. Acesta are un rol de
                        hidratare și
                        nu trebuie
                        neglijat din rutina zilnică a feței.</p>

                </div>
            </div>
            <h4 class="bold">Produse recomandate</h4>
            <div class="container" id="product-container-3">
                <?php
                showProducts($products_3);
                ?>
            </div>
            <br><br>
        </div>
    </div>
    <div id="seara">
        <h2 class="second-text">Seara</h2>
        <div class="lista">

            <div class="model_style_1">
                <div class="text">
                    <h4 class="bold">Pasul 1 - Demachierea tenului</h4>
                    <p>E necesar ca de fiecare dată, înainte să te pui să dormi, să nu uiți să realizezi această
                        acțiune.
                        Pentru eliminarea machiajului trebuie să folosești un produs de demachiere, iar tot ceea ce
                        trebuie să
                        faci este să îndepărtezi delicat produsele cosmetice de pe față. La final, asigură-te că pe ten
                        nu au
                        mai rămas pete de fond de ten sau ruj pe buze care este rezistent la apă.</p>

                </div>
                <img class="second-photo" src="src/img/seara1.jpg" alt="">
            </div>

            <h4 class="bold">Produse recomandate</h4>
            <div class="container" id="product-container-4">
                <?php
                showProducts($products_4);
                ?>
            </div>
            <br><br>
        </div>
        <div class="lista">

            <div class="model_style_1">
                <img class="second-photo" src="src/img/seara2.png" alt="">
                <div class="text">
                    <h4 class="bold">Pasul 2 - Exfolierea tenului</h4>
                    <p>Acest pas, la fel ca cel precedent, nu trebuie neglijat. Concret, exfolierea feței trebuie
                        efectuată și
                        în rutina de seară pentru ten, pentru a îndepărta celulele moarte. În plus, vei permite o
                        absorbție mai
                        bună în ten a produselor pe care urmează să le aplici în continuare.</p>

                </div>

            </div>
            <h4 class="bold">Produse recomandate</h4>
            <div class="container" id="product-container-5">
                <?php
                showProducts($products_5);
                ?>
            </div>
            <br><br>
        </div>
        <div class="lista">

            <div class="model_style_1">
                <div class="text">
                    <h4 class="bold">Pasul 3 - Hidratarea si regenerarea tenului</h4>
                    <p>Acest ultim pas este extrem de important și trebuie realizat în mod regulat. E esențial ca după
                        ce
                        procesul de hidratare a tenului este finalizat, să se aplice un ser pentru față. În ceea ce
                        privește
                        produsele pentru hidratare, poți opta, de exemplu, pentru o mască pentru față cu efect de
                        calmare. Serul
                        trebuie ales în funcție de nevoile tale, având drept scop revitalizarea și regenerarea
                        pielii.</p>
                </div>
                <img class="second-photo" src="src/img/seara3.jpg" alt="">
            </div>

            <h4 class="bold">Produse recomandate</h4>
            <div class="container" id="product-container-6">
                <?php
                function showProducts(array $products_6): void
                {
                    if ($products_6 != []) {
                        foreach ($products_6 as $prod) {
                            echo '<div class="product">';
                            echo '<a href="' . $prod['link'] . '">';
                            // Image element
                            echo '<img src="' . $prod['image_path'] . '" alt="">';
                            // Product name and price
                            echo '<p><b>' . $prod['name'] . ' - ' . $prod['price'] . ' lei' . '</p></b>';
                            // Description
                            echo '<p>' . $prod['how_to_use'] . '</p>';
                            echo '</a>';
                            echo '</div>';
                        }
                    }
                }

                showProducts($products_6);
                ?>
            </div>
            <br><br>
        </div>
    </div>
</div>


<div class="footer">
    <div class="left">
        <p>Phone: 076755775</p>
    </div>
    <div class="center">
        <p>Email: web@gmail.com</p>
    </div>
    <div class="right">
        <p>Locatie: online</p>
    </div>
</div>
<script>
    function myFunction() {
        var x = document.getElementById("myTopnav");
        if (x.className === "topnav") {
            x.className += " responsive";
        } else {
            x.className = "topnav";
        }
    }
</script>
</body>

</html>