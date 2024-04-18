-- Verify ofact:01init on pg
BEGIN;

SELECT
    *
FROM
    "invoice";

SELECT
    *
FROM
    "invoice_line";

SELECT
    *
FROM
    "product";

SELECT
    *
FROM
    "visitor";

ROLLBACK;