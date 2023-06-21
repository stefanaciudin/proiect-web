<?php
include "php/ProductRepository.php";
include "php/VideoRepository.php";
$product = new ProductRepository();
$video = new VideoRepository();
$products = [];

if (isset($_POST['submit'])) {
    $products = $product->getProductsBySort();
}
if (isset($_POST['submit_sort'])) {
    $products = $product->getProductsByFilter();
}

?>
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
            <button class="button" id="filter">Filtreaza</button>
            <button class="button" id="sort">Sorteaza</button>
        </div>

        <div id="carousel" class="carousel">
            <button id="prevBtn" class="carousel-btn prev-btn">&lt;</button>
            <div id="videosContainer" class="videos-container">
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
                <iframe src="https://www.youtube.com/embed/sDErfOvnUfg" title="YouTube video player"
                        allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                        allowfullscreen></iframe>
            </div>
            <button id="nextBtn" class="carousel-btn next-btn">&gt;</button>
        </div>

<!--        --><?php
//        $occasion = "mireasa";
//        $videos = $video->getVideosByOccasion($occasion);
//        ?><!-- --><?php
//        $occasion = "mireasa";
//        $videos = $video->getVideosByOccasion($occasion);
//        ?>
<!---->
<!--        <div id="carousel" class="carousel">-->
<!--            <button id="prevBtn" class="carousel-btn prev-btn">&lt;</button>-->
<!--            <div id="videosContainer" class="videos-container">-->
<!--                --><?php //if (empty($videos)): ?>
<!--                    <p>No videos available.</p>-->
<!--                --><?php //else: ?>
<!--                    --><?php //foreach ($videos as $video): ?>
<!--                        <iframe src="--><?php //echo $video['link']; ?><!--" title="YouTube video player"-->
<!--                                allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"-->
<!--                                allowfullscreen></iframe>-->
<!--                    --><?php //endforeach; ?>
<!--                --><?php //endif; ?>
<!--            </div>-->
<!--            <button id="nextBtn" class="carousel-btn next-btn">&gt;</button>-->
<!--        </div>-->

