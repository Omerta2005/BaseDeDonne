-- ETAPE 1
SELECT * FROM carte ORDER BY prix ASC;

-- ETAPE 2
SELECT
    cat.nom_categorie,
    COUNT(c.id_plat) AS nombre_plats
FROM categorie cat
LEFT JOIN carte c
    ON cat.id_categorie = c.id_categorie
GROUP BY cat.id_categorie, cat.nom_categorie
ORDER BY cat.nom_categorie;

-- ETAPE 3
SELECT * FROM view_commande;