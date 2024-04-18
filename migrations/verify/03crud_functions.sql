-- Verify ofact:03crud_functions on pg
BEGIN;

SELECT
    *
FROM
    update_visitor (
        '{
    "id": 1,
    "email": "x@xx.fr",
    "password": "12345",
    "name": "Nico",
    "address": "Au mileu de la grande anse",
    "zip_code": "17370",
    "city": "Grand-Village plage"
}'
    );

SELECT
    *
FROM
    update_invoice_line (
        '{
    "quantity": 3,
    "invoice_id": 1,
    "product_id": 1,
    "id": 1
}'
    );

ROLLBACK;