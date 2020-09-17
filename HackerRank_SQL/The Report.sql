
SELECT IF(s.Marks < 70, 'NULL', s.Name), g.Grade, s.Marks
FROM Students s
CROSS JOIN Grades g
WHERE s.Marks BETWEEN g.Min_Mark AND g.Max_Mark
ORDER by g.Grade DESC, s.Name;