<?php
header('Content-Type: application/rss+xml; charset=utf-8');

require_once '../php/ProductRepository.php';

if (isset($_GET['age'])) {
    $age = $_GET['age'];
// Get the top recommended products by age
    $products = ProductRepository::findMostRecProductsByAge($age);

// Generate the RSS feed
    $feed = '<?xml version="1.0" encoding="UTF-8"?>';
    $feed .= '<rss version="2.0">';
    $feed .= '<channel>';
    $feed .= '<title>Top Recommended Products by Age</title>';
    $feed .= '<link>https://example.com</link>';
    $feed .= '<description>Top recommended products for age ' . $age . '</description>';

// Add the products to the feed
    foreach ($products as $product) {
        $feed .= '<item>';
        $feed .= '<title>' . $product->getName() . '</title>';
        $feed .= '<link>' . $product->getLink() . '</link>';
        $feed .= '<description>' . $product->getDescription() . '</description>';
        $feed .= '</item>';
    }

    $feed .= '</channel>';
    $feed .= '</rss>';

// Output the generated RSS feed
    echo $feed;
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Age is missing.')
    );
}
