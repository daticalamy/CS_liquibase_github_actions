--liquibase formatted sql

--changeset amy.smith:table06a
create table Sales.table06a (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table06a;
