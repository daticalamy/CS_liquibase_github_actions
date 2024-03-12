--liquibase formatted sql

--changeset amy.smith:films_04 labels:v0.1.0
create table films_04 (
  id int, 
  name varchar(30),
  kind varchar(30) 
);
--rollback DROP TABLE films_04;


--changeset amy.smith:films_04_idx labels:v0.1.0
CREATE UNIQUE INDEX name4_idx ON films_04 (name);
--rollback drop index name4_idx;