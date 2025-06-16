Amazon & Myntra Interview Experience. (Expeience= 2+ years)
CTC= 29 LPA

1/ Write a query to find the top 3 best-selling products in the last 30 days.
(Focus on joins, GROUP BY, ORDER BY, and LIMIT)
2/ How would you write a query to get users who purchased more than 3 times in a week?
3/ Given a table with user purchases, identify returning customers vs. one-time buyers.
4/ Find the cumulative revenue per day for the last 7 days.
5/ Explain how ROW_NUMBER() vs. RANK() works. When would you use each?
6/ How would you define and calculate GMV (Gross Merchandise Value)?
7/ Explain how you would measure the success of a new feature on the app.
8/ If Myntra’s cart abandonment rate increases suddenly, how would you investigate?
9/ How would you estimate the impact of delayed delivery on customer retention?
10/ What metrics would you track for the homepage of the Myntra app?
11/ How would you design an A/B test for a new product sorting algorithm?
12/ A test shows no significant difference in conversion rates. What could be the reasons?
13/ Explain p-value and confidence interval in the context of experiments.
14/ How would you calculate sample size for an A/B test with 80% power and 95% confidence?
15/ What are some pitfalls to avoid when analyzing an A/B test?
16/ You notice a dip in orders in the North region—how would you investigate?
17/ Amazon sees a drop in Prime membership renewals—what data would you pull and why?
18/ You’re given a dashboard showing daily active users; what checks would you do to validate it?
19/ How would you design a data model to track user behavior across different sessions and devices?
20/ How do you ensure data quality and consistency in a large data warehouse like Redshift or BigQuery?

These questions target advanced problem-solving and optimization skills, preparing you for challenging Data Analyst interview scenarios.

Question:
You're given a table containing data on Amazon customers and their spending on products in different category, write a query to identify the top two highest-grossing products within each category in the year 2022. The output should include the category, product, and total spend.

📊 Table: product_spend

✅ Columns:
1️⃣ Category :: Varchar
2️⃣ Product :: Varchar
3️⃣ User_id :: Int
4️⃣ Spend :: Int
5️⃣ Transaction_date :: date
