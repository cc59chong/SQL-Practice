SELECT LOWER(TRIM(product_name)) AS product_name, 
       DATE_FORMAT(sale_date, "%Y-%m") AS sale_date,  /* LEFT(sale_date, 7)
       COUNT(sale_id) AS total
FROM Sales
GROUP BY 1, 2 /* MONTH(sale_date)*/
ORDER BY product_name, sale_date