-- Select all the data from the table
SELECT * FROM animals;

-- Find all the animals whose name ends in "mon"
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all the animals born between 2016 and 2019
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';

-- List the name of all animals that are neutered and have less than 3 escape attempts
SELECT * FROM animals WHERE neutered IS true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered IS true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg).
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

/* Transctions */

-- Set species to unspecified
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT species FROM animals;
ROLLBACK;

-- Set species to digimon or pokemon
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Delete all records
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Delete some records and update others
BEGIN;
DELETE FROM animals WHERE date_of_birth > '01-01-2022';
SAVEPOINT my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO my_savepoint;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

-- Queries with aggregate functions
SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered;
SELECT MIN(weight_kg), MAX(weight_kg) FROM animals;
SELECT AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '01-01-1990' AND '01-01-2000';

/* Queries with JOIN */

-- animals that belong to Melody Pond
SELECT animals.name AS "animals name" FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List all animals that are pokemon
SELECT animals.name AS "animals name" FROM animals
INNER JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals
SELECT owners.full_name AS "owners name",
animals.name AS "animals name" FROM owners
LEFT JOIN animals
ON animals.owner_id = owners.id;

-- List of animals per species
SELECT species.name AS "species name",
COUNT(*) AS "number of animals"
FROM animals
INNER JOIN species
ON animals.species_id = species.id
GROUP BY species.name;

-- List all digimon owned by Jennifer Orwell
SELECT animals.name AS "Animals name",
owners.full_name AS "owners name" FROM animals
INNER JOIN species
ON animals.species_id = species.id
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape
SELECT animals.name AS "Animals name",
owners.full_name AS "owners name" FROM animals
INNER JOIN owners
ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

--  who owns the most animals
SELECT owners.full_name AS "owners name",
COUNT(*) AS "number of animals" FROM owners
INNER JOIN animals
ON animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;

--------------------------------------
-- JOIN TABLES
---------------------------------------

-- Last animal seen by William Tatcher
SELECT animals.name AS "Animals name",
vets.name AS "vets name",
date_of_visit AS "date of visit" FROM visits
LEFT JOIN vets
ON vets.id = visits.vet_id
LEFT JOIN animals
ON animals.id = visits.animal_id
WHERE vets.name = 'William Tatcher'
ORDER BY date_of_visit DESC
LIMIT 1;


-- Number of different animals seen by Stephanie Mendez
SELECT COUNT(DISTINCT animals) AS "number of animals" FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties
SELECT * FROM vets
LEFT JOIN specializations
ON vets.id = specializations.vets_id
LEFT JOIN species
ON species.id = specializations.species_id;

-- all animals visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS "Animals name",
visits.date_of_visit AS "date of visit" FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
INNER JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND visits.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';

-- animal with most visits to vets
SELECT animals.name AS "Animals name",
COUNT(*) AS "number of visits" FROM animals
INNER JOIN visits
ON animals.id = visits.animal_id
GROUP BY animals.name
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit
SELECT animals.name AS "Animals name" FROM visits
INNER JOIN animals
ON animals.id = visits.animal_id
LEFT JOIN vets
ON vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
ORDER BY visits.date_of_visit ASC
LIMIT 1;

-- details of most recent visit: animal information, vet information, and visit date
SELECT vets.name AS "vets name",
animals.name AS "Animals name",
visits.date_of_visit AS "date of visit" FROM visits
LEFT JOIN vets
ON vets.id = visits.vet_id
LEFT JOIN animals
ON animals.id = visits.animal_id
ORDER BY visits.date_of_visit DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species
SELECT COUNT(*) AS "number of visits" FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
LEFT JOIN specializations
ON vets.id = specializations.vets_id
LEFT JOIN species
ON specializations.species_id = species.id
WHERE species IS NULL;

-- specialty should Maisy Smith consider getting
SELECT species.name AS "species name",
COUNT(*) AS "number of visits" FROM vets
INNER JOIN visits
ON vets.id = visits.vet_id
INNER JOIN animals
ON animals.id = visits.animal_id
INNER JOIN species
ON animals.species_id = species.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(*) DESC
LIMIT 1;