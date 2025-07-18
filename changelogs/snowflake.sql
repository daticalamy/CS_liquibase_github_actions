--liquibase formatted sql

--changeset amy.smith:sales_contacts labels:v0.1.0
create table Contacts (
  id int, 
  name varchar(30),
  dept varchar(30) 
);
--rollback DROP TABLE Contacts;

--changeset amy.smith:sales_contacts_idx labels:v0.1.0
CREATE UNIQUE INDEX name_idx ON Contacts (name);
--rollback DROP INDEX name_idx on Contacts;
