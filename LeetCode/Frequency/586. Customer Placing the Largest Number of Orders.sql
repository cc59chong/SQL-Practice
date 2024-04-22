
SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC LIMIT 1;

/*------------------------------------------------------*/

SELECT customer_number
FROM orders
GROUP BY customer_number
HAVING COUNT(order_number) >= ALL (SELECT COUNT(order_number) 
                                   FROM orders 
                                   GROUP BY customer_number)

/*------------------------------------------------------*/
  
SELECT customer_number 
FROM orders
GROUP BY customer_number
HAVING count(order_number) = (
	SELECT count(order_number)
	FROM orders
	GROUP BY customer_number
	ORDER BY count(order_number) DESC LIMIT 1
)
