DROP TABLE IF EXISTS employee_info;
CREATE TABLE employee_info(
	emp_id INT PRIMARY KEY,
	first_name VARCHAR(55),
    last_name VARCHAR(55),
	email VARCHAR(320) UNIQUE,
    phone CHAR(10),
	department_id INT,
	salary INT,
    date_joined DATE
);

INSERT INTO employee_info()
VALUES
(1, " Pushpa  ","Rai", "pushpa23@gmail.com",'0153487589', 11, 56000, "2020-02-01"),
(2, "Shreeya","  Sharma", NULL,'983487589', 12, 52000, "2020-02-21"),
(3, "Racheal ","Terry", "rchle@nami.io",NULL, 11, 75000, "2019-05-19"),
(4, "John", "Doe ",NULL,NULL, 13, 85000,"2023-11-09"),
(5, "Pedro","Neto", "pdron12@yahoo.com",1452367890, 12, 49000,"2022-01-01"),
(6, "Sophiya","Turner", "sofiyaewr@gmail.com",NULL, 14, 37000, "2024-11-12"),
(7, "Milan","Shrestha", "milanjk@gmail.com",NULL, 13, 91000, "2019-05-23"),
(8, "Alice","Dao", "alice@xyz.org",NULL, 11, 65000, "2020-12-27"),
(9, "Bob","Marley", "bobg@and.org",7825614245, 12, 63000,"2021-08-11"),
(10, "Preeti"," Rai", "preeti@gmail.com",NULL, 14, 100000,"2021-10-01"),
(11, "Elon  ","Musk", "elon101@gmail.com",NULL, 13, 45000,"2021-02-23"),
(12, "Rahul","KC", NULL,'5675652098', 14, 49000,"2025-01-01")
;

DROP TABLE IF EXISTS departments;
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);
INSERT INTO departments()
VALUES
(13,'Admin'),
(14,'Sales'),
(15,'IT');

SELECT * FROM employee_info;

-- 1. Aggregate Functions
-- COUNT() -- Count rows or non-null values
-- SUM() -- Sum of numeric values
-- AVG() -- Average of numeric values
-- MIN() / MAX() -- Minimum or maximum value
-- COUNT(DISTINCT column_name) -- Count distinct values in a column
SELECT
	COUNT(*) AS total_employee,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MIN(salary) AS min_salary,
    MAX(salary) AS max_salary,
    COUNT(DISTINCT dept_id) AS total_dept
FROM employee_info;

-- 2. Window Functions
-- ROW_NUMBER() -- Assigns a unique sequential integer to rows within a partition of a result set
SELECT id, 
	f_name, salary,
	ROW_NUMBER() OVER(ORDER BY salary DESC) AS row_num,
	RANK() OVER(ORDER BY salary DESC) AS row_rank,
	DENSE_RANK() OVER (ORDER BY salary DESC) AS row_dense_rank
FROM employee_info;
-- NTILE(n) -- Bucks rows into n groups
-- Divides employees into 4 salary-based groups
SELECT id,
	salary,
	NTILE(4) OVER(ORDER BY salary DESC) AS quartile
FROM employee_info;
-- LEAD() / LAG() -- Accesses data from subsequent or preceding rows
-- FIRST_VALUE() / LAST_VALUE() -- First or last value in a window frame
SELECT *,
	FIRST_VALUE(salary) OVER(PARTITION BY department_id) AS first_salary,
	LAST_VALUE(salary) OVER(PARTITION BY department_id) AS last_salary
FROM employee_info;
-- 3. String Functions
-- UPPER() / LOWER() -- Convert string to uppercase or lowercase
SELECT f_name,
	UPPER(f_name), 
	LOWER(f_name),
    CONCAT(f_name, l_name) AS full_name,
    CONCAT_WS('-', f_name, l_name) AS full_das_name,
    LENGTH(f_name) AS len_name
