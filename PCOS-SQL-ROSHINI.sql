-- Show the structure of the table (column names, types, etc.)
SELECT 
  column_name, 
  data_type
FROM 
  information_schema.columns
WHERE 
  table_name = 'pcos_data';

-- Display first 10 rows of the table
SELECT * 
FROM pcos_data 
LIMIT 10;
-- Total number of records in the dataset
SELECT COUNT(*) AS total_patients
FROM pcos_data;

-- Get the number and percentage of patients with and without PCOS
SELECT 
  pcos_y_n,  -- 1 = PCOS, 0 = No PCOS
  COUNT(*) AS total_patients,  -- Count how many patients fall into each category
  ROUND(
    (COUNT(*) * 100.0 / (SELECT COUNT(*) FROM pcos_data)), 2
  ) AS percentage  -- Calculate percentage of total
FROM 
  pcos_data
GROUP BY 
  pcos_y_n;  -- Group by PCOS status (Yes/No)

-- Analyze how PCOS is distributed across different age groups (for text column values)
SELECT 
  CASE
    WHEN age_yrs BETWEEN 15 AND 20 THEN '15-20'WHEN age_yrs BETWEEN 21 AND 25 THEN '21-25'
    WHEN age_yrs BETWEEN 26 AND 30 THEN '26-30'WHEN age_yrs BETWEEN 31 AND 35 THEN '31-35'
    WHEN age_yrs > 35 THEN '36+'
    ELSE 'Unknown' END AS age_group, COUNT(*) AS total_patients,
  SUM(CASE WHEN pcos_y_n = '1' THEN 1 ELSE 0 END) AS pcos_patients,
  ROUND((SUM(CASE WHEN pcos_y_n = '1' THEN 1 ELSE 0 END) * 100.0) / COUNT(*),
    2) AS pcos_percentage
FROM pcos_data GROUP BY age_group ORDER BY age_group;

-- Compare average BMI between patients with and without PCOS
SELECT
  pcos_y_n,
  ROUND(AVG(bmi)::NUMERIC, 2) AS avg_bmi  -- Cast BMI to numeric before rounding
FROM
  pcos_data
GROUP BY
  pcos_y_n;

-- Compare the average age of patients with and without PCOS
SELECT 
  pcos_y_n,
  ROUND(AVG(age_yrs)::NUMERIC, 2) AS avg_age  -- Round average age to 2 decimal places
FROM 
  pcos_data
GROUP BY 
  pcos_y_n;
-- Comparing physical symptoms between PCOS and non-PCOS patients
SELECT 
  pcos_y_n,
  COUNT(*) AS total_patients,
  -- Count of patients reporting hair growth
  SUM(CASE WHEN hair_growth = 'yes' THEN 1 ELSE 0 END) AS hair_growth_cases,
  -- Count of patients reporting pimples
  SUM(CASE WHEN pimples = 'yes' THEN 1 ELSE 0 END) AS pimple_cases,
   -- Count of patients reporting skin darkening
  SUM(CASE WHEN skin_darkening = 'yes' THEN 1 ELSE 0 END) AS skin_darkening_cases
FROM pcos_data GROUP BY pcos_y_n ORDER BY pcos_y_n;

-- Comparing physical symptoms between PCOS and non-PCOS patients
SELECT
  pcos_y_n,
  COUNT(*) AS total_patients,
  -- Count of patients reporting hair growth
  SUM(CASE WHEN hair_growth = '1' THEN 1 ELSE 0 END) AS hair_growth_cases,
  -- Count of patients reporting pimples
  SUM(CASE WHEN pimples = '1' THEN 1 ELSE 0 END) AS pimple_cases,
   -- Count of patients reporting skin darkening
  SUM(CASE WHEN skin_darkening = '1' THEN 1 ELSE 0 END) AS skin_darkening_cases
FROM pcos_data GROUP BY pcos_y_n ORDER BY pcos_y_n;

