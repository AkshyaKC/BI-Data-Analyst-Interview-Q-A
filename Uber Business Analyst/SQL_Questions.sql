-- Write an SQL query to extract the third transaction of every user, displaying user_id, spend, and transaction date.
WITH numbered_orders AS(
    SELECT *,
        ROW_NUMBER() OVER(
            PARTITION BY user_id
            ORDER BY transaction_date
        ) AS transaction_num
    FROM orders
)
SELECT user_id,
    spend,
    transaction_date
FROM numbered_orders
WHERE transaction_num = 3;
-- Calculate the average ratings for each driver across different cities using data from rides and ratings tables.
SELECT driver_id,
    city,
    ROUND(AVG(rating), 2) AS avg_rating
FROM rides ri
    JOIN ratings ra ON ra.ride_id = ri.ride_id
GROUP BY driver_id,
    city;
-- Create an sql query to identify customers registered with gmail addresses from the 'users' database
SELECT *
FROM users
WHERE email LIKE '%gmail%';
-- Analyze the click-through conversion rates using data from ad_clicks and cab_bookings tables.
SELECT COUNT(DISTINCT cb.user_id) / COUNT(DISTINCT ac.user_id) AS conversion_rate
FROM ad_clicks ac
    LEFT JOIN cab_bookings cb ON ac.user_id = cb.user_id;