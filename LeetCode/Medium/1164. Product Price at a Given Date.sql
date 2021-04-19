
SELECT distinct a.product_id,ifnull(temp.new_price,10) as price 
FROM products as a
LEFT JOIN
(SELECT * 
FROM products 
WHERE (product_id, change_date) in (select product_id,max(change_date) from products where change_date<="2019-08-16" group by product_id)) as temp
on a.product_id = temp.product_id;


/*
temp
SELECT * 
FROM products 
WHERE (product_id, change_date) in (select product_id,max(change_date) from products where change_date<="2019-08-16" group by product_id)

{"headers": ["product_id", "new_price", "change_date"], 
"values": [[2, 50, "2019-08-14"], [1, 35, "2019-08-16"]]}


Left join
{"headers": ["product_id", "new_price", "change_date", "product_id", "new_price", "change_date"], 
"values": [[1, 20, "2019-08-14", 1, 35, "2019-08-16"], 
           [2, 50, "2019-08-14", 2, 50, "2019-08-14"], 
           [1, 30, "2019-08-15", 1, 35, "2019-08-16"], 
           [1, 35, "2019-08-16", 1, 35, "2019-08-16"], 
           [2, 65, "2019-08-17", 2, 50, "2019-08-14"], 
           [3, 20, "2019-08-18", null, null, null]]}
*/


