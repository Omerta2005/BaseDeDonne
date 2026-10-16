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

-- Etape 4

CREATE TABLE client(
    id_client SERIAL PRIMARY KEY,
    nom_client VARCHAR(50)
);

ALTER TABLE commande
ADD COLUMN id_client INT;

ALTER TABLE commande
ADD CONSTRAINT fk_commande_client
FOREIGN KEY (id_client)
REFERENCES client(id_client);

INSERT INTO client (nom_client)
VALUES
    ('Mamy Rakoto'),
    ('Soa Randria');

UPDATE commande
SET id_client = 1
WHERE id_commande = 1;

UPDATE commande
SET id_client = NULL
WHERE id_commande = 2;
    
-- Etape 5

CREATE TABLE serveur(
    id_serveur SERIAL PRIMARY KEY,
    nom_serveur VARCHAR(50) NOT NULL
);

CREATE TABLE table_salle(
    id_table SERIAL PRIMARY KEY,
    numero_table INT NOT NULL UNIQUE
);

ALTER TABLE commande
ADD COLUMN id_serveur INT,
ADD COLUMN id_table INT;

ALTER TABLE commande
ADD CONSTRAINT fk_commande_serveur
FOREIGN KEY (id_serveur)
REFERENCES serveur(id_serveur),
ADD CONSTRAINT fk_commande_table_salle
FOREIGN KEY (id_table)
REFERENCES table_salle(id_table);

INSERT INTO serveur (nom_serveur)
VALUES
    ('Njaka Rakoto'),
    ('Lalao Rasoa');

INSERT INTO table_salle (numero_table)
VALUES
    (1),
    (2),
    (3),
    (4),
    (5),
    (6),
    (7),
    (8);

UPDATE commande
SET id_serveur = 1,
    id_table = 1
WHERE id_commande = 1;

UPDATE commande
SET id_serveur = 2,
    id_table = NULL
WHERE id_commande = 2;

ALTER TABLE commande
ALTER COLUMN id_serveur SET NOT NULL;

-- Etape 6
CREATE TABLE type_paiement(
    id_type SERIAL PRIMARY KEY,
    nom VARCHAR(50)
);

INSERT INTO type_paiement(nom)
VALUES
    ('Espece'),
    ('MVola'),
    ('Orange Money'),
    ('Airtel Money');

CREATE TABLE paiement(
    id_paiement SERIAL PRIMARY KEY,
    id_commande INT,
    type_paiement INT,
    montant INT,
    FOREIGN KEY (id_commande) 
    REFERENCES commande(id_commande),
    FOREIGN KEY (type_paiement) 
    REFERENCES type_paiement(id_type)
);

INSERT INTO paiement(id_commande,type_paiement,montant)
VALUES
    (1,1,10000),
    (1,2,5000),
    (2,3,6000);
