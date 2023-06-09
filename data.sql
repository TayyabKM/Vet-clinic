INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Agumon', '2020/02/03', 0, true, 10.2);
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Gabumon', '2018/11/15', 2, true, 8.0);
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Pikachu', '2021/01/07', 1, false, 15.0);
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES ('Devimon', '2017/05/12', 5, true, 11.0);
--Insert new data 
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Charmander',
        '2020-02-08',
        0,
        FALSE,
        -11,
        'Fire Type'
    );
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Plantmon',
        '2021-11-15',
        2,
        TRUE,
        -5.7,
        'Grass Type'
    );
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Squirtle',
        '1993-04-02',
        3,
        FALSE,
        -12.13,
        'Water Type'
    );
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Angemon',
        '2005-06-12',
        1,
        TRUE,
        -45,
        'Holy Type'
    );
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Boarmon',
        '2005-06-07',
        7,
        TRUE,
        20.4,
        'Beast Type'
    );
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Blossom',
        '1998-10-13',
        3,
        TRUE,
        17,
        'Flower Type'
    );
INSERT INTO animals (
        name,
        date_of_birth,
        escape_attempts,
        neutered,
        weight_kg
    )
VALUES (
        'Ditto',
        '2022-05-14',
        4,
        TRUE,
        22,
        'Transforming Type'
    );
INSERT INTO owners (full_name, age)
VALUES ('Sam Smith', 34);
INSERT INTO owners (full_name, age)
VALUES ('Jennifer Orwell', 19);
INSERT INTO owners (full_name, age)
VALUES ('Bob', 45);
INSERT INTO owners (full_name, age)
VALUES ('Melody Pond', 77);
INSERT INTO owners (full_name, age)
VALUES ('Dean Winchester', 14);
INSERT INTO owners (full_name, age)
VALUES ('Jodie Whittaker', 38);
INSERT INTO species (name)
VALUES ('Pokemon');
INSERT INTO species (name)
VALUES ('Digimon');



UPDATE animals
SET species_id = (
        SELECT id
        FROM species
        WHERE name = CASE
                WHEN name ILIKE '%mon' THEN 'Digimon'
                ELSE 'Pokemon'
            END
    );



UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');



INSERT INTO vets (name, age, date_of_graduation) VALUES ('William Tatcher', 45, '2000-04-23');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Maisy Smith', 26, '2019-01-17');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Stephanie Mendez', 64, '1981-05-04');
INSERT INTO vets (name, age, date_of_graduation) VALUES ('Jack Harkness', 38, '2008-06-08');

-- Insert specialty for Vet William Tatcher (specialized in Pokemon)
INSERT INTO specializations (vet_id, species_id) VALUES (1, 1);
-- Insert specialties for Vet Stephanie Mendez (specialized in Digimon and Pokemon)
INSERT INTO specializations (vet_id, species_id) VALUES (3, 2);
INSERT INTO specializations (vet_id, species_id) VALUES (3, 1);
-- Insert specialty for Vet Jack Harkness (specialized in Digimon)
INSERT INTO specializations (vet_id, species_id) VALUES (4, 2);

-- Insert visits
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Agumon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2020-07-22');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Gabumon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2021-02-02');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-01-05');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-03-08');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Pikachu' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-05-14');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Devimon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2021-05-04');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Charmander' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2021-02-24');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2019-12-21');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), '2020-08-10');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Plantmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2021-04-07');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Squirtle' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2019-09-29');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2020-10-03');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Angemon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Jack Harkness' LIMIT 1), '2020-11-04');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2019-01-24');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2019-05-15');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-02-27');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Boarmon' LIMIT 1), (SELECT id FROM vets WHERE name = 'Maisy Smith' LIMIT 1), '2020-08-03');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), (SELECT id FROM vets WHERE name = 'Stephanie Mendez' LIMIT 1), '2020-05-24');
INSERT INTO visits (animal_id, vet_id, visit_date)
VALUES ((SELECT id FROM animals WHERE name = 'Blossom' LIMIT 1), (SELECT id FROM vets WHERE name = 'William Tatcher' LIMIT 1), '2021-01-11');
