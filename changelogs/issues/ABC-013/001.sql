--liquibase formatted sql
--changeset amy.smith:new_table_013 labels:abc-013 

create table dbo.new_table_013 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE dbo.new_table_013;
