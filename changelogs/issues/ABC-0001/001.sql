--liquibase formatted sql

--changeset amy.smith:sales_contacts labels:v0.1.0
create table Sales.Contacts2 (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts2;


--changeset amy.smith:sales_contacts_idx labels:v0.1.0
CREATE UNIQUE INDEX name2_idx ON Sales.Contacts2 (name);
--rollback DROP INDEX name2_idx on Sales.Contacts2;

--changeset amy.smith:stores
create table Sales.Stores2 (
  id int, 
  name varchar(30),
  city varchar(30) 
);
--rollback DROP TABLE Sales.Stores2;

--changeset amy.smith:goals
create table Sales.Goals2 (
  id int, 
  name varchar(30) 
);
--rollback DROP TABLE Sales.Goals2;

--changeset amy.smith:kpis
create table Sales.Kpis2 (
  id int, 
  name varchar(30) 
);
--rollback DROP TABLE Sales.Kpis2;
