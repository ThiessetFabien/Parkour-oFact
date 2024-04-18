-- Revert ofact:01init from pg
BEGIN;

-- Deploy ofact:01init to pg
DROP TABLE invoice_line;

DROP TABLE invoice;

DROP TABLE visitor;

DROP TABLE product;

DROP DOMAIN email_type;

DROP DOMAIN zip_code_type;

COMMIT;