FROM employee_info;
-- TRIM() / LTRIM() / RTRIM() -- Remove leading or trailing spaces
SELECT first_name, TRIM(first_name) FROM employee_info;
-- SUBSTRING() / LEFT() / RIGHT() --  Extract substring from a string
SELECT SUBSTRING(first_name, start_position, length) FROM employee_info;
SELECT SUBSTRING(first_name, 1, 3) AS short_name FROM employee_info;
SELECT LEFT(first_name, 2) AS short_name FROM employee_info;
SELECT SUBSTRING(first_name,2) AS trimmed_name FROM employee_info; --  start at position 2 and go till the end.
SELECT RIGHT(first_name,3) AS short_name FROM employee_info;
-- CONCAT() / CONCAT_WS() -- Concatenate stringsz
SELECT CONCAT(first_name, last_name) AS full_name FROM employee_info;
SELECT CONCAT_WS('-',first_name, last_name) AS full_name FROM employee_info;
-- REPLACE() -- Replace occurrences of a substring in a string
SELECT REPLACE(first_name, 'a', 'x') FROM employee_info;
-- LENGTH() -- Get the length of a string
SELECT email,LENGTH(email) AS lenght FROM employee_info;
-- 4. Date Functions
-- CURRENT_DATE()/CURDATE() / NOW() -- Get current date or timestamp  
SELECT CURRENT_DATE();
SELECT NOW();
-- DATE_ADD() / DATE_SUB() -- Add or subtract intervals from a date
SELECT DATE_ADD(CURDATE(), INTERVAL 15 DAY);
-- DATEDIFF() or TIMESTAMPDIFF() or DATE_DIFF() -- Calculate the difference between two dates
SELECT DATEDIFF(CURDATE(), date_joined) AS work_days FROM employee_info;
-- DATE_FORMAT() / STR_TO_DATE() -- Format a date or convert a string to a date
SELECT DATE_FORMAT('2025-07-05', '%W, %M %d, %Y') AS formatted_date;
SELECT STR_TO_DATE('05-07-2025', '%d-%m-%Y') AS parsed_date;
-- EXTRACT() / DATEPART() -- Extract specific parts of a date (year, month, day, etc.)
SELECT id,
	f_name,
    date_joined,
	EXTRACT(YEAR FROM date_joined) AS joined_year ,
	DATEDIFF(CURDATE(), date_joined) AS days
FROM employee_info;
-- LAST_DAY()    --Get the last day of a month
SELECT LAST_DAY('2020-01-01');
SELECT LAST_DAY(CURDATE());

-- 5. Conditional Functions
-- IF() / CASE -- Conditional logic to return different values based on conditions
SELECT
  salary,
  IF(salary > 60000,
	'High', 'Medium') AS salary_level
FROM employee_info;

SELECT salary,
  CASE
    WHEN salary >= 90000  THEN 'High'
    WHEN salary >= 60000 THEN 'Medium'
    ELSE 'Low'
  END AS salary_level
FROM employee_info;
-- COALESCE() 
--  Return the first non-null value in a list
SELECT f_name,
	email,phone,
	COALESCE (email, phone, 'No Contact Info') AS primary_contact 
FROM employee_info;
-- NULLIF() -- Return NULL if two expressions are equal, otherwise return the first expression
-- IFNULL() / ISNULL() -- Check if a value is NULL and return a specified value
SELECT 
  first_name,
  IFNULL(email, 'No email') AS contact_email
FROM employee_info;
-- 6. Filtering Functions
-- IN,NOT IN -- Check if a value is in a list of values\
SELECT first_name FROM employee_info WHERE department_id IN (11,12);
-- EXISTS, NOT EXISTS -- Efficient subquery filters
-- List employees whose department exists in the departments table
SELECT e.f_name, e.dept_id
FROM employee_info e
WHERE EXISTS (
    SELECT 1
    FROM departments d
    WHERE d.dept_id = e.dept_id
);

-- ANY, ALL -- Compare a value to a set of values
SELECT *
FROM employee_info
WHERE salary > ANY (
    SELECT salary
    FROM employee_info
    WHERE dept_id = 11
);
SELECT *
FROM employee_info
WHERE salary > ALL (
    SELECT salary
    FROM employee_info
    WHERE department_id = 11
);
-- LIKE, NOT LIKE, ILIKE -- Pattern matching in strings
SELECT * FROM employee_info
WHERE first_name LIKE 'A%';  -- names starting with A

SELECT * FROM employee_info
WHERE first_name NOT LIKE '%a';  -- names NOT ending in 'a'
-- BETWEEN,NOT BETWEEN -- Check if a value is within a range
SELECT *
FROM employee_info  -- Returns employees with salaries from 50,000 to 100,000 inclusive.
WHERE salary BETWEEN 75000 AND 100000;

SELECT *
FROM employee_info --  Returns employees who joined in 2022 or 2023.
WHERE date_joined BETWEEN '2022-01-01' AND '2023-12-31';

SELECT *
FROM employee_info -- Returns employees with salaries less than 50,000 or greater than 100,000.
WHERE salary NOT BETWEEN 50000 AND 100000;