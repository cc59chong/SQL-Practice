SELECT DISTINCT s.buyer_id
FROM Sales s
JOIN Product p
ON s.product_id = p.product_id
AND p.product_name = 'S8'
AND s.buyer_id NOT IN
(
    SELECT DISTINCT buyer_id
    FROM Sales s
    JOIN Product p
    ON s.product_id = p.product_id
    AND p.product_name = 'iPhone'
    )


/*-----------------------------------------------------------*/

SELECT s.buyer_id
FROM Sales AS s INNER JOIN Product AS p
ON s.product_id = p.product_id
GROUP BY s.buyer_id
HAVING SUM(CASE WHEN p.product_name = 'S8' THEN 1 ELSE 0 END) > 0
AND SUM(CASE WHEN p.product_name = 'iPhone' THEN 1 ELSE 0 END) = 0;