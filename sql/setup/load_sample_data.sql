-- =================================================================
-- HR Demo Sample Data Loading Script
-- Loads realistic sample data for AI-powered Oracle development demo
-- =================================================================

-- Clear existing data
DELETE FROM employees;
DELETE FROM departments;

-- Reset sequences
DROP SEQUENCE dept_seq;
DROP SEQUENCE emp_seq;
CREATE SEQUENCE dept_seq START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE emp_seq START WITH 1000 INCREMENT BY 1;

-- Insert department data
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (10, 'Administration', 200, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (20, 'Marketing', 201, 1800);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (30, 'Purchasing', 114, 1700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (40, 'Human Resources', 203, 2400);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (50, 'Shipping', 121, 1500);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (60, 'IT', 103, 1400);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (70, 'Public Relations', 204, 2700);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (80, 'Sales', 145, 2500);
INSERT INTO departments (department_id, department_name, manager_id, location_id) VALUES
    (90, 'Executive', 100, 1700);

-- Insert employee data with mix of recent and older hire dates
-- Executive team
INSERT INTO employees VALUES (100, 'Steven', 'King', 'SKING', '515.123.4567', 
    DATE '2020-06-17', 'AD_PRES', 24000, NULL, NULL, 90);
INSERT INTO employees VALUES (101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', 
    DATE '2021-09-21', 'AD_VP', 17000, NULL, 100, 90);
INSERT INTO employees VALUES (102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', 
    DATE '2024-01-13', 'AD_VP', 17000, NULL, 100, 90);

-- IT Department - mix of tenured and recent hires
INSERT INTO employees VALUES (103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', 
    DATE '2024-08-15', 'IT_PROG', 9000, NULL, 102, 60);
INSERT INTO employees VALUES (104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', 
    DATE '2024-09-30', 'IT_PROG', 6000, NULL, 103, 60);
INSERT INTO employees VALUES (105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', 
    DATE '2023-06-25', 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO employees VALUES (106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', 
    DATE '2024-11-05', 'IT_PROG', 4800, NULL, 103, 60);
INSERT INTO employees VALUES (107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', 
    DATE '2023-02-07', 'IT_PROG', 4200, NULL, 103, 60);

-- Purchasing Department
INSERT INTO employees VALUES (114, 'Den', 'Raphaely', 'DRAPHEAL', '515.127.4561', 
    DATE '2022-12-07', 'PU_MAN', 11000, NULL, 100, 30);
INSERT INTO employees VALUES (115, 'Alexander', 'Khoo', 'AKHOO', '515.127.4562', 
    DATE '2024-07-18', 'PU_CLERK', 3100, NULL, 114, 30);
INSERT INTO employees VALUES (116, 'Shelli', 'Baida', 'SBAIDA', '515.127.4563', 
    DATE '2023-12-24', 'PU_CLERK', 2900, NULL, 114, 30);

-- Shipping Department - recent expansion
INSERT INTO employees VALUES (121, 'Adam', 'Fripp', 'AFRIPP', '650.123.2234', 
    DATE '2022-04-10', 'ST_MAN', 8200, NULL, 100, 50);
INSERT INTO employees VALUES (122, 'Payam', 'Kaufling', 'PKAUFLIN', '650.123.3234', 
    DATE '2024-10-01', 'ST_CLERK', 2200, NULL, 121, 50);
INSERT INTO employees VALUES (123, 'Shanta', 'Vollman', 'SVOLLMAN', '650.123.4234', 
    DATE '2024-08-10', 'ST_CLERK', 2200, NULL, 121, 50);
INSERT INTO employees VALUES (124, 'Kevin', 'Mourgos', 'KMOURGOS', '650.123.5234', 
    DATE '2024-11-16', 'ST_CLERK', 2200, NULL, 121, 50);

-- Sales Department - high commission structure
INSERT INTO employees VALUES (145, 'John', 'Russell', 'JRUSSEL', '011.44.1344.429268', 
    DATE '2022-10-01', 'SA_MAN', 14000, 0.40, 100, 80);
INSERT INTO employees VALUES (146, 'Karen', 'Partners', 'KPARTNER', '011.44.1344.467268', 
    DATE '2024-01-05', 'SA_MAN', 13500, 0.30, 100, 80);
INSERT INTO employees VALUES (147, 'Alberto', 'Errazuriz', 'AERRAZUR', '011.44.1344.429278', 
    DATE '2024-03-10', 'SA_MAN', 12000, 0.30, 100, 80);
INSERT INTO employees VALUES (148, 'Gerald', 'Cambrault', 'GCAMBRAU', '011.44.1344.619268', 
    DATE '2024-06-15', 'SA_MAN', 11000, 0.30, 100, 80);
INSERT INTO employees VALUES (149, 'Eleni', 'Zlotkey', 'EZLOTKEY', '011.44.1344.429018', 
    DATE '2024-09-29', 'SA_MAN', 10500, 0.20, 100, 80);

-- Sales Representatives - recent hires
INSERT INTO employees VALUES (150, 'Peter', 'Tucker', 'PTUCKER', '011.44.1344.129268', 
    DATE '2024-07-30', 'SA_REP', 10000, 0.30, 145, 80);
INSERT INTO employees VALUES (151, 'David', 'Bernstein', 'DBERNSTE', '011.44.1344.345268', 
    DATE '2024-08-24', 'SA_REP', 9500, 0.25, 145, 80);
INSERT INTO employees VALUES (152, 'Peter', 'Hall', 'PHALL', '011.44.1344.478968', 
    DATE '2024-10-20', 'SA_REP', 9000, 0.25, 145, 80);

-- Administration
INSERT INTO employees VALUES (200, 'Jennifer', 'Whalen', 'JWHALEN', '515.123.4444', 
    DATE '2021-09-17', 'AD_ASST', 4400, NULL, 101, 10);

-- Marketing
INSERT INTO employees VALUES (201, 'Michael', 'Hartstein', 'MHARTSTE', '515.123.5555', 
    DATE '2023-02-17', 'MK_MAN', 13000, NULL, 100, 20);
INSERT INTO employees VALUES (202, 'Pat', 'Fay', 'PFAY', '603.123.6666', 
    DATE '2024-12-17', 'MK_REP', 6000, NULL, 201, 20);

-- Human Resources
INSERT INTO employees VALUES (203, 'Susan', 'Mavris', 'SMAVRIS', '515.123.7777', 
    DATE '2022-06-07', 'HR_REP', 6500, NULL, 101, 40);

-- Public Relations
INSERT INTO employees VALUES (204, 'Hermann', 'Baer', 'HBAER', '515.123.8888', 
    DATE '2022-06-07', 'PR_REP', 10000, NULL, 101, 70);

-- Update department managers (now that employees exist)
UPDATE departments SET manager_id = 200 WHERE department_id = 10;
UPDATE departments SET manager_id = 201 WHERE department_id = 20;
UPDATE departments SET manager_id = 114 WHERE department_id = 30;
UPDATE departments SET manager_id = 203 WHERE department_id = 40;
UPDATE departments SET manager_id = 121 WHERE department_id = 50;
UPDATE departments SET manager_id = 103 WHERE department_id = 60;
UPDATE departments SET manager_id = 204 WHERE department_id = 70;
UPDATE departments SET manager_id = 145 WHERE department_id = 80;
UPDATE departments SET manager_id = 100 WHERE department_id = 90;

COMMIT;

-- Display summary statistics
PROMPT
PROMPT ===================================
PROMPT Sample Data Loaded Successfully!
PROMPT ===================================

SELECT 'DEPARTMENTS' as table_name, COUNT(*) as row_count FROM departments
UNION ALL
SELECT 'EMPLOYEES' as table_name, COUNT(*) as row_count FROM employees
ORDER BY table_name;

PROMPT
PROMPT Department Summary:
SELECT 
    d.department_name,
    COUNT(e.employee_id) as employee_count,
    ROUND(AVG(e.salary), 2) as avg_salary,
    MIN(e.hire_date) as earliest_hire,
    MAX(e.hire_date) as latest_hire
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;

PROMPT
PROMPT Recent Hires (2024):
SELECT 
    first_name || ' ' || last_name as employee_name,
    hire_date,
    job_id,
    d.department_name,
    salary
FROM employees e
JOIN departments d ON e.department_id = d.department_id
WHERE hire_date >= DATE '2024-01-01'
ORDER BY hire_date DESC;

PROMPT
PROMPT ===================================
PROMPT Ready for AI-powered analysis!
PROMPT Try these sample prompts in Cline:
PROMPT 
PROMPT "Show me employees hired in 2024"
PROMPT "Which department has highest average salary?"
PROMPT "Find potential salary outliers"
PROMPT "Create an HR dashboard"
PROMPT ===================================