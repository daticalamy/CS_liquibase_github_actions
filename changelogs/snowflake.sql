--liquibase formatted sql

--changeset amy.smith:sales_contacts labels:v0.1.0
create table Sales.Contacts (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Sales.Contacts;

--changeset amy.smith:sales_contacts_idx labels:v0.1.0
CREATE UNIQUE INDEX name_idx ON Sales.Contacts (name);
--rollback DROP INDEX name_idx on Sales.Contacts;
