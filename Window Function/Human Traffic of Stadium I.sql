/*ROW_NUMBER	Assigns a sequential integer to every row within its partition */
/*
SELECT id, id - ROW_NUMBER() over (ORDER BY id) AS diff
FROM Stadium
WHERE people >= 100


Stadium table:
+------+------------+-----------+------+
| id   | visit_date | people    | diff |
+------+------------+-----------+------+ 
| 2    | 2017-01-02 | 109       |   1  |
| 3    | 2017-01-03 | 150       |   1  |
| 5    | 2017-01-05 | 145       |   2  |
| 6    | 2017-01-06 | 1455      |   2  |
| 7    | 2017-01-07 | 199       |   2  |
| 8    | 2017-01-09 | 188       |   2  |
+------+------------+-----------+------+

SELECT id, COUNT(*) OVER (PARTITION BY DIFF) as cnt
FROM
     (SELECT id, id - ROW_NUMBER() over (ORDER BY id) AS diff
      FROM Stadium
      WHERE people >= 100) a
	  
+------+------+
|  id  |  cnt |
+------+------+
|  2   |  2   |
|  3   |  2   |
|  5   |  4   |
|  6   |  4   |
|  7   |  4   |
|  8   |  4   |
+------+------+
*/
SELECT *
FROM Stadium
WHERE id IN (SELECT id
             FROM (SELECT id, COUNT(*) OVER (PARTITION BY DIFF) as cnt
                   FROM (SELECT id, id - ROW_NUMBER() over (ORDER BY id) AS diff
                         FROM Stadium
                         WHERE people >= 100) a
                   ) b
             WHERE cnt >= 3);