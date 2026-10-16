-- Etape 1
CREATE TABLE carte(
    id_plat SERIAL PRIMARY KEY,
    nom_plat VARCHAR(50),
    categorie_plat VARCHAR(50),
    prix INT
);

INSERT INTO carte (nom_plat,categorie_plat,prix)
VALUES
    ('Romazava', 'Plat malagasy', 7000),
    ('Ravitoto sy henakisoa', 'Plat malagasy', 8000),
    ('Akoho sy voanio', 'Plat malagasy', 8500),
    ('Mi sao', 'Plat chinois', 6000),
    ('Mofo gasy (les 4)', 'Dessert et goûter', 1000),
    ('Ranon`ampango', 'Boisson', 500);


-- Etape 2
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

--Etape 3

CREATE TABLE commande(
    id_commande SERIAL PRIMARY KEY,
    date_commande DATE
);

CREATE TABLE commande_plat(
    id_commande_plat SERIAL PRIMARY KEY,
    id_plat INT,
    id_commande INT,
    quantite INT,
    FOREIGN KEY (id_plat) REFERENCES carte(id_plat),
    FOREIGN KEY (id_commande) REFERENCES commande(id_commande)
);

CREATE OR REPLACE VIEW view_commande AS
SELECT
    commande.id_commande,
    commande.date_commande,
    SUM(carte.prix * commande_plat.quantite) AS total
FROM commande
JOIN commande_plat
    ON commande.id_commande = commande_plat.id_commande
JOIN carte
    ON commande_plat.id_plat = carte.id_plat
GROUP BY
    commande.id_commande,
    commande.date_commande
ORDER BY
    commande.id_commande ASC;

INSERT INTO commande (date_commande)
VALUES
    ('2023-01-01'),
    ('2023-01-02');

INSERT INTO commande_plat (id_plat, id_commande, quantite)
VALUES
    (1, 1, 2),
    (2, 1, 1),
    (3, 2, 3),
    (4, 2, 1);
