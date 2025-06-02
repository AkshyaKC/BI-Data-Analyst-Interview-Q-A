-- Clients table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(255),
    region_id INT
);

-- Funds table
CREATE TABLE Funds (
    fund_id INT PRIMARY KEY,
    fund_name VARCHAR(255),
    region_id INT,
    risk_category VARCHAR(50)
);

-- Daily fund performance (NAV change)
CREATE TABLE FundPerformance (
    fund_id INT,
    as_of_date DATE,
    daily_return DECIMAL(10,6),
    net_asset_value DECIMAL(15,2),
    PRIMARY KEY (fund_id, as_of_date)
);

-- Transactions table (client investing in a fund)
CREATE TABLE Transactions (
    transaction_id BIGINT PRIMARY KEY,
    customer_id INT,
    fund_id INT,
    amount DECIMAL(15,2),
    transaction_type ENUM('BUY','SELL','DIVIDEND'),
    executed_at TIMESTAMP(6),
    INDEX idx_customer_fund_time (customer_id, fund_id, executed_at)
);

CREATE TABLE Region (
    region_id INT PRIMARY KEY,
    region_name VARCHAR(100),
    currency_code CHAR(3)
);

UPDATE transactions
SET executed_at = DATE(executed_at);

-- 1. Identify customers who have invested in at least two funds with opposite performance trends (one increasing and the other decreasing) 
--    over the last 6 months.
WITH cte as (
	SELECT * 
    FROM fund_performance
	WHERE as_of_date IN (CURDATE() - INTERVAL 1 DAY, CURDATE() - INTERVAL 6 MONTH)
), 
with_lag AS(
	SELECT *,
        LAG(net_asset_value) OVER (ORDER BY as_of_date) AS previous_value
	FROM cte
), 
final_df AS(
SELECT *,
    CASE
		WHEN net_asset_value > previous_value THEN 'Increasing'
        WHEN net_asset_value < previous_value THEN 'Decreasing'
        ELSE 'same'
	END AS Trend
FROM with_lag
)
SELECT 
	tr.customer_id,
	SUM(CASE WHEN fd.Trend=  'Decreasing' THEN 1 ELSE 0 END) AS Decreasing_buy,
    SUM(CASE WHEN fd.Trend=  'Increasing' THEN 1 ELSE 0 END) AS Increasing_buy
FROM transactions tr
INNER JOIN final_df fd ON tr.fund_id = fd.fund_id
WHERE transaction_type = 'BUY'
	AND Trend !='same'
GROUP BY tr.customer_id
HAVING Decreasing_buy >=15 AND Increasing_buy >=15
ORDER BY customer_id;


-- 2. Write a query to calculate the year - to - date portfolio returns for each client, ensuring that the query can handle daily transactions
--    across multiple funds.
;






-- 3. Find the top 5 performing funds within each region based on their weighted average returns, accounting for the 
--    size of investments in each fund.
;





-- 4. Write a query to detect and list transactions that may indicate potential duplication (e.g., same client, fund, amount,and timestamp
--    within 5 minutes).
;




-- 5. Discuss the implementation and use of materialized views for financial dashboards.How would you ensure they are updated efficiently in 
--    near real - time ? 
;





-- 6. Explain the ACID properties of SQL transactions and their importance in a financial database handling millions of trades daily.
;





-- 7. Describe how you would design a sharding strategy for a massive transactional database storing global trading data.
;






-- 8. Explain the role of indexing in optimizing complex joins and aggregations for a dataset with billions of financial records.
--    Provide examples of when over - indexing might degrade performance.