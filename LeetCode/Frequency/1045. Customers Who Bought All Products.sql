SELECT customer_id
FROM Customer
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)


/*--------------------------------------------------------------------------------------------------------------------------*/
SELECT customer_id
FROM Customer
WHERE product_key IN (SELECT product_key FROM Product) /*in case a customer buys a product that is not within product table.*/
GROUP BY customer_id
HAVING COUNT(DISTINCT product_key) = (SELECT COUNT(*) FROM Product)
