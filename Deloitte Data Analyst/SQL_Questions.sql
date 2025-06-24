-- 1. Write a SQL query to find the third highest salary from an employee table with the following columns: EID, ESalary.--
WITH salary_cte AS(
    SELECT EID,
        ESalary,
        ROW_NUMBER() OVER(
            ORDER BY ESalary DESC
        ) AS RowNumber
    FROM salary_table
)
SELECT EID,
    ESalary
FROM salary_cte
WHERE RowNumber = 3;
--------------------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-- 2. Create a SQL procedure using ESalary as a parameter that selects all EIDs from the Employee table where ESalary is less than 50,000.--
CREATE PROCEDURE salary_below(salary_param INT)
SELECT EID
FROM employee_table
WHERE ESalary < salary_param;
CALL salary_below(50000);
--------------------------------------------------------------------------------------------------------------------------
-- 3. For the Employee table (with columns EID and ESalary), retrieve all EIDs with odd salaries and join this with another table, 
--    empdetails (with columns EID and EDOB), to obtain EDOB.
;
-- 4. How would you use the LEAD or LAG function in SQL to compare week-over-week data?