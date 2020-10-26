SELECT project_id
FROM Project 
GROUP BY project_id
HAVING COUNT(employee_id) = (SELECT MAX(n)
                             FROM (SELECT COUNT(employee_id) AS n
                                 FROM Project
                                 GROUP BY project_id) AS temp)