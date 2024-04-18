-- Revert ofact:02index from pg

BEGIN;

DROP INDEX idx_visitor_email;

DROP INDEX idx_invoice_visitor_id;

DROP INDEX idx_invoice_line_invoice_id;

DROP INDEX idx_invoice_line_product_id;

COMMIT;
