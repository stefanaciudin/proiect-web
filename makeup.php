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

<div id="page">
    <div class="left_menu" id="my_left_menu">
        <p>Brand:</p>
        <select name="brand" id="brand">
            <!-- Options will be populated dynamically -->
        </select>
        <p>Tipul produsului:</p>
        <select name="product_type" id="product_type">
            <option value="ten">Ten</option>
            <option value="ochi">Ochi</option>
            <option value="buze">Buze</option>
        </select>
        <p>Utilizarea produsului:</p>
        <select name="usage_type" id="usage_type">
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
    // Function to fetch data from an API
    function fetchData(url, propertyName) {
        return fetch(url)
            .then(response => response.json())
            .then(data => {
                if (propertyName) {
                    return data[propertyName]; // Return the property value if provided
                }
                return data;
            })
            .catch(error => console.log('Error:', error));
    }

    // Function to populate a select menu
    function populateSelectMenu(menuId, options, propertyName) {
        const menu = document.getElementById(menuId);
        menu.innerHTML = '';

        options.forEach(option => {
            const menuOption = document.createElement('option');
            menuOption.value = option[propertyName]; // Access the brand name property
            menuOption.text = option[propertyName];
            menu.appendChild(menuOption);
        });
    }

    // Function to handle brand or usage type change events
    function handleSelectChange(event, apiUrl, callback) {
        const selectedValue = event.target.value;
        const url = `${apiUrl}${encodeURIComponent(selectedValue)}`;

        fetchData(url)
            .then(data => {
                callback(data);
            });
    }

    // Function to create and append product elements
    function createProductElements(products) {
        const productsContainer = document.getElementById('products');
        productsContainer.innerHTML = '';

        if (products.message === "No products found for the given brand.") {
            const message = document.createElement('p');
            message.textContent = 'Nu există produse de makeup disponibile pentru această categorie. Vă rugăm să alegeți altă categorie.';
            productsContainer.appendChild(message);
        } else {
            products.forEach(product => {
                // Create product container
                const productContainer = document.createElement('div');
                productContainer.classList.add('product-container');

                // Create product image
                const productImageLink = document.createElement('a');
                productImageLink.href = product.link;
                const productImage = document.createElement('img');
                productImage.classList.add('product-img');
                productImage.src = product.image_path;
                productImage.alt = product.name;
                productImageLink.appendChild(productImage);
                productContainer.appendChild(productImageLink);

                // Create product name
                const productName = document.createElement('p');
                productName.classList.add('product-name');
                productName.textContent = product.name;
                productContainer.appendChild(productName);

                // Append product container to the products container
                productsContainer.appendChild(productContainer);
            });
        }
    }

    // Fetch product brands and populate the brand menu
    fetchData('http://127.0.0.1:8000/api/find-all-brands-by-product-type.php?product_category=1', 'brands')
        .then(data => {
            populateSelectMenu('brand', data, 'brand_name'); // Specify the brand_name property

            // Trigger the change event for the brand menu to load products of the first brand
            document.getElementById('brand').dispatchEvent(new Event('change'));
        });

    // Fetch product usage types and populate the usage type menu
    fetchData('http://127.0.0.1:8000/api/find-product-usage-types.php?product_category=1')
        .then(data => {
            console.log("here", data);
            populateSelectMenu('usage_type', data.usage_types, 'usage_type_name');
        });

    // Event listener for brand change
    document.getElementById('brand').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-products-by-brand-and-category.php?product_category=1&brand_name=', createProductElements);
    });

    // Event listener for product type change
    document.getElementById('product_type').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-makeup-products-by-type.php?type=', createProductElements);
    });

    // Event listener for usage type change
    document.getElementById('usage_type').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-products-by-usage-type.php?product_category=1&usage_type=', createProductElements);
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