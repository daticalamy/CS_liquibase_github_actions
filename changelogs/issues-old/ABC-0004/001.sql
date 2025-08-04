--liquibase formatted sql

--changeset amy.smith:table04  labels:abc-0004 
create table Sales.table04 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table04;
