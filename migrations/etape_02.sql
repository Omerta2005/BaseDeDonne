CREATE TABLE carte(
    id_plat SERIAL PRIMARY KEY,
    nom_plat VARCHAR(50),
    categorie_plat VARCHAR(50),
    prix INT
);

CREATE TABLE categorie(
    id_categorie SERIAL PRIMARY KEY,
    nom_categorie VARCHAR(50)
);

INSERT INTO categorie(nom_categorie)
VALUES
    ('plat malagasy'),
    ('plat chinois'),
    ('soupe'),
    ('dessert'),
    ('boisson');

ALTER TABLE carte
ADD COLUMN id_categorie INT;

ALTER TABLE carte
ADD CONSTRAINT fk_carte_categorie
FOREIGN KEY (id_categorie)
REFERENCES categorie(id_categorie);
UPDATE carte
SET categorie_plat ='dessert' WHERE categorie_plat = 'Dessert et goûter';

UPDATE carte
SET id_categorie = (
    SELECT id_categorie
    FROM categorie
    WHERE LOWER(nom_categorie) = LOWER(carte.categorie_plat)
);




