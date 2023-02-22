INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Agumon',
  '2020-02-03',
  0,
  'true',
  10.23
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Gabumon',
  '2018-11-15',
  2,
  'true',
  8
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Pikachu',
  '2021-01-07',
  1
  ,
  'false',
  15.04
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Devimon',
  '2017-05-12',
  5
  ,
  'true',
  11
);

-- update animals table

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Charmander',
  '2020-02-08',
  0,
  'false',
  -11
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Plantmon',
  '2021-11-15',
  2,
  'true',
  -5.7
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Squirtle',
  '1993-04-02',
  3
  ,
  'false',
  -12.13
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Angemon',
  '2005-06-12',
  1
  ,
  'true',
  -45
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Boarmon',
  '2005-06-07',
  7
  ,
  'true',
  20.4
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Blossom',
  '1998-10-13',
  3
  ,
  'true',
  17
);

INSERT INTO animals (
  name,
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
) VALUES (
  'Ditto',
  '2022-05-14',
  4
  ,
  'true',
  22
);

-- owners table
INSERT INTO owners (
  full_name,
  age
) VALUES (
  'Sam Smith',
  34
);

INSERT INTO owners (
  full_name,
  age
) VALUES (
  'Jennifer Orwell',
  19
);

INSERT INTO owners (
  full_name,
  age
) VALUES (
  'Bob',
  45
);

INSERT INTO owners (
  full_name,
  age
) VALUES (
  'Melody Pond',
  77
);

INSERT INTO owners (
  full_name,
  age
) VALUES (
  'Dean Winchester',
  14
);

INSERT INTO owners (
  full_name,
  age
) VALUES (
  'Jodie Whittaker',
  38
);

-- species table
INSERT INTO species (
  name
) VALUES (
  'Digimon'
);

INSERT INTO species (
  name
) VALUES (
  'Pokemon'
);

-- Modified inserted animsls table with species_id
UPDATE animals
SET species_id = 1
WHERE name LIKE '%mon';

UPDATE animals
SET species_id = 2
WHERE species_id IS NULL;

-- Modified inserted animsls table with owner_id
UPDATE animals
SET owner_id = 1
WHERE name IN ('Agumon');

UPDATE animals
SET owner_id = 2
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = 3
WHERE name IN ('Plantmon');

UPDATE animals
SET owner_id = 4
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = 5
WHERE name IN ('Boarmon', 'Angemon');

-- Insert data for vets table
INSERT INTO vets (
  name,
  age,
  date_of_graduation
) VALUES (
  'William Tatcher',
  45,
  '2000-04-23'
);

INSERT INTO vets (
  name,
  age,
  date_of_graduation
) VALUES (
  'Maisy Smith',
  26,
  '2019-01-17'
);

INSERT INTO vets (
  name,
  age,
  date_of_graduation
) VALUES (
  'Stephanie Mendez',
  64,
  '1981-05-04'
);

INSERT INTO vets (
  name,
  age,
  date_of_graduation
) VALUES (
  'Jack Harkness',
  38,
  '2008-06-08'
);

-- Insert data for specializations table
INSERT INTO specializations(species_id, vets_id)
VALUES((SELECT id FROM species WHERE name = 'Pokimon'), (SELECT id FROM vets WHERE name = 'William Tatcher')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Pokimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez')),
((SELECT id FROM species WHERE name = 'Digimon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'));


-- Insert data for visits table
INSERT INTO visits (
  animal_id,
  vet_id,
  date_of_visit
) VALUES 
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-5-24'),
    ((SELECT id FROM animals WHERE name = 'Agumon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-7-22'),
    ((SELECT id FROM animals WHERE name = 'Gabumon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-2'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-1-5'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-8'),
    ((SELECT id FROM animals WHERE name = 'Pikachu'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-3-14'),
    ((SELECT id FROM animals WHERE name = 'Devimon'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2021-3-4'),
    ((SELECT id FROM animals WHERE name = 'Charmander'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2021-2-24'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-12-21'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2020-8-10'),
    ((SELECT id FROM animals WHERE name = 'Plantmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2021-4-7'),
    ((SELECT id FROM animals WHERE name = 'Squirtle'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2019-9-29'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-10-3'),
    ((SELECT id FROM animals WHERE name = 'Angemon'), (SELECT id FROM vets WHERE name = 'Jack Harkness'), '2020-11-4'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-1-24'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2019-5-15'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-2-27'),
    ((SELECT id FROM animals WHERE name = 'Boarmon'), (SELECT id FROM vets WHERE name = 'Maisy Smith'), '2020-8-3'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'Stephanie Mendez'), '2020-8-24'),
    ((SELECT id FROM animals WHERE name = 'Blossom'), (SELECT id FROM vets WHERE name = 'William Tatcher'), '2021-1-11');

