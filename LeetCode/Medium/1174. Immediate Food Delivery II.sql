SELECT
    ROUND(100*SUM(CASE WHEN order_date = customer_pref_delivery_date THEN 1
    ELSE 0 END)
    / 
    COUNT(distinct customer_id) ,2) AS immediate_percentage
FROM
    Delivery
WHERE
    (customer_id, order_date) IN (SELECT customer_id, min(order_date) as min_date
                                  FROM Delivery
                                  GROUP BY customer_id);
								  
/*-----------------------------------------------------------*/

select round(count(*)/(select count(distinct customer_id) from Delivery) * 100,2) as immediate_percentage
from (select customer_id
      from Delivery
      group by customer_id
      having min(order_date) = min(customer_pref_delivery_date)) as temp
