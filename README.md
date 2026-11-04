# 👨‍💼 ScienceQtech Employee Performance Mapping | SQL Project

![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

## 📌 Business Problem
ScienceQtech wants to evaluate employee performance for HR decisions. HR needs to know:
Who are top performers? What salary to give by role? Who should be promoted based on experience?

## 🎯 Objective
Analyze 3 tables to help HR in performance mapping, salary distribution and project allocation using SQL.

## 🗂️ Database Design
**Database:** `employee`
- `emp_record_table` - 13 columns: EMP_ID, Name, Role, Dept, Exp, Salary, Rating, Manager_ID, etc.
- `proj_table` - Project details, Domain, Dates, Status
- `data_science_team` - Data Science team members

## 🛠️ Key SQL Concepts Used
- Filtering: WHERE, BETWEEN, UNION
- Aggregation: GROUP BY, COUNT, AVG, MIN, MAX
- Window Functions: MAX() OVER (PARTITION BY), RANK() OVER
- Views: high_salary_employees
- Subqueries: Nested queries for Exp > 10
- Stored Procedure: get_experienced_employees()
- Stored Function: check_role() - Auto assigns JUNIOR to MANAGER based on Exp
- Indexing: idx_firstname for faster search
- String Functions: CONCAT()

## 🔑 Key Insights
1.  **Rating Analysis:** Segregated employees with rating <2 (needs training), >4 (top performers)
2.  **Salary Benchmark:** Created MIN/MAX salary per role for HR to fix salary bands
3.  **Promotion Logic:** Function automatically maps: 0-2yr=Junior, 3-5yr=Associate, 6-10yr=Senior, 11-12yr=Lead, 12+=Manager
4.  **Bonus:** Bonus = Salary * 5% * Rating - Fair bonus system
5.  **Manager Load:** Found how many reporters each manager handles

## 📁 Files
- `scienceqtech_employee_analysis.sql` - Complete SQL Code (Copy-Paste in MySQL Workbench to run)
- `dataset/` - Add your 3 CSV files here

## 🚀 How to Run
1. Open MySQL Workbench
2. Run `CREATE DATABASE employee; USE employee;`
3. Import CSV files using Import Wizard into 3 tables
4. Run the .sql file

## 👤 Author
**Vikas Gupta** | BBA @ IGNOU | Data Analytics @ Simplilearn
Skills: SQL, Python, Excel, Power BI, Tableau
Looking for: Remote Data Analyst Intern / Junior Roles
