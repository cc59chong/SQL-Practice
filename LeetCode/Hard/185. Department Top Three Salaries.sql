SELECT d.Name AS Department,
       e.Name AS Employee, 
       e.Salary
FROM (SELECT Id,
             Name, 
             Salary,
             DepartmentId,
             DENSE_RANK() OVER (
                 PARTITION BY DepartmentId
                 ORDER BY Salary DESC
             ) AS 'Rank'
       FROM Employee) e
JOIN Department d ON e.DepartmentId = d.Id
WHERE e.Rank in (1,2,3)
ORDER BY e.Rank

/*---------------------------------------------------------------------*/
Select Department, 
       Employee, 
       Salary 
FROM ( Select 
       DENSE_RANK() over (
           partition by  d.Name 
           order by e.Salary desc 
       ) as r, 
      d.Name Department, 
      e.Name Employee, 
      e.Salary 
      FROM Employee e 
      inner join Department d on e.DepartmentId = d.Id
    ) tbl 
WHERE r <=3 order by  Department, r