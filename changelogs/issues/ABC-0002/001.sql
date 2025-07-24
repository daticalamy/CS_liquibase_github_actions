--liquibase formatted sql

--changeset amy.smith:table01
create table Sales.table01 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table01;
