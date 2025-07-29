--liquibase formatted sql

--changeset amy.smith:table07a 
create table Sales.table07a (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table07a;
