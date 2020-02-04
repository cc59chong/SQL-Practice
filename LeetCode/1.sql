/*175. Combine Two Tables*/
/* Write your MySQL query statement below*/
SELECT FirstName, LastName, City, State
FROM Person p
LEFT JOIN Address a on p.PersonId = a.PersonId;

/*176. Second Highest Salary*/
/*Write a SQL query to get the second highest salary from the Employee table.
For example, given the above Employee table, the query should return 200 as the second highest salary. 
If there is no second highest salary, then the query should return null.*/
/* Write your MySQL query statement below*/
SELECT Max(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee);

SELECT
    (SELECT DISTINCT
            Salary
        FROM
            Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET 1) AS SecondHighestSalary
;

SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary
;

/*181. Employees Earning More Than Their Managers*/
/*The Employee table holds all employees including their managers.
 Every employee has an Id, and there is also a column for the manager Id.*/
/*Write your MySQL query statement below*/
SELECT a.Name AS Employee
FROM Employee a, Employee b 
WHERE a.ManagerId = b.Id AND a.Salary > b.Salary;

/*182. Duplicate Emails*/
SELECT Email
FROM Person 
GROUP BY Email
HAVING COUNT(Email) > 1;

select distinct a.Email
from Person a, Person b
where a.Email = b.Email and a.Id != b.Id;

/*183. Customers Who Never Order*/
SELECT Customers.Name AS Customers
FROM Customers
LEFT JOIN Orders ON Customers.Id = Orders.CustomerId
WHERE Orders.CustomerId IS NULL;

/*196. Delete Duplicate Emails*/
DELETE FROM Person 
WHERE Id NOT IN (SELECT MIN(a.Id) FROM (SELECT * FROM Person) a
Group by a.Email);

DELETE p1 FROM Person p1, Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id;

/*197. Rising Temperature*/
select b.Id
from Weather a, Weather b
where datediff(b.RecordDate, a.RecordDate) =1 and b.Temperature > a.Temperature;
