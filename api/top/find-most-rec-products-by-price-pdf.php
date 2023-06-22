<?php
require_once '../../php/ProductRepository.php';
require ('fpdf.php');
require ('helveticab.php');
require_once '../functions.php';

if (isset($_GET['min_price']) && isset($_GET['max_price'])) {
    $minPrice = $_GET['min_price'];
    $maxPrice = $_GET['max_price'];
    $products = ProductRepository::findMostRecProductsByPrice($minPrice, $maxPrice);
    $pdf = new FPDF();
    $pdf->AddPage();
    $pdf->SetFont('Helvetica', 'B', 16);
    $pdf->Cell(0, 10, 'Top Recommended Products by Price', 0, 1, 'C');
    createPdf($pdf, $products, "top_products_by_price.pdf");
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Prices are missing.')
    );
}