-- Deploy ofact:invoice_recap to pg

BEGIN;

CREATE VIEW invoice_recap AS
SELECT
    invoice.id AS invoice_id,
    invoice.issued_at AS invoice_issued_at,
    invoice.paid_at AS invoice_paid_at,
    (SELECT name FROM visitor WHERE visitor.id::INT = invoice.visitor_id::INT) AS visitor_name,
    (
        SELECT SUM((product.price_with_taxes * invoice_line.quantity))
        FROM invoice_line
        JOIN product ON invoice_line.product_id::INT = product.id::INT
        WHERE invoice_line.invoice_id::INT = invoice.id::INT
    ) AS total
FROM
    invoice;

COMMIT;
