--liquibase formatted sql

--changeset amy.smith:table_blah  labels:no_issue_id_found 
create table Sales.table_blah (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table_blah;

--changeset amy.smith:table_blah2  labels:no_issue_id_found 
create table Sales.table_blah2 (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table_blah2;

--changeset amy.smith:table_blah2_delete 
delete from Sales.table_blah2;
--rollback select '1';