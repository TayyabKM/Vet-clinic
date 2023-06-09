CREATE TABLE animals (
    id INT NOT NULL IDENTITY(1, 1) PRIMARY KEY,
    name VARCHAR(255),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL(5, 2)
);



--modify table
ALTER TABLE animals
ADD species varchar(255);



CREATE TABLE owners (
  id SERIAL PRIMARY KEY,
  full_name VARCHAR(255),
  age INTEGER
);


CREATE TABLE species (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);



-- Drop existing foreign key constraints
ALTER TABLE animals DROP CONSTRAINT IF EXISTS animals_species_id_fkey;
ALTER TABLE animals DROP CONSTRAINT IF EXISTS animals_owner_id_fkey;

-- Drop the column 'species'
ALTER TABLE animals DROP COLUMN IF EXISTS species;

-- Add a new column 'species_id' as foreign key referencing 'species' table
ALTER TABLE animals ADD COLUMN species_id INTEGER REFERENCES species(id);

-- Add a new column 'owner_id' as foreign key referencing 'owners' table
ALTER TABLE animals ADD COLUMN owner_id INTEGER REFERENCES owners(id);



CREATE TABLE vets (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  age INTEGER,
  date_of_graduation DATE
);

CREATE TABLE specializations (
  vet_id INTEGER,
  species_id INTEGER,
  PRIMARY KEY (vet_id, species_id),
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (species_id) REFERENCES species (id)
);

CREATE TABLE visits (
  vet_id INTEGER,
  animal_id INTEGER,
  visit_date DATE,
  FOREIGN KEY (vet_id) REFERENCES vets (id),
  FOREIGN KEY (animal_id) REFERENCES animals (id)
);
