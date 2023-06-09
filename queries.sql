SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;



--setting the species column to unspecified
BEGIN;

UPDATE animals
SET species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;



-- Start the transaction
BEGIN;

-- Update the animals table by setting the species column to 'digimon' for animals whose name ends in 'mon'
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';

-- Update the animals table by setting the species column to 'pokemon' for animals that don't have a species already set
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

-- Verify the changes within the transaction
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Verify the changes persist after the commit
SELECT * FROM animals;



BEGIN;

-- Delete all records in the animals table
DELETE FROM animals;

-- Verify that all records are deleted within the transaction
SELECT * FROM animals;

-- Rollback the transaction
ROLLBACK;



-- Start the transaction
BEGIN;

-- Delete all animals born after Jan 1st, 2022
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;



UPDATE animals
SET weight_kg = weight_kg * -1;

-- Rollback to the savepoint
ROLLBACK TO my_savepoint;


-- Update all animals' weights that are negative to be their weight multiplied by -1
UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

-- Commit the transaction
COMMIT;



SELECT COUNT(*) AS total_animals
FROM animals;

SELECT COUNT(*) AS animals_no_escape_attempts
FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight_kg) AS average_weight
FROM animals;


SELECT neutered, SUM(escape_attempts) AS total_escape_attempts
FROM animals
GROUP BY neutered
ORDER BY total_escape_attempts DESC
LIMIT 1;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals
GROUP BY species;

SELECT species, AVG(escape_attempts) AS average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;



SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY COUNT(a.id) DESC
LIMIT 1;


--To find the corresponding vet and species IDs for the specialties
-- Find the vet ID for William Tatcher
SELECT id FROM vets WHERE name = 'William Tatcher';

-- Find the vet ID for Stephanie Mendez
SELECT id FROM vets WHERE name = 'Stephanie Mendez';

-- Find the vet ID for Jack Harkness
SELECT id FROM vets WHERE name = 'Jack Harkness';

-- Find the species ID for Pokemon
SELECT id FROM species WHERE name = 'Pokemon';

-- Find the species ID for Digimon
SELECT id FROM species WHERE name = 'Digimon';



SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vt ON v.vet_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id) AS total_animals
FROM visits AS v
JOIN vets AS vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

SELECT vt.name AS vet_name, s.name AS specialty_name
FROM vets AS vt
LEFT JOIN specializations AS sp ON vt.id = sp.vet_id
LEFT JOIN species AS s ON sp.species_id = s.id;

SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS animal_name, COUNT(*) AS total_visits
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY COUNT(*) DESC
LIMIT 1;

SELECT a.name AS animal_name
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date
LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM animals AS a
JOIN visits AS v ON a.id = v.animal_id
JOIN vets AS vt ON v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(*) AS total_visits
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vt ON v.vet_id = vt.id
LEFT JOIN specializations AS sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

SELECT s.name AS specialty_name, COUNT(*) AS total_visits
FROM visits AS v
JOIN animals AS a ON v.animal_id = a.id
JOIN vets AS vt ON v.vet_id = vt.id
JOIN specializations AS sp ON vt.id = sp.vet_id
JOIN species AS s ON sp.species_id = s.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(*) DESC
LIMIT 1;
