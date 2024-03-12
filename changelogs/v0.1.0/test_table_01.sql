--liquibase formatted sql

--changeset amy.smith:test_table_01 labels:v0.1.0
create table test_table_01 (
    id SERIAL,
	name varchar(30)
)
--rollback DROP TABLE test_table_01;