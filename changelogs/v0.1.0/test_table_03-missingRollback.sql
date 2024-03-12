--liquibase formatted sql

--changeset amy.smith:test_table_03 labels:v0.1.0
create table test_table_03 (
    id SERIAL,
	name varchar(30)
);