SELECT p.product_id, p.Product_name
FROM Product p
WHERE p.product_id NOT IN (SELECT product_id
                           FROM Sales
                           WHERE sale_date NOT BETWEEN '2019-01-01' AND '2019-03-31');
                           
SELECT product_id, product_name 
FROM Product 
WHERE product_id IN(SELECT product_id
                    FROM Sales
                    GROUP BY product_id
                    HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31');