SELECT b.employee_id, a.team_size
FROM Employee b
JOIN (SELECT team_id, COUNT(employee_id) AS team_size
      FROM Employee
      GROUP BY team_id) a
ON b.team_id = a.team_id