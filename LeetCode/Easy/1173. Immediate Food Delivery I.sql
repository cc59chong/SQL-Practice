SELECT ROUND(
    SUM(order_date=customer_pref_delivery_date)/COUNT(delivery_id)*100
    ,2
) AS immediate_percentage 
FROM Delivery

/*------------------------------------------------------------------*/

  SELECT ROUND(
    AVG(order_date=customer_pref_delivery_date)*100
    ,2
) AS immediate_percentage 
FROM Delivery

/*------------------------------------------------------------------*/
  
SELECT ROUND((SELECT COUNT(delivery_id) FROM Delivery
             WHERE order_date = customer_pref_delivery_date)
             /
             (COUNT(delivery_id))  * 100 , 2) AS immediate_percentage
FROM Delivery;
