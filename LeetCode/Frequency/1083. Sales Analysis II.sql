SELECT          DISTINCT buyer_id
FROM            Sales AS s
LEFT JOIN       Product AS p  /*OR JOIN*/
ON              s.product_id = p.product_id
WHERE           p.product_name = 'S8' AND 
                buyer_id NOT IN (SELECT DISTINCT buyer_id 
                                 FROM            Sales AS s
                                 LEFT JOIN       Product AS p /*OR JOIN*/
                                 ON              s.product_id = p.product_id
                                 WHERE           p.product_name = 'iPhone');