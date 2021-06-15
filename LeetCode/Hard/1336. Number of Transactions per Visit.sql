
WITH t AS (SELECT v.user_id as user_id, visit_date, count(t.transaction_date) as transaction_count
            FROM Visits v 
            LEFT JOIN Transactions t on v.visit_date = t.transaction_date and v.user_id=t.user_id
            GROUP BY 1, 2),

    row_nums AS (SELECT ROW_NUMBER() OVER () as rn 
                 FROM Transactions 
                 UNION 
                 SELECT 0) 
				 
SELECT row_nums.rn as transactions_count, count(t.transaction_count) as visits_count
FROM t 
RIGHT JOIN row_nums ON transaction_count = rn
/* We can remove excess transaction-numbers (eg if the max transaction-number is four, we don't need five+ in our end result)*/
WHERE rn <= (SELECT MAX(transaction_count) FROM t)
GROUP BY rn
ORDER BY 1





/* t
{"headers": ["user_id", "visit_date", "transaction_count"], 
 "values": [[1, "2020-01-01", 0], 
            [2, "2020-01-02", 0], 
            [12, "2020-01-01", 0], 
            [19, "2020-01-03", 0], 
            [1, "2020-01-02", 1], 
            [2, "2020-01-03", 1], 
            [1, "2020-01-04", 1], 
            [7, "2020-01-11", 1], 
            [9, "2020-01-25", 3], 
            [8, "2020-01-28", 1]]} */

/*{"headers": ["rn"], 
    "values": [[1], [2], [3], [4], [5], [6], [7], [8], [0]]}*/