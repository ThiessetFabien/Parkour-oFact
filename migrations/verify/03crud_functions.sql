-- Verify ofact:03crud_functions on pg
BEGIN;

SELECT
    *
FROM
    update_visitor (
        '{
    "email": "x@xx.fr",
    "password": "12345",
    "name": "Nico",
    "address": "Au mileu de la grande anse",
    "zip_code": "17370",
    "city": "Grand-Village plage"
}'
    ) ROLLBACK;