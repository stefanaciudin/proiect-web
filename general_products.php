<?php
include "php/ProductRepository.php";
$product = new ProductRepository();
$products = $product->getProductsByBrands();

if(isset($_POST['submit'])){
    $products = $product->getProductsBySortGeneralProducts();
}
if(isset($_POST['submit_sort'])){
    $products = $product->getProductsByFilter();
}

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Produse generale</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css-files/general_products.css">
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
    <div class="left_menu">
        <p>Tipul machiaj:</p>
        <select name="product_type" id="product_type">
            <option value="ten">Ten</option>
            <option value="ochi">Ochi</option>
            <option value="buze">Buze</option>
        </select>
        <p>Produse de îngrijire pentru:</p>
        <select name="age" id="age">
            <option value="18-35" selected>Ten tânăr: 18-35 de ani</option>
            <option value="35+">Ten matur: peste 35 de ani</option>
            <option value="not-spec">Nu doresc să specific</option>
        </select>
        <p>Tip de ten:</p>
        <select name="ten" id="ten">
            <option value="ten_normal">Ten normal</option>
            <option value="ten_mixt">Ten mixt</option>
            <option value="ten_gras">Ten gras</option>
            <option value="ten_uscat">Ten uscat</option>
        </select>
        <p>Brand produse makeup:</p>
        <select name="brand-makeup" id="brand-makeup">
            <!-- Options will be populated dynamically -->
        </select>
        <p>Brand produse îngrijirea tenului:</p>
        <select name="brand-skincare" id="brand-skincare">
            <!-- Options will be populated dynamically -->
        </select>
        <p>Pret:</p>
        <select name="pret" id="pret">
            <option value="sub_50">Sub 50 de lei</option>
            <option value="50_99">50-99 de lei</option>
            <option value="100_199">100-199 de lei</option>
            <option value="peste_200">Peste 200 de lei</option>
        </select>
        <p>Utilizarea produsului de makeup:</p>
        <select name="usage_type_makeup" id="usage_type_makeup">
            <!-- Options will be populated dynamically -->
        </select>
        <p>Utilizarea produsului de skincare:</p>
        <select name="usage_type_skincare" id="usage_type_skincare">
            <!-- Options will be populated dynamically -->
        </select>
        <p>Topul produselor de skincare:</p>
        <div>
            <select name="top" id="top">
                <optgroup label="După vârstă:">
                    <option value="18" selected>Ten tânăr: 18-35 de ani</option>
                    <option value="35">Ten matur: peste 35 de ani</option>
                    <option value="0">Oricare</option>
                </optgroup>
                <optgroup label="După preț: ">
                    <option value="sub_50">Sub 50 de lei</option>
                    <option value="50_99">50-99 de lei</option>
                    <option value="100_199">100-199 de lei</option>
                    <option value="peste_200">Peste 200 de lei</option>
                </optgroup>
            </select>
        </div>

        <div style="margin-top: 10px;">
            <select name="format" id="format">
                <option value="rss">RSS</option>
                <option value="html">HTML</option>
                <option value="pdf">PDF</option>
            </select>
        </div>
        <button id="generateBtn" class="center-button">Generate</button>

    </div>
    <div class="products">
        <div class="sort_filter">
            <div>Sorteaza</div>
            <div>Filtreaza</div>
        </div>
        <div id="products">
            <!-- Products will be populated dynamically -->
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
                productName.textContent = product.name + " - " + product.price + " lei"
                productContainer.appendChild(productName);

                // Append product container to the products container
                productsContainer.appendChild(productContainer);
            });
        }
    }

    function generateTop(topValue, formatValue) {
        var endpoint = '';
        if (formatValue === 'rss') {
            if (topValue === '18') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-rss.php?age=18';
            } else if (topValue === '35') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-rss.php?age=35';
            } else if (topValue === '0') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-rss.php?age=0';
            } else if (topValue === 'sub_50') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-rss.php?min_price=0&max_price=50';
            } else if (topValue === '50_99') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-rss.php?min_price=50&max_price=99';
            } else if (topValue === '100_199') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-rss.php?min_price=100&max_price=199';
            } else if (topValue === 'peste_200') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-rss.php?min_price=200&max_price=99999';
            }
        } else if (formatValue === 'html') {
            if (topValue === '18') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-html.php?age=18';
            } else if (topValue === '35') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-html.php?age=35';
            } else if (topValue === '0') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-html.php?age=0';
            } else if (topValue === 'sub_50') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-html.php?min_price=0&max_price=50';
            } else if (topValue === '50_99') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-html.php?min_price=50&max_price=99';
            } else if (topValue === '100_199') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-html.php?min_price=100&max_price=199';
            } else if (topValue === 'peste_200') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-html.php?min_price=200&max_price=99999';
            }
        } else if (formatValue === 'pdf') {
            if (topValue === '18') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-pdf.php?age=18';
            } else if (topValue === '35') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-pdf.php?age=35';
            } else if (topValue === '0') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-age-pdf.php?age=0';
            } else if (topValue === 'sub_50') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-pdf.php?min_price=0&max_price=50';
            } else if (topValue === '50_99') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-pdf.php?min_price=50&max_price=99';
            } else if (topValue === '100_199') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-pdf.php?min_price=100&max_price=199';
            } else if (topValue === 'peste_200') {
                endpoint = 'http://127.0.0.1:8000/api/top/find-most-rec-products-by-price-pdf.php?min_price=200&max_price=99999';
            }
        }

        // Open the generated endpoint in a new window or tab
        window.open(endpoint, '_blank');
    }

    // Fetch product brands and populate the brand menu
    fetchData('http://127.0.0.1:8000/api/find-all-brands-by-product-type.php?product_category=1', 'brands')
        .then(data => {
            populateSelectMenu('brand-makeup', data, 'brand_name'); // Specify the brand_name property
            document.getElementById('product_type').dispatchEvent(new Event('change'));

        });

    // Fetch product brands and populate the brand menu
    fetchData('http://127.0.0.1:8000/api/find-all-brands-by-product-type.php?product_category=0', 'brands')
        .then(data => {
            populateSelectMenu('brand-skincare', data, 'brand_name'); // Specify the brand_name property
        });


    fetchData('http://127.0.0.1:8000/api/find-product-usage-types.php?product_category=1')
        .then(data => {
            console.log("here", data);
            populateSelectMenu('usage_type_makeup', data.usage_types, 'usage_type_name');

        });

    fetchData('http://127.0.0.1:8000/api/find-product-usage-types.php?product_category=0')
        .then(data => {
            console.log("here", data);
            populateSelectMenu('usage_type_skincare', data.usage_types, 'usage_type_name');
        });

    // Event listener for brand change
    document.getElementById('brand-makeup').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-products-by-brand-and-category.php?product_category=1&brand_name=', createProductElements);
    });

    // Event listener for brand change
    document.getElementById('brand-skincare').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-products-by-brand-and-category.php?product_category=0&brand_name=', createProductElements);
    });

    // Event listener for product type change
    document.getElementById('product_type').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-makeup-products-by-type.php?type=', createProductElements);
    });
    // Event listener for usage type change
    document.getElementById('usage_type_makeup').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-products-by-usage-type.php?product_category=1&usage_type=', createProductElements);
    });

    // Event listener for usage type change
    document.getElementById('usage_type_skincare').addEventListener('change', function (event) {
        handleSelectChange(event, 'http://127.0.0.1:8000/api/find-products-by-usage-type.php?product_category=0&usage_type=', createProductElements);

    });
    document.getElementById('generateBtn').addEventListener('click', function () {
        var topValue = document.getElementById('top').value;
        var formatValue = document.getElementById('format').value;

        // Perform the desired action based on the selected values
        generateTop(topValue, formatValue);
    });



    // Event listener for age
    document.getElementById('age').addEventListener('change', function (event) {
        const selectedOption = event.target.value;
        let ageValue;
        if (selectedOption === '18-35') {
            ageValue = 18;
        } else if (selectedOption === '35+') {
            ageValue = 35;
        } else {
            ageValue = 0;
        }
        const url = `http://127.0.0.1:8000/api/find-products-by-age.php?age=${ageValue}`;
        console.log(url);
        handleSelectChange(event, url, createProductElements);
    });

    // Event listener for skin type
    document.getElementById('ten').addEventListener('change', function (event) {
        const selectedOption = event.target.value;
        let skintypeValue;
        if (selectedOption === 'ten_normal') {
            skintypeValue = 2;
        } else if (selectedOption === 'ten_gras') {
            skintypeValue = 1;
        } else if (selectedOption === 'ten_uscat') {
            skintypeValue = 4;
        } else {
            skintypeValue = 3;
        }
        const url = `http://127.0.0.1:8000/api/find-products-by-skintype.php?skintype=${skintypeValue}`;
        console.log(url);
        handleSelectChange(event, url, createProductElements);
    });

    // Event listener for price change
    document.getElementById('pret').addEventListener('change', function (event) {
        const selectedOption = event.target.value;
        let minPrice, maxPrice;

        // Set the minimum and maximum price range based on the selected option
        switch (selectedOption) {
            case 'sub_50':
                minPrice = 0;
                maxPrice = 50;
                break;
            case '50_99':
                minPrice = 50;
                maxPrice = 99;
                break;
            case '100_199':
                minPrice = 100;
                maxPrice = 199;
                break;
            case 'peste_200':
                minPrice = 200;
                maxPrice = 10000;
                break;
            default:
                minPrice = 0;
                maxPrice = 10000;
                break;
        }

        // Construct the URL for the API request with the price range parameters
        const url = `http://127.0.0.1:8000/api/find-products-by-price.php?min_price=${minPrice}&max_price=${maxPrice}`;

        // Call the handleSelectChange function with the constructed URL and the createProductElements callback
        handleSelectChange(event, url, createProductElements);
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