SELECT book_id, 
       name
FROM Books
WHERE available_from < '2019-05-23'
AND book_id NOT IN
            (SELECT book_id
             FROM Orders
             WHERE dispatch_date BETWEEN '2018-06-23' AND '2019-06-23'
             GROUP BY book_id
             Having sum(quantity) >= 10)

/*-------------------------------------------------------------------------*/



SELECT b.book_id, b.name
FROM Books b
LEFT JOIN
(

SELECT book_id, IFNULL(SUM(quantity),0) AS total_quantity
FROM Orders
WHERE dispatch_date BETWEEN '2018-06-23' AND '2019-06-23' 
GROUP BY book_id) a

ON b.book_id = a.book_id
WHERE available_from < '2019-05-23'
  AND (a.total_quantity < 10 OR a.total_quantity IS NULL)
GROUP BY b.book_id



/*
{"headers": ["book_id", "name", "available_from", "book_id", "total_quantity"], 
"values": [[1, "Kalila And Demna", "2010-01-01", 1, 3], 
           [2, "28 Letters", "2012-05-12", null, null], 
           [3, "The Hobbit", "2019-06-10", 3, 8], 
           [4, "13 Reasons Why", "2019-06-01", 4, 11], 
           [5, "The Hunger Games", "2008-09-21", null, null]]}
*/