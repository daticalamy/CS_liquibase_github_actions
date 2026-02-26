--liquibase formatted sql
--changeset amy.smith:new_table_010 labels:abc-010 

create table dbo.new_table_010 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE dbo.new_table_010;
