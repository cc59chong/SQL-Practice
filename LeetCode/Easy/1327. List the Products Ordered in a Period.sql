SELECT p.product_name, t.unit
FROM Products p
JOIN (
SELECT product_id, SUM(unit) AS unit
FROM Orders
WHERE LEFT(order_date,7)='2020-02'
GROUP BY product_id) t
ON p.product_id=t.product_id
WHERE unit>=100

/*-------------------------------------------------------------*/

SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
RIGHT JOIN Orders o ON p.product_id = o.product_id
WHERE DATE_FORMAT(o.order_date, '%Y-%m') = '2020-02'
GROUP BY o.product_id
HAVING SUM(o.unit) >= 100
