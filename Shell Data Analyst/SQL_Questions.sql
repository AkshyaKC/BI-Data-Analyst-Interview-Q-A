-- 1. You have a table Transactions with columns TransactionID, CustomerID, Date, and Amount.
--    Write a query to calculate the cumulative revenue per customer for each month in the last year.
;
CREATE TABLE transactions(
    TransactionID INT,
    CustomerID INT,
    Date DATE,
    Amount INT
);
INSERT INTO transactions()
VALUES (1, 1, '2023-10-11', 100),
    (2, 1, '2023-10-12', 150),
    (3, 1, '2023-10-13', 200),
    (4, 2, '2023-10-14', 250),
    (5, 2, '2023-10-15', 300),
    (6, 2, '2023-10-16', 350),
    (7, 3, '2023-10-17', 400),
    (8, 3, '2023-10-18', 450),
    (9, 3, '2023-10-19', 500),
    (10, 1, '2023-10-20', 550),
    (11, 1, '2023-10-21', 600),
    (12, 1, '2023-10-22', 650),
    (13, 2, '2023-10-23', 700),
    (14, 2, '2023-10-24', 750),
    (15, 2, '2023-10-25', 800),
    (16, 3, '2023-10-26', 850),
    (17, 3, '2023-10-27', 900),
    (18, 3, '2023-10-28', 950),
    (19, 1, '2024-10-11', 1000),
    (20, 2, '2024-10-12', 1050),
    (21, 3, '2024-10-12', 1100);
SELECT *
FROM transactions
WHERE YEAR(Date) = YEAR(CURRENT_DATE - INTERVAL 1 YEAR)
ORDER BY 2;
WITH last_year_transactions AS (
    SELECT CustomerID,
        MONTH(Date) AS Month,
        Amount
    FROM transactions
    WHERE YEAR(Date) = YEAR(CURRENT_DATE - INTERVAL 1 YEAR)
)
SELECT CustomerID,
    Month,
    SUM(Amount) AS TotalRevenue
FROM last_year_transactions
GROUP BY 1,
    2;
-- 2. A table Production contains columns PlantID, Date, and Output. Write a query to identify the 
--    plants that consistently exceeded their daily average output for at least 20 days in a given month.
;
-- 3. In a table EmployeeAttendance with columns EmployeeID, Date, and Status (values: ‘Present’, ‘Absent’),
--    write a query to find employees with the highest consecutive absences in the last quarter.
;
-- 4. What are the pros and cons of using indexes in SQL, and when would you avoid using them?
;
-- 5. Explain the differences between window functions and aggregate functions with examples.