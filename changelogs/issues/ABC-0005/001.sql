--liquibase formatted sql

--changeset amy.smith:table05
create table Sales.table05 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table05;
