SELECT b.id
FROM Weather a, Weather b
WHERE DATEDIFF(b.recordDate, a.recordDate) = 1 AND b.Temperature > a.Temperature;