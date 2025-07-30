--liquibase formatted sql

--changeset amy.smith:table08
create table Sales.table08 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table08;
