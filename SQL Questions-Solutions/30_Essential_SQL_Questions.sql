-- Window Functions 
-- 1.Compute the rolling average of sales for the last three months.
-- 2.Rank employees uniquely based on their salaries in descending order.
-- 3.Identify the earliest and latest purchase dates for each customer.
-- 4.Find the second highest salary in each department using window functions.
-- 5.Calculate the percentage contribution of each employee to the company ’ s total revenue.
SELECT employee_id,
    sales,
    ROUND((sales * 100) / SUM(sales) OVER(), 2) AS percent_contribution
FROM total_sales;
;
------------------------------------------------------------------------------------------------------------------------------------
-- Common Table Expressions (CTEs) 
-- 1.Use a CTE to separate full names into first and last names.
DROP TABLE IF EXISTS users_info;
CREATE TABLE users_info(
    user_id INT PRIMARY KEY,
    full_name VARCHAR(55)
);
INSERT INTO users_info()
VALUES (1, 'John Doe'),
    (2, 'Elon Musk');
WITH full_name AS (
    SELECT *,
        SUBSTRING_INDEX(full_name, ' ', 1) AS first_name,
        SUBSTRING_INDEX(full_name, ' ', -1) AS last_name
    FROM users_info
)
SELECT *
FROM full_name;
-- 2.Write a CTE to determine the longest streak of consecutive sales by an employee.
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    employee_id INT,
    sale_date DATE
);
INSERT INTO sales (sale_id, employee_id, sale_date)
VALUES (1, 101, '2025-07-01'),
    (2, 102, '2025-07-01'),
    (3, 101, '2025-07-02'),
    (4, 101, '2025-07-02'),
    (5, 102, '2025-07-02'),
    (6, 102, '2025-07-03'),
    (7, 101, '2025-07-04');
WITH distinct_sales_dates AS (
    SELECT DISTINCT employee_id,
        sale_date
    FROM sales
),
ranked_sales AS (
    SELECT employee_id,
        sale_date,
        ROW_NUMBER() OVER (
            PARTITION BY employee_id
            ORDER BY sale_date
        ) AS rn
    FROM distinct_sales_dates
),
grouped_sales AS (
    SELECT employee_id,
        sale_date,
        DATE(sale_date) - INTERVAL rn DAY AS streak_group
    FROM ranked_sales
),
streak_lengths AS (
    SELECT employee_id,
        COUNT(*) AS streak_length
    FROM grouped_sales
    GROUP BY employee_id,
        streak_group
)
SELECT employee_id,
    MAX(streak_length) AS longest_streak
FROM streak_lengths
GROUP BY employee_id;
-- 3.Generate a sequence of Fibonacci numbers up to a specific value using a recursive CTE.
WITH RECURSIVE fib (n, a, b) AS (
    SELECT 1,
        0,
        1 -- (term_number, first, second) 
    UNION ALL
    SELECT n + 1,
        b,
        a + b
    FROM fib
    WHERE n < 10
)
SELECT a AS fibonacci_number
FROM fib;
-- 4.Use a CTE to detect and list duplicate entries in a table.
-- 5.Calculate total sales per category and filter out categories with sales below a specific threshold using a CTE.
;
----------------------------------------------------------------------------------------------------------------------------------------
-- Joins (Inner, Outer, Cross, Self) 
-- 1.List all customers,highlighting who placed orders and who didn ’ t (Full Outer Join ).
-- 2.Identify employees assigned to more than one project using a self -join.
-- 3.Match orders with customers and display unmatched orders as well (Left Join).
-- 4.Create unique product combinations using a Cross Join while excluding identical product pairs.
-- 5.Retrieve employees along with their direct managers using a self -join.
;
-------------------------------------------------------------------------------------------------------------------------------------
-- Subqueries 
-- 1.Find customers whose total purchase value exceeds the average order value.
-- 2.Retrieve employees with the lowest salary in their respective departments.
-- 3.Identify products ordered more than 10 times using a subquery.
-- 4.List regions where the highest sales value is below a specified threshold.
;
-------------------------------------------------------------------------------------------------------------------------------------
-- Aggregate Functions 
-- 1.Compute the median salary for each department.
-- 2.Summarize monthly sales and rank them in descending order.
-- 3.Count the number of unique customers for each product.
-- 4.Identify the top five regions based on total sales.
-- 5.Calculate the average order value for every customer.
;
-------------------------------------------------------------------------------------------------------------------------------------
-- Indexing and Performance 
-- 1.Write a query to locate duplicate entries in a column with an index.
-- 2.Evaluate the effect of a composite index on query performance.
-- 3.Identify high - cardinality columns that could benefit from indexing.
-- 4.Compare query execution times before and after implementing a clustered index.
-- 5.Write a query that bypasses indexing to observe performance variations.
;