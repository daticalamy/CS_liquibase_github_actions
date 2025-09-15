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

--changeset amy.smith:sales_contacts7 labels:abc-0002 
create table Sales.Contacts7 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts7;

--changeset amy.smith:sales_contacts8 labels:abc-0002 
create table Sales.Contacts8 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts8;

--changeset amy.smith:sales_contacts8_delete
delete from Sales.Contacts8;
--rollback select '1';

--changeset amy.smith:sales_contacts9_delete
delete from Sales.Contacts8;
--rollback |
select 
'1';
