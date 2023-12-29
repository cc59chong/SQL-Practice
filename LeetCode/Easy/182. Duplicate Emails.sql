SELECT DISTINCT a.Email
FROM Person a, Person b
WHERE a.Email = b.Email AND a.Id != b.Id;

/*
# Write your MySQL query statement below
SELECT Email
FROM Person
GROUP BY email
Having COUNT(id) > 1
*/
