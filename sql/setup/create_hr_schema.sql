-- =================================================================
-- HR Demo Schema Creation Script
-- Creates tables for AI-powered Oracle development demo
-- =================================================================

-- Clean up existing objects if they exist
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE departments CASCADE CONSTRAINTS';
EXCEPTION
   WHEN OTHERS THEN NULL;
END;
/

-- Create departments table
CREATE TABLE departments (
    department_id   NUMBER(4) CONSTRAINT dept_id_pk PRIMARY KEY,
    department_name VARCHAR2(30) CONSTRAINT dept_name_nn NOT NULL,
    manager_id      NUMBER(6),
    location_id     NUMBER(4)
);

-- Create employees table
CREATE TABLE employees (
    employee_id     NUMBER(6) CONSTRAINT emp_id_pk PRIMARY KEY,
    first_name      VARCHAR2(20),
    last_name       VARCHAR2(25) CONSTRAINT emp_last_name_nn NOT NULL,
    email           VARCHAR2(25) CONSTRAINT emp_email_nn NOT NULL
                    CONSTRAINT emp_email_uk UNIQUE,
    phone_number    VARCHAR2(20),
    hire_date       DATE CONSTRAINT emp_hire_date_nn NOT NULL,
    job_id          VARCHAR2(10) CONSTRAINT emp_job_nn NOT NULL,
    salary          NUMBER(8,2) CONSTRAINT emp_salary_ck CHECK (salary > 0),
    commission_pct  NUMBER(2,2) CONSTRAINT emp_comm_ck CHECK (commission_pct BETWEEN 0 AND 1),
    manager_id      NUMBER(6),
    department_id   NUMBER(4),
    CONSTRAINT emp_dept_fk FOREIGN KEY (department_id) REFERENCES departments(department_id),
    CONSTRAINT emp_manager_fk FOREIGN KEY (manager_id) REFERENCES employees(employee_id)
);

-- Create sequences for auto-incrementing IDs
CREATE SEQUENCE dept_seq START WITH 100 INCREMENT BY 10;
CREATE SEQUENCE emp_seq START WITH 1000 INCREMENT BY 1;

-- Create indexes for performance
CREATE INDEX emp_dept_ix ON employees(department_id);
CREATE INDEX emp_manager_ix ON employees(manager_id);
CREATE INDEX emp_hire_date_ix ON employees(hire_date);
CREATE INDEX emp_salary_ix ON employees(salary);

-- Add comments for documentation
COMMENT ON TABLE departments IS 'Company departments and organizational structure';
COMMENT ON COLUMN departments.department_id IS 'Unique department identifier';
COMMENT ON COLUMN departments.department_name IS 'Department name';
COMMENT ON COLUMN departments.manager_id IS 'Employee ID of department manager';
COMMENT ON COLUMN departments.location_id IS 'Office location identifier';

COMMENT ON TABLE employees IS 'Employee information and employment details';
COMMENT ON COLUMN employees.employee_id IS 'Unique employee identifier';
COMMENT ON COLUMN employees.first_name IS 'Employee first name';
COMMENT ON COLUMN employees.last_name IS 'Employee last name';
COMMENT ON COLUMN employees.email IS 'Employee email address (unique)';
COMMENT ON COLUMN employees.phone_number IS 'Employee phone number';
COMMENT ON COLUMN employees.hire_date IS 'Date employee was hired';
COMMENT ON COLUMN employees.job_id IS 'Job role identifier';
COMMENT ON COLUMN employees.salary IS 'Annual salary in USD';
COMMENT ON COLUMN employees.commission_pct IS 'Commission percentage (0.0-1.0)';
COMMENT ON COLUMN employees.manager_id IS 'Employee ID of direct manager';
COMMENT ON COLUMN employees.department_id IS 'Department assignment';

-- Grant privileges for MCP operations
GRANT SELECT, INSERT, UPDATE, DELETE ON departments TO PUBLIC;
GRANT SELECT, INSERT, UPDATE, DELETE ON employees TO PUBLIC;

COMMIT;

PROMPT
PROMPT ===================================
PROMPT HR Schema created successfully!
PROMPT Tables: DEPARTMENTS, EMPLOYEES
PROMPT Run load_sample_data.sql next
PROMPT ===================================
PROMPT