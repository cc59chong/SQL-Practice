SELECT t.customer_id, t.product_id, p.product_name 
FROM (SELECT customer_id, 
             product_id,
             DENSE_RANK() OVER (PARTITION BY customer_id ORDER BY COUNT(*) DESC) pro_rnk
      FROM Orders
     GROUP BY customer_id, product_id) t
JOIN Products p
ON p.product_id = t.product_id
WHERE t.pro_rnk = 1;