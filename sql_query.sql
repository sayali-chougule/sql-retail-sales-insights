-- Project Name: SQL Retail Sales Analysis
CREATE DATABASE sql_project_p1;

-- Create a Table
CREATE TABLE retail_sales
		(
		transactions_id	INT PRIMARY KEY,
		sale_date DATE,
		sale_time TIME,
		customer_id INT,
		gender VARCHAR(15),
		age	INT,
		category VARCHAR(15),	
		quantiy	INT,
		price_per_unit FLOAT,
		cogs FLOAT,
		total_sale FLOAT
		);


SELECT * FROM retail_sales
LIMIT 10;


-- Count the total Records
SELECT COUNT(*) FROM retail_sales;


-- Checking the Null Values for All Columns
SELECT * FROM retail_sales
WHERE transactions_id IS NULL;


SELECT * FROM retail_sales
WHERE sale_date IS NULL;


SELECT * FROM retail_sales
WHERE sale_time IS NULL;


SELECT * FROM retail_sales
WHERE customer_id IS NULL;


SELECT * FROM retail_sales
WHERE gender IS NULL;


SELECT * FROM retail_sales
WHERE age IS NULL;

-- Alternate Method to check the Null Values for All Columns
SELECT * FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;


-- Delete Null Value Rows (Data Cleaning)
DELETE FROM retail_sales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	age IS NULL
	OR
	category IS NULL
	OR
	quantiy IS NULL
	OR
	price_per_unit IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL;


-- Data Exploration

-- 1. How many sales we have?
SELECT count(*) AS total_sale FROM retail_sales;


-- 2. How many unique customers we have?
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;


-- 3. What categories we have?
SELECT DISTINCT category FROM retail_sales;


-- Data Analysis and Business Key Problems and Answers

-- 1. Write a SQL query to retrieve all columns for sales made on '2022-11-05':
SELECT * 
FROM retail_sales
WHERE sale_date = '2022-11-05';


/* 2. Write a SQL query to retrieve all transactions where 
the category is 'Clothing' and the quantity sold is 
more than 4 in the month of Nov-2022: */
SELECT * 
FROM retail_sales
WHERE 
	category = 'Clothing' 
	AND 
	TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
	AND
	quantiy >= 4;


-- 3. Write a SQL query to calculate the total sales (total_sale) for each category.:
SELECT category, SUM(total_sale) AS net_sale
FROM retail_sales
GROUP BY category;


/* 4. Write a SQL query to find the average age of customers 
who purchased items from the 'Beauty' category.: */
SELECT ROUND(AVG(age), 2)
FROM retail_sales
WHERE category = 'Beauty';


-- 5. Write a SQL query to find all transactions 
-- where the total_sale is greater than 1000.:
SELECT * 
FROM retail_sales
WHERE total_sale > 1000;


/* 6. Write a SQL query to find the total number of 
transactions (transaction_id) made by each gender in each category.:
*/
SELECT gender, category, COUNT(transactions_id)
FROM retail_sales
GROUP BY category, gender
-- ORDER BY 1


/* 7. Write a SQL query to calculate the average sale for each month. 
Find out best selling month in each year: */
SELECT 
	EXTRACT(YEAR FROM sale_date) as year,
	EXTRACT(MONTH FROM sale_date) as month,
	AVG(total_sale) AS avg_sale
FROM retail_sales
GROUP BY year, month;


-- 8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS total_sales
FROM retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;


-- 9. Write a SQL query to find the number of unique customers 
-- who purchased items from each category.:
SELECT category, COUNT(DISTINCT(customer_id))
FROM retail_sales
GROUP BY category;


-- 10. Write a SQL query to create each shift and number of orders 
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
WITH hourly_sale
AS
(
SELECT *,
	CASE
		WHEN EXTRACT (HOUR FROM sale_time) < 12 THEN 'Morning' 
		WHEN EXTRACT (HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'Evening'
	END AS shift
FROM retail_sales
)
SELECT 
	shift,
	COUNT(*) AS total_orders
FROM hourly_sale
GROUP BY shift;


-- End of Project
