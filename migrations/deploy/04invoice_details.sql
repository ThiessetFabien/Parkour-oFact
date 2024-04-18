-- Deploy ofact:invoice_details to pg

BEGIN;

CREATE VIEW invoice_details AS
SELECT
    visitor.name AS visitor_name,
    visitor.city AS visitor_city,
    invoice.id AS invoice_ref,
    invoice.issued_at AS invoice_issued_at,
    invoice.paid_at AS invoice_paid_at,
    invoice_line.quantity,
    product.label AS product_description,
    product.price AS product_price_excl_tax,
    product.price_with_taxes - product.price AS tax_rate,
    (product.price_with_taxes * invoice_line.quantity) AS total_line
FROM
    invoice_line
JOIN
    invoice ON invoice_line.invoice_id = invoice.id
JOIN
    visitor ON invoice.visitor_id::INT = visitor.id::INT
JOIN
    product ON invoice_line.product_id = product.id;

COMMIT;
