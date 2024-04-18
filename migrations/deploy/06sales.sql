CREATE TYPE sales AS (
    sale_date DATE,
    nb_invoices INT,
    total NUMERIC
);

CREATE OR REPLACE FUNCTION sales_by_date(start_date DATE, end_date DATE) 
RETURNS SETOF sales AS $$
BEGIN
    RETURN QUERY
    SELECT 
        generate_series(start_date, end_date, '1 day'::interval)::DATE AS sale_date,
        COALESCE(COUNT(invoice.id), 0) AS nb_invoices,
        COALESCE(SUM(product.price_with_taxes * invoice_line.quantity), 0) AS total
    FROM 
        generate_series(start_date, end_date, '1 day'::interval)::DATE AS date_range
    LEFT JOIN 
        invoice ON DATE(invoice.issued_at) = date_range
    LEFT JOIN 
        invoice_line ON invoice.id = invoice_line.invoice_id
    LEFT JOIN 
        product ON invoice_line.product_id = product.id
    GROUP BY 
        date_range
    ORDER BY 
        date_range;
END;
$$ LANGUAGE plpgsql;
