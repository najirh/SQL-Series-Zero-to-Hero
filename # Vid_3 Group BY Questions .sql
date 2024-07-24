-- GROUP BY in SQL
DROP TABLE IF EXISTS walmart_sales;
CREATE TABLE walmart_sales(
                            invoice_id VARCHAR(15),
                            branch	CHAR(1),	
                            city  VARCHAR(25),  
                            customer_type	VARCHAR(15),
                            gender	VARCHAR(15),
                            product_line VARCHAR(55),	
                            unit_price	FLOAT,
                            quantity    INT, 	
                            vat	FLOAT,
                            total	FLOAT,
                            date	date,	
                            time time,
                            payment_method	VARCHAR(15),
                            rating FLOAT
                        );

SELECT * FROM walmart_sales;
/*
-- ---------------------------------------------
-- Business Problems :: Basic Level
-- ---------------------------------------------
Q.1 Find the total sales amount for each branch
Q.2 Calculate the average customer rating for each city.
Q.3 Count the number of sales transactions for each customer type.
Q.4 Find the total quantity of products sold for each product line.
Q.4 v1 Calculate the total VAT collected for each payment method.



-- ---------------------------------------------
-- Business Problems :: Medium Level
-- ---------------------------------------------
Q.5 Find the total sales amount and average customer rating for each branch.
Q.6 Calculate the total sales amount for each city and gender combination.
Q.7 Find the average quantity of products sold for each product line to female customers.
Q.8 Count the number of sales transactions for members in each branch.
Q.9 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)




-- ---------------------------------------------
-- Business Problems :: Advanced Level
-- ---------------------------------------------
Q.10 Calculate the total sales amount for each hour of the day
Q.11 Find the total sales amount for each month. (return month name and their sales)
Q.12 Calculate the total sales amount for each branch where the average customer rating is greater than 8.
Q.13 Find the total VAT collected for each product line where the total sales amount is more than 500.
Q.14 Calculate the average sales amount for each gender in each branch.
Q.15 Count the number of sales transactions for each day of the week.
Q.16 Find the total sales amount for each city and customer type combination where the number of sales transactions is greater than 50.
Q.17 Calculate the average unit price for each product line and payment method combination.
Q.18 Find the total sales amount for each branch and hour of the day combination.
Q.19 Calculate the total sales amount and average customer rating for each product line where the total sales amount is greater than 1000.
Q.20 Calculate the total sales amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening (6 PM to 12 AM) periods using the time condition.

*/




SELECT * FROM walmart_sales;

-- Q.1 Find the total sales amount for each branch

SELECT 
    SUM(total)
FROM walmart_sales;

SELECT 
    COUNT(total)
FROM walmart_sales;

-- SUM, COUNT(), MIN, MAX, AVERAGE

SELECT 
     branch,
     SUM(total)
FROM walmart_sales
GROUP BY branch


-- Q.2 Calculate the average customer rating for each city.

SELECT
    city,
    AVG(rating) ratings
FROM walmart_sales
GROUP BY city
ORDER BY ratings

-- Q.3 Count the number of sales transactions for each customer type.

SELECT 
    customer_type,
    COUNT(invoice_id) as total_trans
FROM walmart_sales
GROUP BY customer_type

-- MEDIUM DIFFICULTY
-- Q.5 Find the total sales amount and average customer rating for each branch.

SELECT 
    branch,
    SUM(total) as total_sales,
    AVG(rating) as avg_rating
FROM walmart_sales
GROUP BY branch


-- Q.6 Calculate the total sales amount for each city and gender combination.

SELECT 
    city, --- 1
    gender, --- 2
    SUM(total)
FROM walmart_sales
GROUP BY 1, 2
ORDER BY 1

-- Q.7 Find the average quantity of products sold for each product line to female customers.

SELECT 
    product_line,
    AVG(quantity) as avg_qty_sold
    -- gender
FROM walmart_sales
WHERE gender = 'Male'
GROUP BY product_line


-- Q.9 Find the total sales amount for each day. (Return day name and their total sales order DESC by amt)

SELECT
    TO_CHAR(date, 'Day') as day_name,
    SUM(total) as total_sale
FROM walmart_sales
GROUP BY day_name
ORDER BY total_sale DESC



-- Advanced 
-- Q.10 Calculate the total sales amount for each hour of the day


SELECT 
    EXTRACT (HOUR FROM time) as hours,
    SUM(total) as total_sale
FROM walmart_sales
GROUP BY 1
ORDER BY 2 



-- Q.11 Find the total sales amount for each month. (return month name and their sales)




SELECT
    TO_CHAR(date, 'Mon') as month_name,
    SUM(total) as total_sale
FROM walmart_sales
GROUP BY month_name
ORDER BY total_sale DESC


-- Q.12 Calculate the total sales amount for each branch where the average customer rating is greater than 7.

SELECT 
    branch,
    SUM(total) as total_sale, --- having
    AVG(rating) as avg_rating -- having
FROM walmart_sales
WHERE branch <> 'E'
GROUP BY 1
HAVING AVG(rating) > 7

-- WHERE and HAVING



-- Q.20 Calculate the total orders amount for morning (6 AM to 12 PM), afternoon (12 PM to 6 PM), and evening (6 PM to 12 AM) periods using the time condition.

WITH new_table
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM time) BETWEEN 6 AND 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM time) > 12 AND  EXTRACT(HOUR FROM time) <= 18 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift    
FROM walmart_sales
)
SELECT 
    shift,
    SUM(total) as total_sales,
    COUNT(invoice_id) as total_orders
FROM new_table
WHERE branch <> 'A'
GROUP BY shift
HAVING COUNT(invoice_id) < 500






