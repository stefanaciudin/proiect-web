<?php
require_once '../../php/ProductRepository.php';
require ('fpdf.php');
require ('helveticab.php');
require_once '../functions.php';
if (isset($_GET['age'])) {
    $age = $_GET['age'];
// Get the top recommended products by age
    $products = ProductRepository::findMostRecProductsByAge($age);
    $pdf = new FPDF();
    $pdf->AddPage();
    $pdf->SetFont('Helvetica', 'B', 16);
    $pdf->Cell(0, 10, 'Top Recommended Products by Age', 0, 1, 'C');
    createPdf($pdf, $products,"top_products_by_age.pdf");
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Age is missing.')
    );
}
