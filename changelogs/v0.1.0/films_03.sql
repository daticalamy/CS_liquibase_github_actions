--liquibase formatted sql

--changeset amy.smith:films_03 labels:v0.1.0
create table films_03 (
  id int, 
  name varchar(30),
  kind varchar(30) 
);
--rollback DROP TABLE films_03;


--changeset amy.smith:films_03_idx labels:v0.1.0
CREATE UNIQUE INDEX name3_idx ON films_03 (name);
--rollback drop index name3_idx;