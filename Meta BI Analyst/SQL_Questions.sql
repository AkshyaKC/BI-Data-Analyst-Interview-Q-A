# Meta Business Intelligence Analyst Interview Experience
-- 1: Average Post Hiatus
-- Given a table of Facebook posts, for each user who posted at least twice in 2024, write a SQL query to find the number of 
-- days between each user’s first post of the year and last post of the year in the year 2024. Output the user and number of 
-- days between each user’s first and last post.
-- posts table: user_id (integer), post_id (integer), post_date (timestamp), post_content (text)
;
USE sql_interview;
DROP TABLE IF EXISTS posts_table;
CREATE TABLE posts_table(
    user_id INT,
    post_id INT,
    post_date TIMESTAMP,
    post_content TEXT
);
INSERT INTO posts_table(user_id, post_id, post_date, post_content)
VALUES (
        101,
        1011,
        "2023-04-04 09:11:01",
        "This is first post of user 101 in year 2023"
    ),
    (
        101,
        1012,
        "2024-01-04 04:01:17",
        "This is first post of user 101 in year 2024"
    ),
    (
        101,
        1013,
        "2024-09-04 04:01:17",
        "This is second post of user 101 in year 2024"
    ),
    (
        102,
        1021,
        "2021-11-06 09:35:01",
        "This is first post of user 102 in year 2021"
    ),
    (
        102,
        1022,
        "2024-02-24 12:02:01",
        "This is first post of user 102 in year 2024"
    ),
    (
        102,
        1023,
        "2024-12-02 09:11:01",
        "This is second post of user 102 in year 2024"
    ),
    (
        103,
        1031,
        "2024-04-04 11:20:00",
        "This is first post of user 103 in year 2024"
    ),
    (
        103,
        1032,
        "2024-09-23 09:18:01",
        "This is second post of user 103 in year 2024"
    ),
    (
        103,
        1033,
        "2024-11-27 07:20:00",
        "This is third post of user 103 in year 2024"
    ),
    (
        104,
        1041,
        "2024-01-04 02:25:25",
        "This is first post of user 104 in year 2024"
    ),
    (
        104,
        1042,
        "2024-05-02 12:23:01",
        "This is second post of user 104 in year 2024"
    ),
    (
        104,
        1043,
        "2024-11-15 08:36:01",
        "This is third post of user 104 in year 2024"
    ),
    (
        104,
        1044,
        "2024-12-18 09:18:01",
        "This is fourth post of user 104 in year 2024"
    );
SELECT *
FROM posts_table
WHERE YEAR(post_date) = 2024;
SELECT user_id,
    DATEDIFF(MAX(post_date), MIN(post_date)) AS days
FROM posts_table
WHERE YEAR(post_date) = 2024
GROUP BY user_id;
-- 2. Facebook Power Users
-- A Facebook power user is defined as someone who posts a ton and gets a lot of reactions on their post. 
-- For the purpose of this question, consider a Facebook power user as someone who posts at least twice a day
-- and receives an average of 150 comments and/or reactions per post. Write a SQL query to return the IDs of all
-- Facebook power users, along with the number of posts, and the average number of reactions per post.
-- user_post table: user_id (integer), post_id (integer), post_date (timestamp)
-- post_interactions table: post_id (integer), comments (integer), reactions (integer)
DROP TABLE IF EXISTS user_post;
CREATE TABLE user_post (user_id INT, post_id INT, post_date DATE);
INSERT INTO user_post()
VALUES (101, 1011, "2023-04-04"),
    (101, 1012, "2024-01-04"),
    (101, 1013, "2024-09-04"),
    (102, 1021, "2021-11-06"),
    (102, 1022, "2024-12-02"),
    (102, 1023, "2024-12-02"),
    (103, 1031, "2024-04-04"),
    (103, 1032, "2024-04-04"),
    (103, 1033, "2024-04-04"),
    (104, 1041, "2024-01-04"),
    (104, 1042, "2024-01-04"),
    (104, 1043, "2024-01-04"),
    (104, 1044, "2024-01-04");
