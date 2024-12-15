-- 1. Write a query to find the second-highest salary in a department. You might use ROW_NUMBER() or DENSE_RANK() to achieve this.
CREATE TABLE employee_table(
employee_id INT NOT NULL,
full_name VARCHAR(50),
salary INT,
dept_id INT
);
INSERT INTO employee_table()
VALUES
(101, 'John Doe', 75000, 501),
(102, 'Jane Smith', 68000, 502),
(103, 'Robert Johnson', 82000, 503),
(104, 'Emily Davis', 54000, 504),
(105, 'Michael Brown', 76000, 501),
(106, 'Linda Taylor', 67000, 502),
(107, 'William Wilson', 89000, 503),
(108, 'Elizabeth White', 61000, 504),
(109, 'David Martin', 70000, 501),
(110, 'Sarah Thompson', 65000, 502),
(111, 'Richard Harris', 92000, 503),
(112, 'Jessica Lee', 56000, 504),
(113, 'Thomas Clark', 74000, 501),
(114, 'Barbara Lewis', 69000, 502),
(115, 'Christopher Walker', 85000, 503);

CREATE TABLE department(
department_id INT NOT NULL,
department VARCHAR(50)
);

INSERT INTO department()
VALUES 
(501, "Finance"),
(502, "IT"),
(503, "Loan"),
(504, "Procurement");

-- Using  ROW_NUMBER()
WITH Salary_CTE AS (
	SELECT dpt.department_id, department, full_name, salary,
	      ROW_NUMBER() OVER(PARTITION BY dpt.department ORDER BY et.salary DESC) AS RowNumber
	FROM employee_table AS et
	JOIN department AS dpt
		ON et.dept_id=dpt.department_id
)
SELECT department, full_name, salary
FROM Salary_CTE
WHERE RowNumber =2;

-- Using DENSE_RANK()
WITH Salary_CTE2 AS(
	SELECT department_id, department, full_name, salary,
        DENSE_RANK() OVER(PARTITION BY department_id ORDER BY salary DESC) AS DenseRank
	FROM employee_table AS et
  JOIN department AS dpt
		ON et.dept_id = dpt.department_id
)
SELECT department, full_name,salary
FROM Salary_CTE2
WHERE DenseRank =2;
----------------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------------
-- 2. Create a query to calculate the total number of transactions per user for each day.
--    This typically involves GROUP BY and COUNT() for aggregation.
CREATE TABLE transaction_table(
user_id INT NOT NULL,
transaction_id VARCHAR(50),
transaction_date DATE
);
 
INSERT INTO transaction_table()
VALUES 
(1, 'TR101', '2024-12-01'),
(1, 'TR105', '2024-12-01'),
(2, 'TR102', '2024-12-01'),
(3, 'TR103', '2024-12-01'),
(4, 'TR104', '2024-12-01'),
(4, 'TR120', '2024-12-01'),
(2, 'TR106', '2024-12-02'),
(3, 'TR107', '2024-12-02'),
(4, 'TR108', '2024-12-02'),
(1, 'TR109', '2024-12-03'),
(1, 'TR110', '2024-12-03'),
(2, 'TR111', '2024-12-03'),
(2, 'TR112', '2024-12-03'),
(3, 'TR113', '2024-12-03'),
(3, 'TR114', '2024-12-03'),
(2, 'TR118', '2024-12-04'),
(3, 'TR119', '2024-12-04');

SELECT user_id, transaction_date, COUNT(transaction_id) AS TotalTransaction
FROM transaction_table
GROUP BY user_id, transaction_date
ORDER BY user_id;

-----------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------------


-- 3. Write a query to select projects with the highest budget-per-employee ratio from two related tables (projects and employees). 
--    This tests your ability to handle complex joins and aggregations.


