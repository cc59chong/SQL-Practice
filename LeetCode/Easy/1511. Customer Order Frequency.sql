
SELECT customer_id, name
FROM Customers
WHERE customer_id in (SELECT o.customer_id
                      FROM Product p
                      JOIN Orders o ON p.product_id = o.product_id
                      WHERE MONTH(o.order_date) = 6 
                      GROUP BY o.customer_id
                      HAVING SUM(o.quantity * p.price) >= 100)
AND customer_id in (SELECT o.customer_id
                      FROM Product p
                      JOIN Orders o ON p.product_id = o.product_id
                      WHERE MONTH(o.order_date) = 7
                      GROUP BY o.customer_id
                      HAVING SUM(o.quantity * p.price) >= 100);
					  
/*-------------------------------------------------------------------------------------*/
select o.customer_id, c.name from orders o
inner join customers c on o.customer_id = c.customer_id
inner join product p on o.product_id = p.product_id
group by o.customer_id, c.name
having (sum(case when month(order_date) = '6' then o.quantity * p.price else 0 end) >=100) and
(sum(case when month(order_date) = '7' then o.quantity * p.price else 0 end)>=100)

/*-------------------------------------------------------------------------------------*/
WITH CTE AS
(
SELECT customer_id, DATE_FORMAT(order_date,'%Y-%m') AS order_date
FROM Orders o INNER JOIN Product p
ON o.product_id = p.product_id
GROUP BY customer_id, DATE_FORMAT(order_date,'%Y-%m')
HAVING SUM(quantity *price) >= 100)

SELECT a.customer_id, c.name
FROM CTE a INNER JOIN CTE b
ON a.customer_id = b.customer_id
INNER JOIN Customers c
ON a.customer_id = c.customer_id
WHERE a.order_date = '2020-06'
AND b.order_date = '2020-07'