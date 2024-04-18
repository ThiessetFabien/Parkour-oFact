-- Deploy ofact:02index to pg

BEGIN;

CREATE INDEX idx_visitor_email ON visitor(email);

CREATE INDEX idx_invoice_visitor_id ON invoice(visitor_id);

CREATE INDEX idx_invoice_line_invoice_id ON invoice_line(invoice_id);

CREATE INDEX idx_invoice_line_product_id ON invoice_line(product_id);

COMMIT;
