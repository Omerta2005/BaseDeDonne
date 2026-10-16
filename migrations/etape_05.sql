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