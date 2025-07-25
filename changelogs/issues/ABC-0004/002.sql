--liquibase formatted sql

--changeset amy.smith:table04a  
create table Sales.table04a (
  id int, 
  name varchar(30)
);
--rollback DROP TABLE Sales.table04a;
