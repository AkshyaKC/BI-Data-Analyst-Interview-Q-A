-- 1. Write a query to find the second-highest salary in a department. You might use ROW_NUMBER() or DENSE_RANK() to achieve this.
-- Using  ROW_NUMBER()
WITH rank_table AS(
	SELECT *,
		DENSE_RANK() OVER(PARTITION BY dept_id ORDER BY salary DESC) AS salary_rank
	FROM employee_table
)
SELECT *
FROM rank_table
WHERE salary_rank =2;

----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a query to calculate the total number of transactions per user for each day.
--    This typically involves GROUP BY and COUNT() for aggregation.
SELECT user_id,
	transaction_date,
	COUNT(transaction_id) AS TotalTransaction
FROM transaction_table
GROUP BY user_id,
	transaction_date
ORDER BY user_id;
-----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------
-- 3. Write a query to select projects with the highest budget-per-employee ratio from two related tables (projects and employees). 
--    This tests your ability to handle complex joins and aggregations.

-- Department with highest salary-per-employee ratio --
SELECT 
    dept_id,
    dpt.department,
    COUNT(*) AS employee_number,
    SUM(salary) / COUNT(*) AS salary_per_employee
FROM employee_table empt	
JOIN department dpt ON dpt.department_id = empt.dept_id
GROUP BY dept_id, department
ORDER BY salary_per_employee DESC
LIMIT 1;