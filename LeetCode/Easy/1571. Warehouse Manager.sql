SELECT w.name AS warehouse_name, SUM(w.units * t.volume) AS volume
FROM Warehouse w
JOIN (SELECT product_id, product_name, (Width * Length * Height) AS volume
      FROM Products) AS t
ON w.product_id = t.product_id
GROUP BY w.name
