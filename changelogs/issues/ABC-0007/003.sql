--liquibase formatted sql

--changeset amy.smith:table07b 
create table Sales.table07b (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table07b;
