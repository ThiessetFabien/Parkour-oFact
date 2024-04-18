-- Deploy ofact:03crud_functions to pg
BEGIN;

CREATE OR REPLACE FUNCTION update_visitor(input json) RETURNS visitor AS $$

    UPDATE "visitor" SET
        "password" = input->>"password",
        "name" = input->>"name",
        "address" = input->>"address",
        "zip_code" = (input->>"zip_code"),
        "city" = input->>"city"
    WHERE "email" = (input->>"email")
    RETURNING *;

$$ LANGUAGE sql STRICT;

CREATE OR REPLACE FUNCTION update_invoice_line(input json) RETURNS json AS $$
DECLARE
    updated_line invoice_line;
BEGIN
    UPDATE "invoice_line" SET
        "quantity" = (input->>'quantity')::INT,
        "invoice_id" = (input->>'invoice_id')::INT,
        "product_id" = (input->>'product_id')::INT
    WHERE "id" = (input->>'id')::INT
    RETURNING * INTO updated_line;

    RETURN json_build_object(
        'id', updated_line.id,
        'line_id', updated_line.line_id,
        'quantity', updated_line.quantity,
        'invoice_id', updated_line.invoice_id,
        'product_id', updated_line.product_id,
        'created_at', updated_line.created_at,
        'updated_at', updated_line.updated_at
    );
END;
$$ LANGUAGE plpgsql STRICT;


COMMIT;