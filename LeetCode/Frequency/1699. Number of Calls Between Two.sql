SELECT person1,
       person2,
       COUNT(*) AS call_count,
       SUM(duration) AS total_duration
FROM (SELECT from_id AS person1, to_id AS person2, duration
      FROM Calls
      UNION ALL
      SELECT to_id AS person1, from_id AS person2, duration
      FROM Calls) t
WHERE person1<person2
GROUP BY person1,person2

/*--------------------------------------------------------------*/

SELECT 
    CASE
        WHEN from_id > to_id THEN to_id
        ELSE from_id
    END AS person1,
    CASE
        WHEN from_id > to_id THEN from_id
        ELSE to_id
    END AS person2,
    COUNT(duration) AS call_count,
    SUM(duration) AS total_duration       
FROM Calls
GROUP BY person2,person1

速度 1>2