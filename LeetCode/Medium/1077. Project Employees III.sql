SELECT project_id, employee_id
FROM(
SELECT p.*,
       DENSE_RANK() OVER(PARTITION BY p.project_id ORDER BY e.experience_years DESC) AS rak
FROM Project p
LEFT JOIN Employee e ON p.employee_id=e.employee_id) t
WHERE rak=1