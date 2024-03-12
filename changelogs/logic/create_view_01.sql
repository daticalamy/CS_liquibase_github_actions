--liquibase formatted sql

--changeset amy.smith:films_vw_01 labels:v0.1.0 endDelimiter:$$
CREATE OR REPLACE VIEW films_vw_01 AS
 SELECT ID, NAME, KIND from films_01;
--rollback DROP VIEW films_vw_01;