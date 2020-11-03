SELECT Department, Employee, Salary
FROM (SELECT 
          d.Name AS Department,
          e.Name AS Employee,
          e.Salary,
          RANK() OVER (
                PARTITION BY d.Name
                ORDER BY e.Salary DESC) AS r
      FROM Employee e
      JOIN Department d ON e.DepartmentId = d.Id) tmp
WHERE r = 1

/*-------------------------------------------------------------------*/
select b.Name Department, a.Name Employee, a.Salary
from (
    select DepartmentId, Name, Salary, rank() over(partition by DepartmentId order by salary desc) rnk
    from Employee) a
join Department b
on a.DepartmentId=b.Id
where a.rnk=1

/*-------------------------------------------------------------------*/
select Department, Employee, Salary
from(
    select b.Name as Department, a.Name as Employee, a.Salary, max(a.Salary) over (partition by a.DepartmentId) as MaxSalary
    from Employee as a
    join Department as b on a.DepartmentId = b.Id
) as t
where t.Salary = t.MaxSalary

/*--------------------------------------------------------------------*/
SELECT
    Department.name AS 'Department',
    Employee.name AS 'Employee',
    Salary
FROM
    Employee
        JOIN
    Department ON Employee.DepartmentId = Department.Id
WHERE
    (Employee.DepartmentId , Salary) IN
    (   SELECT
            DepartmentId, MAX(Salary)
        FROM
            Employee
        GROUP BY DepartmentId
	)
;
/*
Algorithm

Since the Employee table contains the Salary and DepartmentId information, 
we can query the highest salary in a department.

SELECT
    DepartmentId, MAX(Salary)
FROM
    Employee
GROUP BY DepartmentId;
Note: There might be multiple employees having the same highest salary, 
so it is safe not to include the employee name information in this query.

| DepartmentId | MAX(Salary) |
|--------------|-------------|
| 1            | 90000       |
| 2            | 80000       |
Then, we can join table Employee and Department, and query the (DepartmentId, Salary) 
are in the temp table using IN statement as below.
*/