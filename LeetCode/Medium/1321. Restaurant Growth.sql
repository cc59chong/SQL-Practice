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