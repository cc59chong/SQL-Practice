SELECT extra AS report_reason, COUNT(DISTINCT post_id) AS report_count
FROM Actions
WHERE DATEDIFF('2019-07-05', action_date) = 1 AND action = 'report'
GROUP BY extra;


/*----------------------------------------------------------------------*/

SELECT extra AS report_reason,
       COUNT(DISTINCT post_id ) AS report_count 
FROM Actions
WHERE action_date = DATE_SUB('2019-07-05', INTERVAL 1 DAY) AND action='report'
GROUP BY extra