--Impact of Regular Exercise on PCOS
SELECT
  reg_exercise,
  COUNT(*) AS total_patients,
  SUM(CASE WHEN pcos_y_n = '1' THEN 1 ELSE 0 END) AS pcos_patients,
  ROUND(100.0 * SUM(CASE WHEN pcos_y_n = '1' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pcos_percentage
FROM
  pcos_data
GROUP BY
  reg_exercise;

-- Compare pregnancy status between PCOS and non-PCOS patients
SELECT 
  pcos_y_n,  -- 1 = PCOS, 0 = No PCOS
  COUNT(*) AS total_patients,
-- Count how many were pregnant
  SUM(CASE WHEN pregnanty_n = '1' THEN 1 ELSE 0 END) AS pregnant_patients,
-- Calculate pregnancy percentage
  ROUND(
    100.0 * SUM(CASE WHEN pregnanty_n = '1' THEN 1 ELSE 0 END) / COUNT(*),
    2
  ) AS pregnancy_percentage
FROM pcos_data GROUP BY pcos_y_n ORDER BY pcos_y_n;

-- Compare average menstrual cycle length between PCOS and non-PCOS patients
SELECT
  pcos_y_n,  -- 1 = PCOS, 0 = No PCOS
  COUNT(*) AS total_patients,
  ROUND(AVG(cycle_lengthdays), 1) AS avg_cycle_length
FROM pcos_data
GROUP BY pcos_y_n
ORDER BY pcos_y_n;

-- Grouping patients based on whether they have PCOS or not
SELECT
  pcos_y_n,  -- '1' means diagnosed with PCOS, '0' means not diagnosed

  -- Total number of patients in each group
  COUNT(*) AS total_patients,
-- Average AMH level (Anti-Müllerian Hormone), casted and rounded to 2 decimals
  ROUND(AVG(amh)::NUMERIC, 2) AS avg_amh,
-- Average FSH level (Follicle Stimulating Hormone), casted and rounded
  ROUND(AVG(fsh)::NUMERIC, 2) AS avg_fsh,
-- Average LH level (Luteinizing Hormone), casted and rounded
  ROUND(AVG(lh)::NUMERIC, 2) AS avg_lh,
-- LH to FSH Ratio: casted to numeric before rounding to 2 decimals
  ROUND((AVG(lh) / NULLIF(AVG(fsh), 0))::NUMERIC, 2) AS lh_fsh_ratio
FROM
  pcos_data GROUP BY pcos_y_n
ORDER BY
  pcos_y_n;

-- Insight 11: Relationship between Fast Food Consumption and PCOS
SELECT 
  fast_food,  -- Indicates if the patient consumes fast food
  COUNT(*) AS total_patients,  -- Total patients in each category (Yes/No)
  -- Count of patients diagnosed with PCOS in each category
  SUM(CASE WHEN pcos_y_n = '1' THEN 1 ELSE 0 END) AS pcos_patients,
  -- Count of patients not diagnosed with PCOS in each category
  SUM(CASE WHEN pcos_y_n = '0' THEN 1 ELSE 0 END) AS non_pcos_patients,
   -- Percentage of PCOS cases in each fast food category
  ROUND(100.0 * SUM(CASE WHEN pcos_y_n = '1' THEN 1 ELSE 0 END) / COUNT(*), 2) AS pcos_percentage,
  -- Percentage of non-PCOS cases in each fast food category
  ROUND(100.0 * SUM(CASE WHEN pcos_y_n = '0' THEN 1 ELSE 0 END) / COUNT(*), 2) AS non_pcos_percentage
FROM 
  pcos_data WHERE 
  fast_food IS NOT NULL   GROUP BY  fast_food;

-- Check basic stats and nulls in waist_hip_ratio
SELECT 
  COUNT(*) AS total_rows,
  COUNT(waist_hip_ratio) AS non_null_count,
  MIN(waist_hip_ratio), 
  MAX(waist_hip_ratio),
  ROUND(AVG(waist_hip_ratio::NUMERIC), 2) AS avg_ratio
FROM 
  pcos_data;

  --  Analyze Waist-Hip Ratio between PCOS and Non-PCOS patients
SELECT
  pcos_y_n AS diagnosis_status,
  ROUND(AVG(waist_hip_ratio::NUMERIC), 4) AS avg_waist_hip_ratio
FROM
  pcos_data
GROUP BY
  pcos_y_n;




