<?php
require_once '../php/ProductRepository.php';
require_once 'fpdf.php';
if (isset($_GET['age'])) {
    $age = $_GET['age'];
// Get the top recommended products by age
    $products = ProductRepository::findMostRecProductsByAge($age);

// Create a new PDF instance
    $pdf = new FPDF();

// Add a page
    $pdf->AddPage();

    $pdf->AddFont('Helvetica', '', 'helvetica.php');
// Set font
    $pdf->SetFont('Helvetica', 'B', 16);

// Add title
    $pdf->Cell(0, 10, 'Top Recommended Products by Age', 0, 1, 'C');

// Set font for product details
    $pdf->SetFont('Arial', '', 12);

// Add products to the PDF
    foreach ($products as $product) {
        $pdf->Ln(10);
        $pdf->Cell(0, 10, 'Product: ' . $product->getName(), 0, 1);
        $pdf->Cell(0, 10, 'Description: ' . $product->getDescription(), 0, 1);
        $pdf->Cell(0, 10, 'Link: ' . $product->getLink(), 0, 1);
    }

// Output the PDF as a file
    $pdf->Output('top_products_by_age.pdf', 'D');
} else {
    http_response_code(400);
    echo json_encode(
        array('message' => 'Bad request. Age is missing.')
    );
}
