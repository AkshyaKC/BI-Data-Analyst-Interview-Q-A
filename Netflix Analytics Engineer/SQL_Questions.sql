-- Question 1: Identify VIP Users for Netflix 
-- Question: To better cater to its most dedicated users, Netflix would like to identify its “ VIP users ” - those who are most 
--           active in terms of the number of hours of content they watch.Write a SQL query that will retrieve the top 10 users with
--           the most watched hours in the last month.
-- Tables: 
-- users table: user_id (integer), sign_up_date (date), subscription_type (text) 
-- watching_activity table: activity_id (integer), user_id (integer), date_time (timestamp), show_id (integer), hours_watched (float) 
;
CREATE TABLE users(
    user_id INT,
    sign_up_date DATE,
    subscription_type TEXT
);
INSERT INTO users()
VALUES (1, "2024-12-01", "standard"),
    (2, "2022-01-27", "basic"),
    (3, "2020-09-23", "premium"),
    (4, "2021-06-18", "premium"),
    (5, "2019-02-11", "standard");
CREATE TABLE watching_activity(
    activity_id INT,
    user_id INT,
    date_time TIMESTAMP,
    show_id INT,
    hours_watched FLOAT
);
INSERT INTO watching_activity()
VALUES (21, 1, "2024-12-02 16:30:45", 101, 1.8),
    (22, 1, "2024-12-03 19:29:00", 108, 2.3),
    (23, 1, "2024-12-04 20:01:02", 102, 1),
    (24, 1, "2024-12-08 17:05:08", 105, 2.1),
    (25, 2, "2024-11-29 18:02:15", 101, 1.8),
    (26, 2, "2024-12-04 19:05:00", 108, 2.3),
    (27, 2, "2024-02-23 18:12:32", 102, 1.1),
    (28, 3, "2024-10-03 20:08:13", 103, 2),
    (29, 4, "2024-11-18 21:25:40", 108, 2.3),
    (30, 5, "2024-10-11 19:10:55", 101, 1.5),
    (31, 5, "2024-11-12 21:01:17", 108, 2.3),
    (32, 5, "2024-11-11 08:30:02", 102, 0.8);
SELECT user_id,
    SUM(hours_watched) AS Watch_Hours
FROM watching_activity
WHERE date_time >= DATE_FORMAT(CURRENT_DATE - INTERVAL 1 MONTH, '%Y-%m-01')
    AND date_time < DATE_FORMAT(CURRENT_DATE, '%Y-%m-01')
GROUP BY user_id
ORDER BY Watch_Hours DESC
LIMIT 2;
---------------------------------------------------------------------------------------------------------------------------------
-- Question 2: Analyzing Ratings For Netflix Shows 
-- Question: Given a table of user ratings for Netflix shows, calculate the average rating for each show within a given month.
--           Assume that there is a column for user_id,show_id, rating (out of 5 stars), and date of review.Order the results by month
--           and then by average rating (descending order).
-- Tables: 
-- show_reviews table: review_id (integer), user_id (integer), review_date (timestamp), show_id (integer),stars (integer)
;
CREATE TABLE show_reviews(
    review_id INT,
    user_id INT,
    review_date TIMESTAMP,
    show_id INT,
    stars INT
);
INSERT INTO show_reviews()
VALUES (1, 101, '2024-12-01 14:20:00', 201, 5),
    (2, 101, '2024-11-25 09:10:00', 202, 4),
    (3, 102, '2024-12-02 17:45:00', 201, 3),
    (4, 102, '2024-11-30 20:30:00', 203, 5),
    (5, 103, '2024-12-03 11:15:00', 204, 4),
    (6, 103, '2024-11-29 08:00:00', 201, 2),
    (7, 104, '2024-12-04 13:25:00', 202, 3),
    (8, 104, '2024-11-27 19:40:00', 203, 5),
    (9, 105, '2024-12-05 10:30:00', 204, 4),
    (10, 105, '2024-11-28 15:50:00', 201, 5),
    (11, 101, '2024-12-06 18:00:00', 202, 3),
    (12, 102, '2024-11-26 12:45:00', 203, 4),
    (13, 103, '2024-12-07 09:20:00', 204, 2),
    (14, 104, '2024-11-24 22:10:00', 201, 5),
    (15, 105, '2024-12-08 14:00:00', 202, 4);
SELECT show_id,
    MONTH(review_date) AS `Month`,
    AVG(stars) AS Average_Rating
FROM show_reviews
GROUP BY MONTH(review_date),
    show_id
ORDER BY MONTH(review_date),
    Average_Rating DESC;
----------------------------------------------------------------------------------------------------------------------------------
-- Question 3: What does EXCEPT /MINUS SQL commands do ? 
-- Question: Explain the purpose and usage of the EXCEPT (or MINUS in some SQL dialects) SQL commands.
;
----------------------------------------------------------------------------------------------------
-- Question 4: Filter Netflix Users Based on Viewing History and Subscription Status 
-- Question: You are given a database of Netflix ’ s user viewing history and their current subscription status.
--           Write a SQL query to find all active customers who watched more than 10 episodes of a show called “ Stranger Things ” in the last 30 days.
--Tables: 
-- users table: user_id (integer), active (boolean) 
-- viewing_history table: user_id (integer),show_id (integer),episode_id (integer),watch_date (date) 
-- shows table: show_id (integer),show_name (text)
-----------------------------------------------------------------------------------------------------------
-- Question 5: What does it mean to denormalize a database ? 
-- Question: Explain the conceptand implications of denormalizing a database.
---------------------------------------------------------------------------------------------------------
-- Question 6: Filter and Match Customer ’ s Viewing Records 
-- Question: As a data analyst at Netflix, you are asked to analyze the customer ’ s viewing records.
--           You confirmed that Netflix is especially interested in customers who have been continuously watching a particular 
--           genre - ‘ Documentary ’ over the last month.The task is to find the name and email of those customers who have viewed 
--           more than five ‘ Documentary ’ movies within the last month.‘ Documentary ’ could be a part of a broader genre category 
--           in the genre field (for example, ‘ Documentary, History ’).Therefore,the matching pattern could occur anywhere within the string.
-- Tables: 
-- movies table: movie_id (integer), title (text), genre (text), release_year (integer) 
-- customer table: user_id (integer), name (text), email (text), last_movie_watched (integer), date_watched (date)