--liquibase formatted sql

--changeset amy.smith:sales_contacts labels:abc-0001 
create table Sales.Contacts2 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts2;


--changeset amy.smith:sales_contacts_idx labels:abc-0001
CREATE UNIQUE INDEX name2_idx ON Sales.Contacts2 (name);
--rollback DROP INDEX name2_idx on Sales.Contacts2;

--changeset amy.smith:stores labels:abc-0001 
create table Sales.Stores2 (
  id int, 
  name varchar(30),
  city varchar(30) 
);
--rollback DROP TABLE Sales.Stores2;

--changeset amy.smith:goals labels:abc-0001 
create table Sales.Goals2 (
  id int, 
  name varchar(30) 
);
--rollback DROP TABLE Sales.Goals2;

--changeset amy.smith:kpis labels:abc-0001 
create table Sales.Kpis2 (
  id int, 
  name varchar(30) 
);
--rollback DROP TABLE Sales.Kpis2;
