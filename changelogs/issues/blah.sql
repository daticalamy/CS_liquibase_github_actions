--liquibase formatted sql

--changeset amy.smith:table_blah 
create table Sales.table_blah (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table_blah;
