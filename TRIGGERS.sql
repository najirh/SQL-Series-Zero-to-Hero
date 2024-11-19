-- TRIGGER in SQL
SELECT * FROM employees;
CREATE TABLE employees (
    emp_id SERIAL PRIMARY KEY,   
    emp_name VARCHAR(25) NOT NULL,  
    salary NUMERIC(10, 2) NOT NULL,  
    department VARCHAR(50),        
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
);

INSERT INTO employees (emp_name, salary, department) VALUES
('Amit Sharma', 45000, 'HR'),
('Neha Gupta', 52000, 'Finance'),
('Rajesh Kumar', 60000, 'IT'),
('Pooja Mehta', 35000, 'Marketing'),
('Vikram Singh', 48000, 'Sales');


CREATE TABLE employee_records
(
	emp_id INT, 
	emp_name VARCHAR(25), 
	action VARCHAR(50), 
	action_time TIMESTAMP
);

-- After delete trigger
OLD -- existing row
NEW -- new row

-- Req. record employee in another table which is called "employee_records" after emp being deleted

-- FUNCTION
CREATE OR REPLACE FUNCTION emp_delete_log()
RETURNS TRIGGER AS
$$
BEGIN
-- logic and code 
	INSERT INTO employee_records(emp_id, emp_name, action_time, action)
	VALUES
	(OLD.emp_id, OLD.emp_name, CURRENT_TIMESTAMP, 'emp deleted');
	RETURN OLD;

END
$$
LANGUAGE plpgsql;

-- create trigger
CREATE TRIGGER delete_emp_logs_trigger
AFTER DELETE ON employees
FOR EACH ROW
-- FOR EACH STATEMENT
EXECUTE FUNCTION emp_delete_log();

-- TRIGGER

-- BEFORE DELETE 

-- FUNCTION -- prevent delete emp if they are from it
CREATE OR REPLACE FUNCTION emp_del_check()
RETURNS TRIGGER AS
$$
BEGIN
-- code
	IF	OLD.department = 'IT' THEN
		RAISE EXCEPTION 'Deleting emp from IT department is not allowed! Contact IT Team';
	END IF;	
	RETURN OLD; -- for other case return old
END
$$
LANGUAGE plpgsql;


CREATE TRIGGER emp_del_check_trigger
BEFORE DELETE ON employees
FOR EACH ROW
EXECUTE FUNCTION emp_del_check();

-- 50k
-- Before inserting new emp rec we want to check if the salary is more than 10k

CREATE OR REPLACE FUNCTION before_insert_check()
RETURNS TRIGGER AS
$$
BEGIN
	IF NEW.salary < 10000 THEN
		RAISE EXCEPTION 'Adding emp with salary less than 10k is not allowed!';
	END IF;
	RETURN NEW;
END;
$$
LANGUAGE plpgsql;

CREATE TRIGGER before_insert_check_trigger
BEFORE INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION before_insert_check();

-- After insert 
CREATE OR REPLACE FUNCTION emp_add_logs()
RETURNS TRIGGER AS
$$
BEGIN
	INSERT INTO employee_records(emp_id, emp_name, action_time, action)
	VALUES
	(NEW.emp_id, NEW.emp_name, CURRENT_TIMESTAMP, 'New Emp Added');
	RAISE NOTICE 'Emp added to audit table!';
	RETURN NEW;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER emp_add_logs_trigger
AFTER INSERT ON employees
FOR EACH ROW
EXECUTE FUNCTION emp_add_logs();



-- TESTING
SELECT * FROM employees;
SELECT * FROM employee_records;

DELETE FROM employees
WHERE emp_id = 11;

INSERT INTO employees
VALUES
(105, 'John', 19000, 'IT', CURRENT_TIMESTAMP);










