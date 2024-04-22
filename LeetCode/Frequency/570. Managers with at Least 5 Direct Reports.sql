SELECT Name
FROM Employee
WHERE Id IN (SELECT ManagerId
             FROM Employee
             GROUP BY ManagerId
             HAVING COUNT(Id) >= 5)

/*--------------------------------------------*/
SELECT e2.name
FROM Employee e1, Employee e2
WHERE e1.managerId=e2.id
GROUP BY e1.managerId
HAVING COUNT(e2.id) >=5

速度 2>1
