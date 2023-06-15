<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css-files/makeup.css">
    <title>Make-up</title>
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
        <a href="general_products.html">Recomandari Generale</a>
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

<div id="page">
    <div class="left_menu" id="my_left_menu">
        <p>Brand:</p>
        <select name="brand" id="brand">
            <!-- Options will be populated dynamically -->
        </select>
    </div>

    <div id="content">
        <div class="sort_filter">
            <div>Sortează</div>
            <div>Filtrează</div>
        </div>
        <div id="tutoriale">
            <div class="videos">
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
                <iframe src="https://www.youtube.com/embed/3x6FjMB1EdU" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
            </div>
        </div>
        <div id="products">
            <!-- Products will be populated dynamically -->
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
    // Fetch product brands and populate the brand menu
    fetch('http://127.0.0.1:8000/api/find-all-product-brands.php')
        .then(response => response.json())
        .then(data => {
            const brandMenu = document.getElementById('brand');
            brandMenu.innerHTML = '';

            data.brands.forEach(brand => {
                const option = document.createElement('option');
                option.value = brand.brand_name; // Set brand name as the option value
                option.text = brand.brand_name;
                brandMenu.appendChild(option);
            });
        })
        .catch(error => {
            console.log('Error:', error);
        });
    document.getElementById('brand').addEventListener('change', function () {
        const selectedBrand = this.value;
        console.log("selectedBrand", selectedBrand);
        fetch('http://127.0.0.1:8000/api/find-all-makeup-products-by-brand.php?brand_name=' + encodeURIComponent(selectedBrand))
            .then(response => response.json())
            .then(data => {
                console.log("data", data);
                const productsContainer = document.getElementById('products');
                productsContainer.innerHTML = '';
                if (data.message=== "No products found for the given brand.") {
                    const message = document.createElement('p');
                    message.textContent = 'Nu există produse de makeup de la acest brand în selecția noastră. Încercați un alt brand.';
                    productsContainer.appendChild(message);
                } else {
                    data.forEach(product => {
                        // Create product container
                        const productContainer = document.createElement('div');
                        productContainer.classList.add('product');

                        // Create product image
                        const productImageLink = document.createElement('a');
                        productImageLink.href = product.url;
                        const productImage = document.createElement('img');
                        productImage.src = product.image_path;
                        productImage.alt = product.name;
                        productImageLink.appendChild(productImage);
                        productContainer.appendChild(productImageLink);

                        // Create product name
                        const productNameLink = document.createElement('a');
                        productNameLink.href = product.url;
                        const productName = document.createElement('p');
                        productName.textContent = product.name;
                        productNameLink.appendChild(productName);
                        productContainer.appendChild(productNameLink);

                        // Append product container to products container
                        productsContainer.appendChild(productContainer);
                    });
                }
            })
            .catch(error => {
                console.log('Error:', error);
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

</body>

</html>
