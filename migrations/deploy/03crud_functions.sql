-- Deploy ofact:03crud_functions to pg
BEGIN;

CREATE OR REPLACE FUNCTION update_visitor(input json) RETURNS json AS $$
DECLARE
    updated_visitor visitor;
BEGIN
    UPDATE "visitor" SET
        "password" = input->>"password",
        "name" = input->>"name",
        "address" = input->>"address",
        "zip_code" = (input->>"zip_code"),
        "city" = input->>"city"
    WHERE "email" = (input->>"email")
    RETURNING * INTO updated_visitor;

    RETURN json_build_object(
        'id', updated_visitor.id,
        'email', updated_visitor.email,
        'password', updated_visitor.password,
        'name', updated_visitor.name,
        'address', updated_visitor.address,
        'zip_code', updated_visitor.zip_code,
        'city', updated_visitor.city,
        'created_at', updated_visitor.created_at,
        'updated_at', updated_visitor.updated_at
    );
END;
$$ LANGUAGE plpgsql STRICT;

COMMIT;