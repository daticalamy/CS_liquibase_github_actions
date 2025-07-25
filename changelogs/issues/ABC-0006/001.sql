--liquibase formatted sql

--changeset amy.smith:table06 
create table Sales.table06 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table06;
