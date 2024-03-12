--liquibase formatted sql

--changeset amy.smith:get_films_01 labels:v0.1.0 endDelimiter:$$
CREATE OR REPLACE PROCEDURE get_films_01()
 LANGUAGE plpgsql
AS $procedure$
BEGIN
    SELECT id FROM films_01;
END;
$procedure$
;
--rollback DROP PROCEDURE get_films_01;