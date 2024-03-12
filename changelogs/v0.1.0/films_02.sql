--liquibase formatted sql

--changeset amy.smith:films_02 labels:v0.1.0
create table films_02 (
  id int, 
  name varchar(30),
  kind varchar(30) 
);
--rollback DROP TABLE films_02;


--changeset amy.smith:films_02_idx labels:v0.1.0
CREATE UNIQUE INDEX name2_idx ON films_02 (name);
--rollback drop index name2_idx;