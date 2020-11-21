WITH t1 AS (
    SELECT DISTINCT spend_date, 'desktop' as platform FROM Spending
    UNION
    SELECT DISTINCT spend_date , 'mobile' as platform FROM Spending
    UNION
    SELECT DISTINCT spend_date , 'both' as platform FROM Spending
),

t2 AS ( 
    SELECT user_id, 
           spend_date, 
           CASE WHEN COUNT(*)=1 THEN platform ELSE 'both' END platform, 
           SUM(amount) amount 
    FROM spending 
    GROUP BY user_id, spend_date
)

SELECT t1.spend_date, t1.platform,
       IFNULL(SUM(t2.amount), 0) AS total_amount,
       COUNT(user_id) total_users
FROM t1
LEFT JOIN t2 ON t1.spend_date = t2.spend_date AND t1.platform = t2.platform
GROUP BY t1.spend_date, t1.platform



/*
     
t1
{"headers": ["spend_date", "platform"], 
 "values": [["2019-07-01", "desktop"], 
            ["2019-07-02", "desktop"], 
            ["2019-07-01", "mobile"], 
            ["2019-07-02", "mobile"], 
            ["2019-07-01", "both"], 
            ["2019-07-02", "both"]]}
t2            
{"headers": ["user_id", "spend_date", "platform", "amount"], 
 "values": [[1, "2019-07-01", "both", 200], 
            [2, "2019-07-01", "mobile", 100], 
            [2, "2019-07-02", "mobile", 100], 
            [3, "2019-07-01", "desktop", 100], 
            [3, "2019-07-02", "desktop", 100]]} 


{"headers": ["spend_date", "platform", "user_id", "spend_date", "platform", "amount"], 
 "values": [["2019-07-01", "desktop", 3, "2019-07-01", "desktop", 100], 
            ["2019-07-02", "desktop", 3, "2019-07-02", "desktop", 100], 
            ["2019-07-01", "mobile", 2, "2019-07-01", "mobile", 100], 
            ["2019-07-02", "mobile", 2, "2019-07-02", "mobile", 100], 
            ["2019-07-01", "both", 1, "2019-07-01", "both", 200], 
            ["2019-07-02", "both", null, null, null, null]]}
*/

          




