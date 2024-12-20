-- Write a Python function to filter customers with more than 5 purchases in the last 6 months.
;
-- Upating column purchaseDate which is of type text to date
UPDATE electronic_sales
SET purchaseDate = STR_TO_DATE(purchaseDate, '%m/%d/%Y')
WHERE purchaseDate IS NOT NULL;
-- Changing it's data type to DATE
ALTER TABLE electronic_sales
MODIFY COLUMN purchaseDate DATE,
    MODIFY COLUMN price INT;
WITH date_filter AS(
    SELECT customerName,
        productName
    FROM electronic_sales
    WHERE purchaseDate >= (CURRENT_DATE - INTERVAL 6 MONTH)
),
purchase_filter AS(
    SELECT customerName,
        COUNT(customerName) AS TotalPurchase
    FROM date_filter
    GROUP BY customerName
)
SELECT *
FROM purchase_filter
WHERE TotalPurchase > 5;
-- Develop a program to read a CSV file, extract unique values from a column, and save the results
-- in a new file.
;