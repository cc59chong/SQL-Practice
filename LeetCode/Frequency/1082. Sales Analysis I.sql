
SELECT seller_id 
FROM Sales
GROUP BY seller_id
HAVING SUM(price) >= ALL (SELECT SUM(price) FROM Sales GROUP BY seller_id);

/*--------------------------------------------------------------------------*/

SELECT seller_id
FROM Sales
GROUP BY seller_id
HAVING SUM(price) IN (SELECT MAX(price)
                      FROM(SELECT SUM(price) AS price
                           FROM Sales
                           GROUP BY seller_id) t )

速度 2>1
