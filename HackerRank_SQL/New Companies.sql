



SELECT c.company_code, 
       c.founder, 
	   COUNT(DISTINCT l.lead_manager_code), 
	   COUNT(DISTINCT s.senior_manager_code),
       COUNT(DISTINCT m.manager_code), 
	   COUNT(DISTINCT e.employee_code)
FROM Company c, Lead_Manager l, Senior_Manager s, Manager m, Employee e 
WHERE c.company_code = l.company_code
  AND l.lead_manager_code = s.lead_manager_code
  AND s.senior_manager_code = m.senior_manager_code
  AND m.manager_code = e.manager_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;



SELECT c.company_code, 
       c.founder, 
	   COUNT(DISTINCT e.lead_manager_code), 
	   COUNT(DISTINCT e.senior_manager_code),
       COUNT(DISTINCT e.manager_code), 
	   COUNT(DISTINCT e.employee_code)
FROM Company c
JOIN Employee e ON c.company_code = e.company_code
GROUP BY c.company_code, c.founder
ORDER BY c.company_code;




SELECT company_code, 
       founder,
       (SELECT COUNT(DISTINCT lead_manager_code) FROM Lead_Manager l WHERE l.company_code = c.company_code),
	   (SELECT COUNT(DISTINCT senior_Manager_code) FROM Senior_Manager s WHERE s.company_code = c.company_code),
	   (SELECT COUNT(DISTINCT manager_code) FROM Manager m WHERE m.company_code = c.company_code),
	   (SELECT COUNT(DISTINCT employee_code) FROM Employee e WHERE e.company_code = c.company_code)
FROM Company c
ORDER BY company_code;
	 