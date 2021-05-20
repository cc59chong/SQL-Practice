SELECT stats AS period_state, MIN(day) AS start_date, MAX(day) AS end_date
FROM (
    SELECT 
        day, 
        RANK() OVER (ORDER BY day) AS overall_ranking, 
        stats, 
        rk, 
        (RANK() OVER (ORDER BY day) - rk) AS inv
    FROM (
        SELECT fail_date AS day, 'failed' AS stats, RANK() OVER (ORDER BY fail_date) AS rk
        FROM Failed
        WHERE fail_date BETWEEN '2019-01-01' AND '2019-12-31'
        UNION 
        SELECT success_date AS day, 'succeeded' AS stats, RANK() OVER (ORDER BY success_date) AS rk
        FROM Succeeded
        WHERE success_date BETWEEN '2019-01-01' AND '2019-12-31') t
    ) c
GROUP BY inv, stats
ORDER BY start_date
        
        
        
/*  c      
day   | overall_ranking| stats  | rk | inv          
      | 2019-01-01 | 1 | success | 1 | 0
      | 2019-01-02 | 2 | success | 2 | 0
      | 2019-01-03 | 3 | success | 3 | 0
      | 2019-01-04 | 4 | fail    | 1 | 3
      | 2019-01-05 | 5 | fail    | 2 | 3
      | 2019-01-06 | 6 | success | 4 | 2
    
        
*/     
        
        
/*  t      
        {"headers": ["day", "stats", "rk"], 
        "values": [["2019-01-04", "failed", 1], 
                  ["2019-01-05", "failed", 2], 
                  ["2019-01-01", "succeeded", 1], 
                  ["2019-01-02", "succeeded", 2], 
                  ["2019-01-03", "succeeded", 3], 
                  ["2019-01-06", "succeeded", 4]]}
*/