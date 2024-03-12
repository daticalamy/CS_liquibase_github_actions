--liquibase formatted sql

--changeset amy.smith:test_table_01 labels:v0.1.0
CREATE TABLE test_job_01 (
	name varchar(10) NOT NULL,
	business_unit varchar(10) NULL,
	"location" varchar(10) NULL,
	division varchar(10) NULL
);
--rollback DROP TABLE test_job_01;