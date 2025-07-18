--liquibase formatted sql

--changeset amy.smith:sales_contacts labels:v0.1.0
CREATE TABLE Contacts (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE, 
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
--rollback DROP TABLE Contacts;
