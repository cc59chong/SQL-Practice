SELECT s.user_id,
       ROUND(IFNULL(SUM(CASE WHEN c.action='confirmed' THEN 1 END)/COUNT(c.user_id),0),2) AS confirmation_rate 
FROM Signups s
LEFT JOIN Confirmations c
ON s.user_id = c.user_id
GROUP BY s.user_id


/*--------------------------------------------------------------------------*/

SELECT s.user_id, IFNULL(confirmation_rate,0) AS confirmation_rate
FROM Signups s
LEFT JOIN (SELECT user_id, 
           ROUND(SUM(CASE WHEN action='confirmed' THEN 1 END)/COUNT(user_id),2) AS confirmation_rate
           FROM Confirmations GROUP BY 1) c
ON s.user_id=c.user_id
