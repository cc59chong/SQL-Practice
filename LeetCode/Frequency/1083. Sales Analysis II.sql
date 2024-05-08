SELECT          DISTINCT buyer_id
FROM            Sales AS s
LEFT JOIN       Product AS p  /*OR JOIN*/ ON s.product_id = p.product_id
WHERE           p.product_name = 'S8' AND 
                buyer_id NOT IN (SELECT DISTINCT buyer_id 
                                 FROM            Sales AS s
                                 LEFT JOIN       Product AS p /*OR JOIN*/
                                 ON              s.product_id = p.product_id
                                 WHERE           p.product_name = 'iPhone');

/*-----------------------------------------------------------------------------*/
SELECT DISTINCT buyer_id
FROM Sales
WHERE buyer_id IN (SELECT s.buyer_id
                     FROM Product p
                     JOIN Sales s ON p.product_id=s.product_id
                     WHERE product_name = 'S8')
AND buyer_id NOT IN(SELECT s.buyer_id
                      FROM Product p
                      JOIN Sales s ON p.product_id=s.product_id
                      WHERE product_name = 'iPhone')
