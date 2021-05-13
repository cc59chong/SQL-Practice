SELECT DISTINCT e2.employee_id
FROM Employees e2
JOIN (SELECT e1.employee_id AS a, t1.employee_id AS b
      FROM Employees e1
      JOIN (SELECT employee_id
            FROM Employees
            WHERE employee_id != manager_id AND manager_id = 1) t1
      ON e1.manager_id = t1.employee_id OR e1.employee_id = t1.employee_id) t2
ON e2.manager_id = t2.a OR e2.employee_id = t2.a;

/*-------------------------------------------------------------------------------*/

(SELECT employee_id
 FROM Employees 
 WHERE employee_id != manager_id AND manager_id = 1)
UNION 
(SELECT e1.employee_id
 FROM Employees e1
 JOIN (SELECT employee_id
       FROM Employees
       WHERE employee_id != manager_id AND manager_id = 1) t1
 ON e1.manager_id = t1.employee_id)
UNION
(SELECT e2.employee_id
 FROM Employees e2
 JOIN (SELECT e1.employee_id
       FROM Employees e1
       JOIN (SELECT employee_id
             FROM Employees
             WHERE employee_id != manager_id AND manager_id = 1) t1
       ON e1.manager_id = t1.employee_id) t2
ON e2.manager_id = t2.employee_id);

/*-------------------------------------------------------------------------------*/
/*-***************************速度最快****************************************************-*/

(select employee_id 
 from Employees 
 where manager_id=1 and employee_id<>manager_id) 
union 
(select employee_id 
 from Employees 
 where manager_id in (select employee_id from Employees where manager_id=1 and employee_id<>manager_id)) 
 union
(select employee_id 
 from Employees 
 where manager_id in (select employee_id 
                      from Employees 
                      where manager_id in (select employee_id from Employees where manager_id=1 and employee_id<>manager_id)))

/*-------------------------------------------------------------------------------*/					 
/*-*******************************************************************************-*/				
select employee_id
from Employees
where manager_id
in (
    select employee_id
    from Employees
    where manager_id in (
                         select employee_id
                         from Employees
                         where manager_id = 1
                         ) 
    )
and employee_id <> manager_id

/*-------------------------------------------------------------------------------*/					 
/*-*******************************************************************************-*/							

WITH M AS 
(SELECT employee_id
FROM Employees
WHERE manager_id = 1
AND employee_id <> 1),

L1 AS 
(SELECT employee_id
FROM Employees
WHERE manager_id IN (SELECT employee_id FROM M)),

L2 AS
(SELECT employee_id
FROM Employees
WHERE manager_id IN (SELECT employee_id FROM L1))

SELECT employee_id FROM M
UNION
SELECT employee_id FROM L1
UNION
SELECT employee_id FROM L2	

/*-------------------------------------------------------------------------------*/
		
SELECT a.employee_id
FROM Employees a
INNER JOIN Employees b
ON b.employee_id = a.manager_id
INNER JOIN Employees c
ON c.employee_id = b.manager_id
INNER JOIN Employees d
ON d.employee_id = c.manager_id
WHERE d.employee_id = 1
AND a.employee_id <> 1
