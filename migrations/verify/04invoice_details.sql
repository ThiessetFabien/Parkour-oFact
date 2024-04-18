-- Verify ofact:invoice_details on pg
BEGIN;

SELECT
    *
FROM
    invoice_details
WHERE
    visitor_name = 'Numérobis';

ROLLBACK;