-- ==========================================================
-- Project      : HR Attrition Analysis
-- Database     : hr_attrition_db
-- Database     : MySQL
-- Description  : SQL Script for HR Attrition Analysis
-- ==========================================================

-- ==========================================================
-- Create Database
-- ==========================================================

DROP DATABASE IF EXISTS hr_attrition_db;
CREATE DATABASE hr_attrition_db;
USE hr_attrition_db;

-- ==========================================================
-- Import Dataset
-- ==========================================================

-- Import your CSV using MySQL Workbench:
-- Table Data Import Wizard
-- OR

-- LOAD DATA INFILE 'C:/Your_Path/hr_attrition.csv'
-- INTO TABLE hr_attrition
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- ==========================================================
-- SQL Queries
-- ==========================================================

-- 1. View Complete Dataset
SELECT * FROM hr_attrition;

-- 2. Total Employees
SELECT COUNT(*) AS Total_Employees
FROM hr_attrition;

-- 3. Total Employees Left
SELECT COUNT(*) AS Employees_Left
FROM hr_attrition
WHERE Attrition = 'Yes';

-- 4. Employee Attrition Rate
SELECT
ROUND(
COUNT(CASE WHEN Attrition='Yes' THEN 1 END)*100.0/COUNT(*),2
) AS Attrition_Rate
FROM hr_attrition;

-- 5. Department-wise Employee Count
SELECT
Department,
COUNT(*) AS Total_Employees
FROM hr_attrition
GROUP BY Department
ORDER BY Total_Employees DESC;

-- 6. Department-wise Attrition
SELECT
Department,
COUNT(*) AS Employees_Left
FROM hr_attrition
WHERE Attrition='Yes'
GROUP BY Department
ORDER BY Employees_Left DESC;

-- 7. Job Role-wise Attrition
SELECT
Job_Role,
COUNT(*) AS Employees_Left
FROM hr_attrition
WHERE Attrition='Yes'
GROUP BY Job_Role
ORDER BY Employees_Left DESC;

-- 8. Average Salary by Department
SELECT
Department,
ROUND(AVG(Monthly_Salary),2) AS Avg_Salary
FROM hr_attrition
GROUP BY Department
ORDER BY Avg_Salary DESC;

-- 9. Overtime vs Attrition
SELECT
Overtime,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM hr_attrition
GROUP BY Overtime;

-- 10. Work-Life Balance Analysis
SELECT
Work_Life_Balance,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM hr_attrition
GROUP BY Work_Life_Balance;

-- 11. Job Satisfaction Analysis
SELECT
Job_Satisfaction,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM hr_attrition
GROUP BY Job_Satisfaction;

-- 12. Average Years at Company
SELECT
ROUND(AVG(Years_at_Company),2) AS Avg_Years
FROM hr_attrition;

-- 13. Promotion vs Attrition
SELECT
Promotion_Last_3_Years,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM hr_attrition
GROUP BY Promotion_Last_3_Years;

-- 14. Remote Work Analysis
SELECT
Remote_Work,
COUNT(*) AS Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM hr_attrition
GROUP BY Remote_Work;

-- 15. Highest Paid Employees
SELECT
Employee_ID,
Department,
Job_Role,
Monthly_Salary
FROM hr_attrition
ORDER BY Monthly_Salary DESC
LIMIT 10;

-- 16. Lowest Paid Employees
SELECT
Employee_ID,
Department,
Job_Role,
Monthly_Salary
FROM hr_attrition
ORDER BY Monthly_Salary ASC
LIMIT 10;

-- 17. Average Salary of Employees Who Left vs Stayed
SELECT
Attrition,
ROUND(AVG(Monthly_Salary),2) AS Average_Salary
FROM hr_attrition
GROUP BY Attrition;

-- 18. Top 5 Departments by Attrition
SELECT
Department,
COUNT(*) AS Attrition_Count
FROM hr_attrition
WHERE Attrition='Yes'
GROUP BY Department
ORDER BY Attrition_Count DESC
LIMIT 5;

-- 19. Employee Distribution by Gender
SELECT
Gender,
COUNT(*) AS Total_Employees
FROM hr_attrition
GROUP BY Gender;

-- 20. Overall HR KPI Summary
SELECT
COUNT(*) AS Total_Employees,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Employees_Left,
ROUND(SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS Attrition_Rate,
ROUND(AVG(Monthly_Salary),2) AS Average_Salary,
ROUND(AVG(Age),1) AS Average_Age,
ROUND(AVG(Years_at_Company),1) AS Average_Years_at_Company
FROM hr_attrition;