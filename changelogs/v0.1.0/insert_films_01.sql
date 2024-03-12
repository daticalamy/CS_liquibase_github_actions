--liquibase formatted sql

--changeset amy.smith:films_01_insert labels:v0.1.0
insert into films_01 (id, name, kind) values (1, 'Funny Movie', 'Comedy');
--rollback DELETE FROM films_01 where id = 1;