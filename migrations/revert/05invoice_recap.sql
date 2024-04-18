-- Revert ofact:invoice_recap from pg
BEGIN;

DROP VIEW invoice_recap;

COMMIT;