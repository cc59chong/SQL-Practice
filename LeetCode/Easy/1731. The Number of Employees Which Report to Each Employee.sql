SELECT t1.employee_id, t1.name, t2.reports_count, t2.average_age
FROM Employees t1
JOIN (SELECT reports_to AS manager, COUNT(employee_id) AS reports_count, ROUND(AVG(age)) AS average_age
      FROM Employees
      WHERE reports_to IS NOT NULL
      GROUP By reports_to) t2
ON t1.employee_id = t2.manager
ORDER BY t1.employee_id

SELECT t1.employee_id, t1.name, COUNT(t2.employee_id) AS reports_count, ROUND(AVG(t2.age)) AS average_age
FROM Employees t1
JOIN Employees t2
ON t1.employee_id = t2.reports_to
WHERE t2.reports_to IS NOT NULL
GROUP By t2.reports_to
ORDER BY t1.employee_id