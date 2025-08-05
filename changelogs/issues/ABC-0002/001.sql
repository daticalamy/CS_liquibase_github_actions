--liquibase formatted sql

--changeset amy.smith:sales_contacts5 labels:abc-0002 
create table Sales.Contacts5 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts5;

--changeset amy.smith:sales_contacts6 labels:abc-0002 
create table Sales.Contacts6 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts6;
