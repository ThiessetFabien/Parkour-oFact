-- Revert ofact:03crud_functions from pg
BEGIN;

DROP FUNCTION update_visitor;

COMMIT;