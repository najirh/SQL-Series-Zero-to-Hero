-- 
-- Video 02 SQL series 
-- date format 'yyyy-mm-dd'

-- creating employees table 
-- 50000.25

CREATE TABLE employees (
						employee_id int, 
						name varchar(25),
						department varchar(25),
						salary DECIMAL(10, 2),
						hiredate date
						);


-- Inserting more records into employees table 

INSERT INTO employees (employee_id, name, department, salary, hiredate)
VALUES 
    (1, 'John Doe', 'IT', 50000, '2020-01-15'),
    (2, 'Jane Smith', 'HR', 55000, '2019-08-20'),
    (3, 'Michael Lee', 'Marketing', 60000, '2020-03-10'),
    (4, 'Emily Brown', 'Finance', 65000, '2018-11-05'),
    (5, 'David Wilson', 'IT', 52000, '2021-02-28');
	


-- creating product table

CREATE TABLE products (
					    product_id INT,
					    product_name VARCHAR(100),
					    category VARCHAR(100),
					    price DECIMAL(10, 2),
					    quantity_in_stock INT
						); 

-- inserting records into products table 

INSERT INTO products (product_id, product_name, category, price, quantity_in_stock)
VALUES 
    (101, 'Laptop', 'Electronics', 1200, 50),
    (102, 'Smartphone', 'Electronics', 800, 100),
    (103, 'Headphones', 'Electronics', 100, 200),
    (104, 'T-shirt', 'Clothing', 20, 300),
    (105, 'Jeans', 'Clothing', 50, 150);


-- Creating customers table 

CREATE TABLE customers (
					    customer_id INT,
					    customer_name VARCHAR(100),
					    email VARCHAR(100),
					    phone_number VARCHAR(20),
					    city VARCHAR(100)
						);


-- inserting data into customers table 

INSERT INTO customers (customer_id, customer_name, email, phone_number, city)
VALUES 
    (201, 'Alice Johnson', 'alice@example.com', '1234567890', 'New York'),
    (202, 'Bob Smith', 'bob@example.com', '9876543210', 'Los Angeles'),
    (203, 'Emma Davis', 'emma@example.com', '4567890123', 'Chicago'),
    (204, 'Jack Brown', 'jack@example.com', '7890123456', 'Houston'),
    (205, 'Olivia Wilson', 'olivia@example.com', '2345678901', 'Miami');


-- creating orders table 
CREATE TABLE orders (
					    order_id INT ,
					    customer_id INT,
					    product_id INT,
					    order_date DATE,
					    quantity_ordered INT
					);

-- inserting data into orders 
INSERT INTO orders (order_id, customer_id, product_id, order_date, quantity_ordered)
VALUES 
    (301, 201, 101, '2022-03-15', 2),
    (302, 202, 103, '2022-03-16', 3),
    (303, 203, 104, '2022-03-17', 1),
    (304, 204, 102, '2022-03-18', 2),
    (305, 205, 105, '2022-03-19', 1);


-- PRIMARY KEY (t_id cannot be empty, cannot be duplicate, it has be unique)

CREATE TABLE transaction (
					    transaction_id INT PRIMARY KEY,
					    customer_id INT,
					    amount DECIMAL(10, 2),
					    transaction_date DATE,
					    payment_method VARCHAR(50)
						);

-- inserting records into transactions
INSERT INTO transaction (transaction_id, customer_id, amount, transaction_date, payment_method)
VALUES 
    (401, 201, 1200, '2022-03-15', 'Credit Card'),
    (402, 202, 1000, '2022-03-16', 'PayPal'),
    (403, 203, 800, '2022-03-17', 'Cash'),
    (404, 204, 1500, '2022-03-18', 'Debit Card'),
    (405, 205, 600, '2022-03-19', 'PayPal');


-- -----------------------------------------------
-- Business Problems & Answers 
-- -----------------------------------------------

-- Q.1 Find the employees with the highest salary.

SELECT * FROM employees
WHERE salary = 85000;

-- all the employee who are from IT
SELECT * FROM employees
WHERE department = 'it'

SELECT * FROM employees
WHERE salary > 60000;


SELECT * FROM employees
WHERE salary <= 50000;


-- Q.2 List employees hired after January 1, 2021.

SELECT * FROM employees
WHERE hiredate > '2021-01-01'




-- Q.8 Calculate total number of product we have in products table.

-- SUM, COUNT, MAX, MIN
	
SELECT 
	COUNT(product_id) as total_products
FROM products;




-- Q.4 Update the salary of employee with ID 3 to 62000.


SELECT * FROM employees;

UPDATE employees
SET salary = 62000
WHERE  employee_id = 3


-- updating salary to 55000 and department to 'it' for zara

UPDATE employees
SET department = 'it', salary = 55000
WHERE name = 'zara'

	
SELECT * FROM employees
WHERE name = 'zara'

	
SELECT * FROM employees
WHERE  employee_id = 3




-- Q.10 Delete products with a price less than 50.

SELECT * FROM products
WHERE price < 50;

DELETE FROM products
WHERE price < 50;



-- -----------------------------------------------
-- Your Task Business Problems & Answers 
-- -----------------------------------------------

/*

-- Employee Queries:

Q.1 Find the employee with the highest salary.
Q.2 List employees hired after January 1, 2021.
Q.3 Calculate the average salary of employees in each department.
Q.4 Update the salary of employee with ID 3 to 62000.
Q.5 Delete the employee with the lowest salary.

-- Product Queries:
Q.6 Find the total value of products in stock for each category.
Q.7 Identify products with a quantity in stock less than 50.
Q.8 Calculate total number of product we have.
Q.9 Update the price of all products in the 'Clothing' category to 10% higher.
Q.10 Delete products with a price less than 50.



-- Customer Queries:
Q.11 Count the number of customers in each city.
Q.12 Identify customers who have made transactions using PayPal.
Q.13 Calculate the total amount spent by each customer.
Q.14 Update the email of customer with ID 204 to 'new_email@example.com'.
Q.15 Delete customers who have not made any transactions.


-- Order Queries:
Q.16. Find the total number of orders placed on each date.
Q.17 Identify orders with a quantity_ordered greater than 3.
Q.18 Calculate the total sale amount for each product.
Q.19 Update the order_date of order with ID 304 to '2022-03-20'.
Q.20 Delete orders placed before January 1, 2022.



Transaction Queries:
Q.21. Find the average transaction amount for each payment method.
Q.22 Identify transactions made on March 15,

*/



-- Your TASK

/*
-- Insertion Tasks:
1. Insert a new employee with the following details: EmployeeID = 101, Name = 'John Doe', Department = 'Marketing', Salary = 60000, HireDate = '2022-04-01'.
2. Add a new product with the following details: ProductID = 11, Name = 'Smartphone', Category = 'Electronics', Price = 799.99, Quantity = 100.

-- Update Tasks:
1. Increase the salary of all employees in the 'Sales' department by 10%.
Update the price of the product with ProductID = 3 to 99.99.

-- Deletion Tasks:
1. Delete the employee with EmployeeID = 102.
Remove all products with a Quantity less than 10.
*/

