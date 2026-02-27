--liquibase formatted sql
--changeset amy.smith:new_table_012 labels:abc-012 

create table dbo.new_table_012 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE dbo.new_table_012;