<!--        --><?php
//               $occasion = "mireasa";
//                $videos = $video->getVideosByOccasion($occasion);
//                ?><!-->-->
<!--        <script>-->
<!--            function createVideoElement(videos) {-->
<!--                const videosContainer = document.getElementById('videosContainer');-->
<!--                videosContainer.innerHTML = '';-->
<!---->
<!--                if (videos.length === 0) {-->
<!--                    const message = document.createElement('p');-->
<!--                    message.textContent = 'No videos available.';-->
<!--                    videosContainer.appendChild(message);-->
<!--                } else {-->
<!--                    videos.forEach(video => {-->
<!--                        // Create video iframe-->
<!--                        const videoIframe = document.createElement('iframe');-->
<!--                        videoIframe.src = video.link;-->
<!--                        videoIframe.title = 'YouTube video player';-->
<!--                        videoIframe.allow = 'accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';-->
<!--                        videoIframe.allowFullscreen = true;-->
<!--                        videosContainer.appendChild(videoIframe);-->
<!--                    });-->
<!--                }-->
<!--            }-->
<!---->
<!--        </script>-->


        <div class="products_phone" id="products_phone">
            <?php
            if ($products != []) {
                foreach ($products as $prod) {
                    echo '<div class="product">';
                    echo '<a href="' . $prod['link'] . '">';
                    echo '<img src="' . $prod['image_path'] . '" alt="' . $prod['description'] . '">';
                    echo '<p>' . $prod['name'] . '</p>';
                    echo '</a>';
                    echo '</div>';
                }
            } else {
                echo "<p>Nu exista produse pentru filtrele selectate!</p>";
            }
            ?>
        </div>

        <div id="products" class="desktop_only">
            <!-- Products will be populated dynamically -->
        </div>
    </div>

    <div id="filterModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h1>Filtreaza Produsele</h1>

            <p></p>

            <form class="form-container" method="POST" action="makeup.php">
                <select id="s1" name="select1" class="select_brands">
                    <?php
                    $brands = $product->getMakeUpBrands();
                    foreach ($brands as $brand) {
                        $id = $brand['brand_id'];
                        $name = $brand['brand_name'];
                        echo "<option value='$id'>$name</option>";
                    }
                    ?>
                </select>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox1" name="checkboxGroup" value="checkbox1"
                           onchange="toggleDiv('div1', this)">
                    <label for="checkbox1">Ten</label>
                </div>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox2" name="checkboxGroup" value="checkbox2"
                           onchange="toggleDiv('div2', this)">
                    <label for="checkbox2">Ochi</label>
                </div>
                <div class="checkbox-container">
                    <input type="checkbox" id="checkbox3" name="checkboxGroup" value="checkbox3"
                           onchange="toggleDiv('div3', this)">
                    <label for="checkbox3">Buze</label>
                </div>
                <div id="div1" class="hidden">

                    <select id="select2" name="select2" class="select_ten">
                        <?php
                        $usage_types = $product->getUsageTypeByProductType("ten");
                        foreach ($usage_types as $usage_type) {
                            $id_ten = $usage_type['id_type'];
                            $name_ten = $usage_type['name_type'];
                            echo "<option value='$id_ten'>$name_ten</option>";
                        }
                        ?>
                    </select>
                </div>
                <div id="div2" class="hidden">
                    <select name="select3" id="s3" class="select_ochii">
                        <?php
                        $usage_types = $product->getUsageTypeByProductType("ochi");
                        foreach ($usage_types as $usage_type) {
                            $id_ten = $usage_type['id_type'];
                            $name_ten = $usage_type['name_type'];
                            echo "<option value='$id_ten'>$name_ten</option>";
                        }
                        ?>
                    </select>
                </div>
                <div id="div3" class="hidden">
                    <select name="select4" class="select_buze">
                        <?php
                        $usage_types = $product->getUsageTypeByProductType("buze");
                        foreach ($usage_types as $usage_type) {
                            $id_ten = $usage_type['id_type'];
                            $name_ten = $usage_type['name_type'];
                            echo "<option value='$id_ten'>$name_ten</option>";
                        }
                        ?>
                    </select>
                </div>
                <input type="submit" class="button" value="Filtreaza" name="submit">
            </form>
        </div>
    </div>
    <div id="sortModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <form class="form-container" method="POST" action="makeup.php">
                <h1>Sorteaza Produsele</h1>
                <select name="select_sort" class="select_sort">
                    <option value="crescator">Pret crescator</option>
                    <option value="descrescator">Pret descrescator</option>
                    <option value="rating">Rating</option>
                </select>
                <input type="submit" class="button" value="Sorteaza" name="submit_sort">
            </form>
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
    function toggleDiv(divId, checkbox) {
        var div = document.getElementById(divId);
        var checkboxes = document.getElementsByName("checkboxGroup");
        for (var i = 0; i < checkboxes.length; i++) {
            if (checkboxes[i] !== checkbox) {
                checkboxes[i].checked = false;
                document.getElementById("div" + (i + 1)).classList.add('hidden');
            }
        }
        div.classList.toggle('hidden');
    }

    // Get the modal
    var filterModal = document.getElementById("filterModal");
    var sortModal = document.getElementById("sortModal");

    // Get the button that opens the modals
    var filterBtn = document.getElementById("filter");
    var sortBtn = document.getElementById("sort");

    // Get the <span> elements that close the modals
    var closeBtns = document.getElementsByClassName("close");

    // Function to open a modal
    function openModal(modal) {
        modal.style.display = "block";
    }

    // Function to close a modal
    function closeModal(modal) {
        modal.style.display = "none";
    }

    // Event listener for opening the filter modal
    filterBtn.onclick = function () {
        openModal(filterModal);
    };

    // Event listener for opening the sort modal
    sortBtn.onclick = function () {
        openModal(sortModal);
    };

    // Event listener for closing the modals
    for (var i = 0; i < closeBtns.length; i++) {
        closeBtns[i].onclick = function () {
            closeModal(this.parentElement.parentElement);
        };
    }

    // When the user clicks anywhere outside of the modal, close it
    window.onclick = function (event) {
        if (event.target == filterModal) {
            closeModal(filterModal);
        }
        if (event.target == sortModal) {
            closeModal(sortModal);
        }
    };


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

<script>
    // Get carousel elements
    const carousel = document.getElementById('carousel');
    const videosContainer = document.getElementById('videosContainer');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');

    // Set initial position of the carousel
    let currentPosition = 0;

    // Move carousel to the previous position
    prevBtn.addEventListener('click', () => {
        currentPosition += 300; // Adjust the value based on the width of the video iframe
        if (currentPosition > 0) {
            currentPosition = -(videosContainer.scrollWidth - carousel.offsetWidth);
        }
        videosContainer.style.transform = `translateX(${currentPosition}px)`;
    });

    // Move carousel to the next position
    nextBtn.addEventListener('click', () => {
        currentPosition -= 300; // Adjust the value based on the width of the video iframe
        if (Math.abs(currentPosition) > videosContainer.scrollWidth - carousel.offsetWidth) {
            currentPosition = 0;
        }
        videosContainer.style.transform = `translateX(${currentPosition}px)`;
    });

</script>

</body>

</html>