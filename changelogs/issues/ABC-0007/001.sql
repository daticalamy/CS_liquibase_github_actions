--liquibase formatted sql

--changeset amy.smith:table07 
create table Sales.table07 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table07;
