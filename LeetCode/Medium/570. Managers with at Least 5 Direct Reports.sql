SELECT Name
FROM Employee
WHERE Id IN (SELECT ManagerId
             FROM Employee
              WHERE ManagerId IS NOT NULL
             GROUP BY ManagerId
             HAVING COUNT(Id) >= 5)

SELECT 
FROM Employee e
JOIN (SELECT ManagerId
      FROM Employee
      WHERE ManagerId IS NOT NULL
      GROUP BY ManagerId
      HAVING COUNT(*) >= 5) AS m
ON e.Id = m.ManagerId


/*--------------------------------------------*/
SELECT e2.name
FROM Employee e1, Employee e2
WHERE e1.managerId=e2.id
GROUP BY e1.managerId
HAVING COUNT(e2.id) >=5

3 better than 1,2 
