--liquibase formatted sql

--changeset amy.smith:sales_contacts labels:v0.1.0,JIRA-4562
CREATE TABLE Contacts (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--rollback DROP TABLE Contacts;

--changeset amy.smith:sales_insert_01 labels:v0.1.1
INSERT INTO Contacts (id, name, email) VALUES (1, 'Amy Smith', 'asmith@liquibase.com');
INSERT INTO Contacts (id, name, email) VALUES (2, 'Ben Riley', 'briley@liquibase.com');
--rollback DELETE FROM Contacts;