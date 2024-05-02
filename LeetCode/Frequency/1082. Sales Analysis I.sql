
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

/*--------------------------------------------------------------------------*/


SELECT seller_id
FROM(
SELECT *,
       DENSE_RANK()OVER(ORDER BY total DESC) AS rak
FROM(
SELECT seller_id,
       SUM(price) AS total
FROM Sales
GROUP BY seller_id) a) b
WHERE rak =1

  
速度 2>1>3
