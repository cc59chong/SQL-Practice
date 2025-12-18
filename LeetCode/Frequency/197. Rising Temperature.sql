SELECT b.id
FROM Weather a, Weather b
WHERE DATEDIFF(b.recordDate, a.recordDate) = 1 AND b.Temperature > a.Temperature;


SELECT w2.id
FROM Weather w1
JOIN Weather w2 ON w2.recordDate = DATE_ADD(w1.recordDate, INTERVAL 1 DAY)
WHERE w2.temperature > w1.temperature;


SELECT w2.id
FROM Weather w1
JOIN Weather w2 ON w1.recordDate = DATE_SUB(w2.recordDate, INTERVAL 1 DAY)
WHERE w2.temperature > w1.temperature;
