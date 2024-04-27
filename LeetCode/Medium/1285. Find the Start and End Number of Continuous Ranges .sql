WITH a AS(
SELECT *,
       log_id -r AS island
FROM(    
SELECT *,
       ROW_NUMBER()OVER(ORDER BY log_id) AS r
FROM Logs) t
)

SELECT MIN(log_id) AS start_id, MAX(log_id) AS end_id
FROM a
GROUP BY island

/*
| log_id | r | island |
| ------ | - | ------ |
| 1      | 1 | 0      |
| 2      | 2 | 0      |
| 3      | 3 | 0      |
| 7      | 4 | 3      |
| 8      | 5 | 3      |
| 10     | 6 | 4      |
*/



/*-------------------------------------------------------*/

SELECT min(log_id) as start_id, max(log_id) as end_id
FROM
(SELECT log_id, ROW_NUMBER() OVER(ORDER BY log_id) as num
FROM Logs) a
GROUP BY log_id - num