-- Phase 1 : Préparation de la table globale (avec les données mondes)

-- Création de la nouvelle table filtrée et harmonisée
CREATE TABLE global_data_analyst_raw AS
SELECT
    work_year,
    experience_level,
    employment_type,
    company_location,
    company_size,
    
    -- Précision du rôle focalisé pour le projet
    'Data Analyst' AS job_category,
    
    -- Harmonisation en EUROS : Utilisation de la colonne USD du dataset * 0.95 (Taux fixe estimé)
    (salary_in_usd * 0.95) AS salary_eur_harmonized 
    
FROM data_jobs
WHERE 
    -- Filtration uniquement sur les postes contenant le mot 'Analyst' (ignorant la casse)
    job_title ILIKE '%analyst%' 
    -- Exclusion des enregistrements sans salaire valide pour ne pas fausser les moyennes
    AND salary_in_usd > 0;

-- Vérification et comptage des résultats
SELECT COUNT(*) AS total_data_analyst_jobs FROM global_data_analyst_raw;
SELECT * FROM global_data_analyst_raw;
