

-- Phase 2 : Voir Script Python.

-- Phase 3 : Création de la table pour importer les données enrichies

CREATE TABLE global_data_analyst_enriched (
    work_year INT,
    experience_level VARCHAR(50),
    employment_type VARCHAR(50),
    company_location VARCHAR(50),
    company_size VARCHAR(50),
    job_category VARCHAR(50),
    salary_eur_harmonized DECIMAL(10, 2), -- Colonne monétaire avec 2 décimales
    country_name VARCHAR(100),            -- Nom complet du pays (Obtenu via Python)
    country_code_3 VARCHAR(5)             -- Code ISO à 3 lettres (Obtenu via Python)
);

-- Calcul final des KPIs par Pays pour la Carte du Monde
SELECT
    country_name,
    country_code_3, 
    COUNT(*) AS total_jobs,
    ROUND(AVG(salary_eur_harmonized)) AS avg_salary_eur,
    MAX(salary_eur_harmonized) AS max_salary_eur,
    ROUND(STDDEV(salary_eur_harmonized)) AS stddev_salary -- Volatilité du salaire par pays
FROM global_data_analyst_enriched
GROUP BY 1, 2
HAVING COUNT(*) >= 5 -- Filtre sur les pays avec moins de 5 échantillons pour une moyenne plus fiable
ORDER BY avg_salary_eur DESC;