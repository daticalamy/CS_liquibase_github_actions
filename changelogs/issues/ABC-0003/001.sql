--liquibase formatted sql

--changeset amy.smith:table03
create table Sales.table03 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table03;
