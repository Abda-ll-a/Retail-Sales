select * 
from Retail_Sales

SELECT COUNT(*) 
FROM retail_sales

-- Data Cleaning
SELECT * FROM retail_sales
WHERE transactions_id IS NULL

SELECT * FROM retail_sales
WHERE sale_date IS NULL

SELECT * FROM retail_sales
WHERE sale_time IS NULL

SELECT * FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- 
DELETE FROM retail_sales
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;
    
-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) as total_sale 
FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale 
FROM retail_sales



SELECT DISTINCT category 
FROM retail_sales

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

select *
from retail_sales
where sale_date ='2022-11-05'

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

select *
from Retail_Sales
where category='Clothing' 
      and 
	  quantiy>=4 
      and 
	  format(sale_date,'yyyy-MM')='2022-11'

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

select category,SUM(total_sale)
from Retail_Sales
group by category

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select AVG(age) as Average_Age
from Retail_Sales
where category='Beauty'

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from Retail_Sales
where total_sale>1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

select COUNT(*),gender,category
from Retail_Sales
group by gender,category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

WITH MonthlyAvg AS (
    SELECT 
        YEAR(sale_date) AS sale_year,
        MONTH(sale_date) AS sale_month,
        round(AVG(total_sale),2) AS avg_monthly_sale
    FROM Retail_Sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
),
RankedMonths AS (
    SELECT *,
           RANK() OVER (PARTITION BY sale_year ORDER BY avg_monthly_sale DESC) AS rank_month
    FROM MonthlyAvg
)
SELECT sale_year, sale_month, avg_monthly_sale
FROM RankedMonths
WHERE rank_month = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select top(5) customer_id,SUM(total_sale) as Total_Sales
from Retail_Sales
group by customer_id
order by SUM(total_sale) desc;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

select COUNT(distinct(customer_id)) count_unique_customers,category
from Retail_Sales
group by category

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
  CASE 
    WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS number_of_orders
FROM Retail_Sales
GROUP BY 
  CASE 
    WHEN DATEPART(HOUR, sale_time) < 12 THEN 'Morning'
    WHEN DATEPART(HOUR, sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END;
