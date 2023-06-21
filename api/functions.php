<?php
function getArr(mixed $product): array
{
    return array(
        'product_id' => $product->getProductId(),
        'name' => $product->getName(),
        'price' => $product->getPrice(),
        'image_path' => $product->getImagePath(),
        'is_makeup' => $product->getIsMakeup(),
        'age' => $product->getAge(),
        'brand_id' => $product->getBrandId(),
        'skintype_id' => $product->getSkintypeId(),
        'type_id' => $product->getTypeId(),
        'ingredients' => $product->getIngredients(),
        'description' => $product->getDescription(),
        'how_to_use' => $product->getHowToUse(),
        'link' => $product->getLink(),
        'message' => 'Product found.'
    );
}
function createPage(string $html, array $products): void
{
    $html .= '</head>';
    $html .= '<body>';
    $html .= '<h1>Top produse: </h1>';
    $html .= '<ul>';
    foreach ($products as $product) {
        $html .= '<li>';
        $html .= '<h2>' . $product->getName() . '</h2>';
        $html .= '<p>Pret: ' . $product->getPrice() . '</p>';
        $html .= '<p>Descriere: ' . $product->getDescription() . '</p>';
        $html .= '</li>';
    }
    $html .= '</ul>';
    $html .= '</body>';
    $html .= '</html>';

    echo $html;
}
function createRss(array $products, string $title, string $description): void
{
    $feed = '<?xml version="1.0" encoding="UTF-8"?>';
    $feed .= '<rss version="2.0">';
    $feed .= '<channel>';
    $feed .= '<title>' . $title . '</title>';
    $feed .= '<link>https://example.com</link>';
    $feed .= '<description>' . $description . '</description>';

    foreach ($products as $product) {
        $feed .= '<item>';
        $feed .= '<title>' . $product->getName() . '</title>';
        $feed .= '<link>' . $product->getLink() . '</link>';
        $feed .= '<description>' . $product->getDescription() . '</description>';
        $feed .= '</item>';
    }

    $feed .= '</channel>';
    $feed .= '</rss>';
    echo $feed;
}

function createPdf(FPDF $pdf, array $products, string $dest): void
{
    $pdf->SetFont('Helvetica', '', 12);

    foreach ($products as $product) {
        $pdf->Ln(10);
        $pdf->Cell(0, 10, 'Product: ' . $product->getName(), 0, 1);
        $pdf->Cell(0, 10, 'Description: ' . $product->getDescription(), 0, 1);
        $pdf->Cell(0, 10, 'Link: ' . $product->getLink(), 0, 1);
    }

    $pdf->Output($dest, 'D');
}
