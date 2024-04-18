-- Revert ofact:invoice_details from pg
BEGIN;

DROP VIEW invoice_details;

COMMIT;