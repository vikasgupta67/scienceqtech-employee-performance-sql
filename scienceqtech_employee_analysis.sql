-- ScienceQtech Employee Performance Mapping | By Vikas Gupta
-- Database: MySQL

CREATE DATABASE employee;
USE employee;

CREATE TABLE emp_record_table (
    EMP_ID INT, FIRST_NAME VARCHAR(50), LAST_NAME VARCHAR(50),
    GENDER VARCHAR(10), ROLE VARCHAR(100), DEPT VARCHAR(50),
    EXP INT, COUNTRY VARCHAR(50), CONTINENT VARCHAR(50),
    SALARY INT, EMP_RATING INT, MANAGER_ID INT, PROJ_ID INT
);

CREATE TABLE proj_table (
    PROJECT_ID INT, PROJ_NAME VARCHAR(100), DOMAIN VARCHAR(50),
    START_DATE DATE, CLOSURE_DATE DATE, DEV_QTR VARCHAR(10), STATUS VARCHAR(50)
);

CREATE TABLE data_science_team (
    EMP_ID INT, FIRST_NAME VARCHAR(50), LAST_NAME VARCHAR(50),
    GENDER VARCHAR(10), ROLE VARCHAR(100), DEPT VARCHAR(50),
    EXP INT, COUNTRY VARCHAR(50), CONTINENT VARCHAR(50)
);

-- 1. Employee Details
SELECT EMP_ID, FIRST_NAME, LAST_NAME, GENDER, DEPT FROM emp_record_table;

-- 2. Performance Rating Analysis
SELECT * FROM emp_record_table WHERE EMP_RATING < 2;
SELECT * FROM emp_record_table WHERE EMP_RATING > 4;
SELECT * FROM emp_record_table WHERE EMP_RATING BETWEEN 2 AND 4;

-- 3. Finance Dept Names
SELECT CONCAT(FIRST_NAME, ' ', LAST_NAME) AS NAME FROM emp_record_table WHERE DEPT = 'FINANCE';

-- 4. Manager Reporting
SELECT MANAGER_ID, COUNT(*) AS REPORTERS FROM emp_record_table GROUP BY MANAGER_ID;

-- 5. UNION Healthcare + Finance
SELECT * FROM emp_record_table WHERE DEPT = 'HEALTHCARE'
UNION SELECT * FROM emp_record_table WHERE DEPT = 'FINANCE';

-- 6. Window Function - Max Rating per Dept
SELECT EMP_ID, FIRST_NAME, LAST_NAME, ROLE, DEPT, EMP_RATING,
MAX(EMP_RATING) OVER (PARTITION BY DEPT) AS MAX_DEPT_RATING
FROM emp_record_table;

-- 7. Salary Range by Role
SELECT ROLE, MIN(SALARY) AS MIN_SALARY, MAX(SALARY) AS MAX_SALARY
FROM emp_record_table GROUP BY ROLE;

-- 8. Rank by Experience
SELECT EMP_ID, FIRST_NAME, EXP,
RANK() OVER (ORDER BY EXP DESC) AS RANKING FROM emp_record_table;

-- 9. View - High Salary Employees
CREATE VIEW high_salary_employees AS
SELECT * FROM emp_record_table WHERE SALARY > 6000;

-- 10. Subquery - Exp > 10 years
SELECT * FROM emp_record_table WHERE EMP_ID IN (SELECT EMP_ID FROM emp_record_table WHERE EXP > 10);

-- 11. Stored Procedure
DELIMITER //
CREATE PROCEDURE get_experienced_employees()
BEGIN SELECT * FROM emp_record_table WHERE EXP > 3; END //
DELIMITER ;
CALL get_experienced_employees();

-- 12. Stored Function - Role Mapping
DELIMITER //
CREATE FUNCTION check_role(exp INT) RETURNS VARCHAR(50) DETERMINISTIC
BEGIN
    DECLARE job_role VARCHAR(50);
    IF exp <= 2 THEN SET job_role = 'JUNIOR DATA SCIENTIST';
    ELSEIF exp <= 5 THEN SET job_role = 'ASSOCIATE DATA SCIENTIST';
    ELSEIF exp <= 10 THEN SET job_role = 'SENIOR DATA SCIENTIST';
    ELSEIF exp <= 12 THEN SET job_role = 'LEAD DATA SCIENTIST';
    ELSE SET job_role = 'MANAGER'; END IF;
    RETURN job_role;
END //
DELIMITER ;

SELECT EMP_ID, FIRST_NAME, EXP, CHECK_ROLE(EXP) AS EXPECTED_ROLE FROM data_science_team;

-- 13. Indexing for Performance
CREATE INDEX idx_firstname ON emp_record_table(FIRST_NAME(50));
EXPLAIN SELECT * FROM emp_record_table WHERE FIRST_NAME = 'Eric';

-- 14. Bonus Calculation
SELECT EMP_ID, FIRST_NAME, SALARY, EMP_RATING,
(SALARY * 0.05 * EMP_RATING) AS BONUS FROM emp_record_table;

-- 15. Avg Salary by Continent & Country
SELECT CONTINENT, COUNTRY, AVG(SALARY) AS AVG_SALARY
FROM emp_record_table GROUP BY CONTINENT, COUNTRY;
