--liquibase formatted sql

--changeset amy.smith:table07  labels:abc-0007 
create table Sales.table07 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table07;
