SELECT a.Name
FROM (SELECT s.ID, s.Name, p.Salary
      FROM Students s
      JOIN Packages p ON s.ID = p.ID) AS a
JOIN (SELECT f.ID, f.Friend_ID, p.Salary
      FROM Friends f
      JOIN Packages p ON f.Friend_ID = P.ID) AS b
ON a.ID = b.ID
WHERE a.Salary < b.Salary
ORDER BY b.Salary



SELECT s.Name
FROM Students s 
JOIN Friends f ON s.ID = f.ID
JOIN Packages pf ON f.Friend_ID = pf.ID
JOIN Packages ps ON s.ID = ps.ID
WHERE pf.Salary > ps.Salary
ORDER BY pf.Salary
