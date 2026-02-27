--liquibase formatted sql
--changeset amy.smith:new_table_011 labels:abc-011 

create table dbo.new_table_011 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE dbo.new_table_011;
