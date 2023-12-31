SELECT Name AS Customers
FROM Customers 
WHERE Id NOT IN (SELECT c.Id 
                 FROM Customers c 
                 JOIN Orders o ON c.Id = o.CustomerId);

/*
# Write your MySQL query statement below
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
GROUP BY c.id
HAVING COUNT(o.id) < 1;
*/
