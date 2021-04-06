SELECT p.name, SUM(i.rest) AS rest, SUM(i.paid) AS paid, SUM(i.canceled) AS canceled, SUM(i.refunded) AS refunded
FROM Invoice i
JOIN Product p
ON i.product_id = p.product_id
GROUP BY i.product_id
ORDER BY p.name