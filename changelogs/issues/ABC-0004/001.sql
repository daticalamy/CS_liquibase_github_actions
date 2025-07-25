--liquibase formatted sql

--changeset amy.smith:table04 
create table Sales.table04 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table04;
