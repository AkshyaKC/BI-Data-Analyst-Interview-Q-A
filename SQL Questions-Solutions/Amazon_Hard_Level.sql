-- Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, 
-- and date purchased. Do not include returns which are represented by negative purchase values. 
-- Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.
;
-- A 3-month rolling average is defined by calculating the average total revenue from all user purchases for the current
-- month and previous two months. The first two months will not be a true 3-month rolling average since we are not given 
-- data from last year. Assume each month has at least one purchase.
;
CREATE SCHEMA amazon_hard_level;
USE amazon_hard_level;
CREATE TABLE amazon_purchases (
    created_at DATETIME,
    purchase_amt BIGINT,
    user_id BIGINT
);
INSERT INTO amazon_purchases (created_at, purchase_amt, user_id)
VALUES ('2023-01-05', 1500, 101),
    ('2023-01-15', -200, 102),
    ('2023-02-10', 2000, 103),
    ('2023-02-20', 1200, 101),
    ('2023-03-01', 1800, 104),
    ('2023-03-15', -100, 102),
    ('2023-04-05', 2200, 105),
    ('2023-04-10', 1400, 103),
    ('2023-05-01', 2500, 106),
    ('2023-05-15', 1700, 107),
    ('2023-06-05', 1300, 108),
    ('2023-06-15', 1900, 109);
WITH monthly_revenue AS (
    SELECT DATE_FORMAT(created_at, '%Y-%m') AS YearMonth,
        SUM(
            CASE
                WHEN purchase_amt > 0 THEN purchase_amt
                ELSE 0
            END
        ) AS total_revenue
    FROM amazon_purchases
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
)
SELECT YearMonth,
    AVG(total_revenue) OVER (
        ORDER BY YearMonth ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS rolling_avg_revenue
FROM monthly_revenue
ORDER BY YearMonth;