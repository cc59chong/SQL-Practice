


WITH a AS
(
   SELECT t.seller_id, i.item_brand
   FROM (
          SELECT seller_id, 
              item_id, 
              RANK() OVER (PARTITION BY seller_id ORDER BY order_date ) AS rk_date
          FROM Orders) t
    JOIN Items i ON t.item_id = i.item_id
    WHERE t.rk_date = 2
)

SELECT u.user_id AS seller_id,
       CASE WHEN a.seller_id IS NULL THEN 'no'
            WHEN u.favorite_brand = a.item_brand THEN 'yes' ELSE 'no'
       END AS 2nd_item_fav_brand 
       FROM Users u
LEFT JOIN a ON u.user_id = a.seller_id

/*
{"headers": ["user_id", "join_date", "favorite_brand", "seller_id", "item_brand"], 
"values": [[1, "2019-01-01", "Lenovo", null, null], 
           [2, "2019-02-09", "Samsung", 2, "Samsung"], 
           [3, "2019-01-19", "LG", 3, "LG"], 
           [4, "2019-05-21", "HP", 4, "Lenovo"]]}*/