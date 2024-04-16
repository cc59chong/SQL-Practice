SELECT Name AS Customers
FROM Customers 
WHERE Id NOT IN (SELECT c.Id 
                 FROM Customers c 
                 JOIN Orders o ON c.Id = o.CustomerId);

/*----------------------------------------------------*/

SELECT name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id=o.customerId
WHERE o.customerId IS NULL


/*----------------------------------------------------*/

  
SELECT name AS Customers
FROM Customers
WHERE id NOT IN (SELECT customerId FROM Orders )


速度 1>3>2
