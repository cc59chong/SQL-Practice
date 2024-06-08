SELECT product_id,
       MAX(CASE WHEN store = 'store1' THEN price END) AS store1,
       MAX(CASE WHEN store = 'store2' THEN price END) AS store2,
       MAX(CASE WHEN store = 'store3' THEN price END) AS store3
FROM Products
GROUP BY product_id

/* Pivot Table
SELECT *
FROM (
       SELECT product_id,store,price FROM Products
     )T1
PIVOT
(MAX(price) FOR store IN (
                           [store1],
                           [store2],
                           [store3]
                         ) 
)T2

*/