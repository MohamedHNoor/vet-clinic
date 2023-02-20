--  Create a database named vet_clinic
CREATE DATABASE vet_clinic;

-- Create a table named animals with the following columns:
CREATE TABLE animals (
    id INTEGER,
    name VARCHAR(100),
    date_of_birth DATE,
    escape_attempts INTEGER,
    neutered BOOLEAN,
    weight_kg DECIMAL
);
