--liquibase formatted sql

--changeset amy.smith:table05a
create table Sales.table05a (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table05a;
