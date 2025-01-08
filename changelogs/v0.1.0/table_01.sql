--liquibase formatted sql
--changeset amy_smith:01 labels:POCEnv context:TEST

create or replace table TEST_SET_01.table_01
(
id string(32),
name  STRING(40),
location STRING(10),
GRANT_ID STRING(10),
PARTC_ID STRING(10),
AWRD_ID STRING(10),
DW_EFF_DT DATE,
DW_EXPR_DT DATE
)
;
--rollback drop table TEST_SET_01.table_01