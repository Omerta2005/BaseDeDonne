**CARTE**(**id_plat**, nom_plat, categorie_plat, prix, #id_categorie)

**CATEGORIE**(**id_categorie**, nom_categorie)

**COMMANDE**(**id_commande**, date_commande, #id_client?, #id_serveur, #id_table?)

**COMMANDE_PLAT**(**id_commande_plat**, #id_plat, #id_commande, quantite)

**CLIENT**(**id_client**, nom_client)

**SERVEUR**(**id_serveur**, nom_serveur)

**TABLE_SALLE**(**id_table**, numero_table)

**TYPE_PAIEMENT**(**id_type**, nom)

**PAIEMENT**(**id_paiement**,#id_commande,#type_paiement, montant)