DROP TABLE IF EXISTS post_interactions;
CREATE TABLE post_interactions(post_id INT, comments INT, reactions INT);
DELETE FROM post_interactions;
INSERT INTO post_interactions()
VALUES (1011, 151, 157),
    (1012, 127, 98),
    (1013, 147, 37),
    (1021, 98, 56),
    (1022, 78, 81),
    (1023, 105, 45),
    (1031, 55, 111),
    (1032, 45, 23),
    (1033, 41, 142),
    (1041, 65, 78),
    (1042, 33, 125),
    (1043, 54, 77),
    (1044, 27, 89);
SELECT up.user_id,
    COUNT(DISTINCT up.post_id) AS total_posts,
    AVG(pi.comments + pi.reactions) AS avg_reactions_per_post
FROM user_post AS up
    JOIN post_interactions AS pi ON up.post_id = pi.post_id
GROUP BY up.user_id
HAVING AVG(pi.comments + pi.reactions) >= 150;
WITH twice_a_day AS(
    SELECT user_id,
        post_date,
        COUNT(*) AS same_date
    FROM user_post
    GROUP BY user_id,
        post_date
)
SELECT *
FROM twice_a_day
WHERE same_date >= 2;
SELECT up.user_id,
    COUNT(DISTINCT up.post_id) AS total_posts,
    AVG(pi.comments + pi.reactions) AS avg_reactions_per_post
FROM user_post up
    JOIN post_interactions pi ON up.post_id = pi.post_id
GROUP BY up.user_id
HAVING COUNT(DISTINCT up.post_id) / COUNT(DISTINCT DATE(up.post_date)) >= 2 -- At least 2 posts per day
    AND AVG(pi.comments + pi.reactions) >= 150;
-- Average reactions/comments at least 150
-- 3. Active User Retention
-- Assume you’re given a table containing information on Facebook user actions.
-- Write a SQL query to obtain the number of monthly active users (MAUs) in July 2022, including the month in numerical format “1, 2, 3”. 
-- Hint: An active user is defined as a user who has performed actions such as ‘sign-in’, ‘like’, or ‘comment’ in both the current month
-- and the previous month.
-- user_actions table: user_id (integer), event_id (integer), event_type (string), event_date (datetime)
DROP TABLE IF EXISTS user_actions;
CREATE TABLE user_actions (
    user_id INT,
    event_id INT,
    enent_type VARCHAR(50),
    event_date DATETIME
);
INSERT INTO user_actions()
VALUES (1, 101, "Sign In", "2022-06-01"),
    (1, 102, "Like", "2022-06-01"),
    (1, 103, "Like", "2022-06-01"),
    (1, 103, "Like", "2022-07-01"),
    (1, 103, "Comment", "2022-07-01"),
    (1, 103, "Like", "2022-07-01"),
    (1, 103, "Sign In", "2022-07-03"),
    (1, 103, "Comment", "2022-07-03");
SELECT *
FROM user_actions;
-- 4. Facebook Friend Recommendations
-- Facebook wants to recommend new friends to people who show interest in attending 2 or more of the same private Facebook events. 
-- Write a SQL query to find pairs of friends to be recommended to each other if they’re interested in attending 2 or more of the same private events.
-- Notes:
-- • A user interested in attending would have either ‘going’ or ‘maybe’ as their attendance status.
-- • Friend recommendations are unidirectional, meaning if user x and user y should be recommended to each other, 
-- the result table should have both user x recommended to user y and user y recommended to user x.
-- • The result should not contain duplicates (i.e., user y should not be recommended to user x multiple times).
-- friendship_status table: user_a_id (integer), user_b_id (integer), status (enum: ‘friends’, ‘not_friends’)
-- event_rsvp table: user_id (integer), event_id (integer), event_type (enum: ‘public’, ‘private’), attendance_status (enum: ‘going’, ‘maybe’, ‘not_going’), event_date (date)
-- 5. Average Number of Shares per Post
-- As a data analyst at Facebook, you are asked to find the average number of shares per post for each user.
-- user_posts table: post_id (integer), user_id (integer), post_text (text), post_date (timestamp)
-- post_shares table: share_id (integer), post_id (integer), share_date (timestamp)