# PCOS-ANALYSIS
A real-world healthcare data analysis project focused on PCOS (Polycystic Ovary Syndrome) using SQL, AWS RDS (PostgreSQL), and Tableau. It includes data cleaning, cloud-based SQL queries, and interactive visualizations to explore health patterns.
# PCOS Health Insights Using SQL, AWS Cloud & Tableau
👋 Hi! I'm Roshini Rangani, and this is one of my favorite data analysis projects where I used real-world health data to learn and explore patterns related to PCOS (Polycystic Ovary Syndrome). This beginner-friendly project helped me understand how SQL and cloud technologies can be used for meaningful insights in healthcare.
## 💡 Project Objective
To explore key health indicators like age, hormone levels, symptoms, lifestyle habits, and menstrual patterns in women with and without PCOS — using structured SQL queries and cloud-hosted databases, and visualizing the results with Tableau.
## 📊 Tools & Technologies
- **SQL** (PostgreSQL): Data querying, filtering, aggregations  
- **AWS RDS**: Cloud-hosted PostgreSQL database  
- **pgAdmin**: For writing and testing queries  
- **Python/Excel**: For data cleaning  
- **Tableau**: For creating the final dashboard
## 🧼 Dataset Used
- 📁 Source: [Kaggle PCOS Dataset](https://www.kaggle.com/datasets/farahmandfarrah/pcos-dataset)
- Files used:
  - `PCOS_data_without_infertility.xlsx`
  - `PCOS_infertility.csv`
Features include:
- Age, BMI, Hormone levels (LH, FSH, AMH, TSH, etc.)
- Lifestyle habits (exercise, fast food)
- Symptoms (acne, hair growth, skin darkening)
- PCOS Diagnosis status (Y/N)
## 🧹 Data Cleaning Steps
- Removed duplicates and blank rows
- Renamed columns for SQL compatibility (e.g., `Weight (Kg)` → `weight_kg`)
- Standardized Yes/No/Irregular/Regular values
- Converted datatypes (e.g., weight, BMI) into numeric
- Saved clean data into CSV ready for AWS import
## ☁️ Cloud Setup
- Created AWS RDS PostgreSQL instance
- Imported cleaned CSVs into cloud database
- Connected using pgAdmin for writing SQL queries
## 🔍 SQL Insights Covered
1. PCOS vs Non-PCOS distribution  
2. PCOS by age group  
3. BMI and average age analysis  
4. Exercise impact on PCOS  
5. Pregnancy chances with/without PCOS  
6. Menstrual cycle and symptom patterns  
7. Hormonal imbalance insights (AMH, LH, FSH, LH/FSH ratio)  
8. Fast food consumption effect  
9. Waist-Hip ratio comparison
All SQL queries are included in the `/SQL_Queries` folder.
## 📊 Tableau Dashboard
Interactive dashboard built in Tableau, showing:
- PCOS distribution across groups
- Hormonal differences
- Impact of lifestyle choices
- Fertility and menstrual data
👉 **View dashboard here:**  
🔗 https://public.tableau.com/app/profile/roshini.rangani/viz/PCOSANALYSIS-ROSHINIRANGANI/Dashboard1?publish=yes
## 🧠 What I Learned
- Cleaning and structuring real-world health data
- Hosting data on AWS RDS (cloud environment)
- Writing and optimizing SQL queries
- Turning insights into visuals using Tableau
- How data can support health awareness and early insights


