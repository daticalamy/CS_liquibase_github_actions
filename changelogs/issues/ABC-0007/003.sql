--liquibase formatted sql

--changeset amy.smith:table07b  labels:abc-0007 
create table Sales.table07b (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table07b;
