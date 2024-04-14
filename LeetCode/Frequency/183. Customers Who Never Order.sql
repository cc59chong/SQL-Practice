SELECT Name AS Customers
FROM Customers 
WHERE Id NOT IN (SELECT c.Id 
                 FROM Customers c 
                 JOIN Orders o ON c.Id = o.CustomerId);