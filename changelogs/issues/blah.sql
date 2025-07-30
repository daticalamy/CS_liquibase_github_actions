--liquibase formatted sql

--changeset amy.smith:table_blah  labels:no_issue_id_found 
create table Sales.table_blah (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table_blah;

--changeset amy.smith:table_blah2 
create table Sales.table_blah2 (
  id int, 
  name varchar(30),
  name varchar(30)
);
--rollback DROP TABLE Sales.table_blah2;