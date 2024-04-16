WITH CTE AS(
    SELECT  DISTINCT visited_on
          , SUM(amount) OVER(PARTITION BY visited_on ORDER BY visited_on) AS am  
    FROM customer
)
SELECT visited_on 
      ,amount  
      ,ROUND(average_amount,2) AS average_amount
FROM (
        SELECT visited_on 
            ,SUM(am) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ) AS amount
            ,AVG(SUM(am)) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ) AS average_amount
            ,COUNT(*) OVER(ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND CURRENT ROW ) AS cnt
        FROM CTE
        GROUP BY visited_on
)l 
WHERE cnt = 7 
ORDER BY visited_on

| visited_on | amount | average_amount | cnt |
| ---------- | ------ | -------------- | --- |
| 2019-01-01 | 100    | 100            | 1   |
| 2019-01-02 | 210    | 105            | 2   |
| 2019-01-03 | 330    | 110            | 3   |
| 2019-01-04 | 460    | 115            | 4   |
| 2019-01-05 | 570    | 114            | 5   |
| 2019-01-06 | 710    | 118.3333       | 6   |
| 2019-01-07 | 860    | 122.8571       | 7   |
| 2019-01-08 | 840    | 120            | 7   |
| 2019-01-09 | 840    | 120            | 7   |
| 2019-01-10 | 1000   | 142.8571       | 7   |
    
/*-------------------------------------------------------------------------------------------*/

SELECT
    visited_on,
    (
        SELECT SUM(amount)
        FROM customer
        WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on
    ) AS amount,
    ROUND(
        (
            SELECT SUM(amount) / 7
            FROM customer
            WHERE visited_on BETWEEN DATE_SUB(c.visited_on, INTERVAL 6 DAY) AND c.visited_on
        ),
        2
    ) AS average_amount
FROM customer c
WHERE visited_on >= (
        SELECT DATE_ADD(MIN(visited_on), INTERVAL 6 DAY)
        FROM customer
    )
GROUP BY visited_on;
