-- Requêtez une base de données avec SQL  
-- Quiz 3 : Appliquer d'autres fonctionnalités à vos requêtes SQL

-- 1 Combien de biens se situent dans cette rue ANNA POLITKOVSKAIA
SELECT *
FROM bien_immo
WHERE voie = "ANNA POLITKOVSKAIA" AND commune = "TOULOUSE"

-- 2 Triez les dates des transactions dans l'ordre décroissant.
-- Quelle est la date la plus récente ?
SELECT * 
FROM transactions
ORDER BY date_vente DESC

-- 3 Réalisez une agrégation pour calculer la moyenne de la colonne prix_m2
-- Fct agrégation(+sieurs val) ==> 1 val
SELECT id_bien, 
        valeur_fonciere_actuelle/surface as prix_m2,
        avg(valeur_fonciere_actuelle/surface) as moyenne_prix_m2
FROM bien_immo

-- 4 Calculer cette même valeur mais pour chaque commune
--Quelle est cette valeur pour la commune de Toulouse ?
--Il est donc conseillé d'inclure dans votre requête la notion de département, afin de différencier ces communes.
SELECT 
    id_bien, 
    valeur_fonciere_actuelle/surface as prix_m2,
    avg(valeur_fonciere_actuelle/surface) as moyenne_prix_m2,
    commune
FROM 
    bien_immo
WHERE 
    commune = "TOULOUSE" AND code_departement = 31

-- 5 Filtrez les communes dont l'estimation du prix moyen au mètre carré actuel < 1 300 EUR/m2.
-- Filtrer sur une fct d'agrégation (avg) => vous ne pouvez pas le faire dans la clause WHERE, mais vous devez le faire dans la clause HAVING.
SELECT 
    commune,
    avg(valeur_fonciere_actuelle/surface) as moyenne_prix_m2_commune
FROM 
    bien_immo
GROUP BY 
    commune
HAVING 
        moyenne_prix_m2_commune < 1300

-- 6 Reprenez la même requête que la question précédente, en filtrant AVANT L'AGRÉGATION sur le département 31.
SELECT 
    commune,
    code_departement,
    avg(valeur_fonciere_actuelle/surface) as moyenne_prix_m2_commune
FROM 
    bien_immo
WHERE         -- Filtre avant agrégation
    code_departement = 31
GROUP BY 
    commune
HAVING 
        moyenne_prix_m2_commune < 1300

