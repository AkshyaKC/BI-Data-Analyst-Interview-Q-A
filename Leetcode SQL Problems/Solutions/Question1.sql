-- SQL Script for Question 1
-- Write a solution to report the first name, last name, city, and state of each person in the Person table. 
-- If the address of a personId is not present in the Address table, report null instead.
;
SELECT firstName,
    lastName,
    city,
    state
FROM Person AS P
    LEFT JOIN Address AS A ON P.personID = A.personID