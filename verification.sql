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

-- ETAPE 4
SELECT
    co.id_commande,
    COALESCE(cl.nom_client, 'client de passage') AS client
FROM commande co
LEFT JOIN client cl
    ON co.id_client = cl.id_client
ORDER BY co.id_commande;

-- ETAPE 5
SELECT
    s.nom_serveur,
    COUNT(co.id_commande) AS nombre_commandes,
    COALESCE(SUM(vc.total), 0) AS chiffre_affaires
FROM serveur s
LEFT JOIN commande co
    ON s.id_serveur = co.id_serveur
LEFT JOIN view_commande vc
    ON co.id_commande = vc.id_commande
GROUP BY s.id_serveur, s.nom_serveur
ORDER BY s.id_serveur;

-- Etape 6

SELECT v_com.id_commande,
         v_com.total AS montant_du,
         SUM(p.montant) AS montant_payee,
         v_com.total - SUM(p.montant) AS Reste_a_payer
FROM view_commande v_com
LEFT JOIN paiement p
    ON v_com.id_commande = p.id_commande
GROUP BY v_com.id_commande, v_com.total
ORDER BY v_com.id_commande;
    