Question 1: Final Account Balance
Write a sql query to retrieve the final account balance for each account by calculating the net amount from deposits and withdrawals.
Input Table:
transactions table:
-transaction_id(integer)
-account_id(integer)
-amount(decimal)
-transaction_type(varchar)

----------------------------
Question 2: Average Transaction Amount per user
Write a SQL query to compute the average transaction amount for each user and rank the users in descending order based on their average transaction amount.
Input Table:
transactions table:
-transaction_id(integer)
-user_id(integer)
-transaction_date(date)
-amount(decimal)
--------------------------------
Question 3: Unique money transfer relationships
Write a SQL query to determine the number of unique two-way money transfer relationships, where a two-way relationship is established if a user has sent money
to another user and also received money from the same user
Input Table:
payments table:
-payer_id(integer)
-recipient_id(integer)
-amount(decimal)
----------------------------
Question 4: Determining high value customers
Write a SQL query to identify users who, in the last month, have either sent payments over 1000 or received payments over 5000, excluding those flagged as fradulent.
Input Table:
transactions table:
-transaction_id(integer)
-user_id(integer)
-transaction_date(date)
-transaction_type(varchar)
-amount(decimal)

users table:
-user_id(integer)
-username(varchar)
-is_fraudulent(boolean)

----------------------------
Question 5: Analyzing user transaction data
Write a sql query that calculates the total and average transaction amount for each user, including only those users who have made at least 2 transaction
Input Table:
users table:
-user_id(integer)
-signup_date(date)

transactions table:
-transaction_id(integer)
-user_id(integer)
-transaction_date(date)
-transaction_amount(decimal)
