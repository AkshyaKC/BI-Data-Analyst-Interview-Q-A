-- SQL Script for Question 3
-- Write a solution to report all the duplicate emails. Note that it's guaranteed that the email field is not NULL.
;
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) = 2;