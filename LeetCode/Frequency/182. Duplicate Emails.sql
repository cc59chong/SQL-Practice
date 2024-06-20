SELECT DISTINCT a.Email
FROM Person a, Person b
WHERE a.Email = b.Email AND a.Id != b.Id;

SELECT DISTINCT email
FROM Person 
GROUP BY email 
HAVING COUNT(id)>1;
