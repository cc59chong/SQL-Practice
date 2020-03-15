/*
SELECT 
FROM Employees e1
INNER JOIN Employees e2
    ON e1.manager_id = e2.employee_id 

//inner join to find manager's manager
	
e1                         e2
+-------------+-----------+------------+------------+
| employee_id |manager_id |employee_id |manager_id  |
+-------------+-----------+------------+------------+
| 1           | 1         | 1          | 1          |
| 3           | 3         | 3          | 3          |
| 2           | 1         | 1          | 1          |
| 4           | 2         | 2          | 1          |
| 7           | 4         | 4          | 2          |
| 8           | 3         | 3          | 3          |
| 9           | 8         | 8          | 3          |
| 77          | 1         | 1          | 1          |
+-------------+-----------+------------+------------+
*/

SELECT e1.employee_id 
FROM Employees e1
INNER JOIN Employees e2
    ON e1.manager_id = e2.employee_id AND e2.manager_id IN (
        SELECT employee_id
        FROM Employees
        WHERE manager_id = 1 /* select the employee whose manager(manager_id=1) is the head of company (1,2,77）*/
    )
WHERE e1.employee_id <> 1 

