SELECT ROUND(IFNULL(
    SUM(CASE WHEN DATEDIFF(event_date,first_day)=1 THEN 1 END)/COUNT(DISTINCT a.player_id)
    ,0),2) AS fraction
FROM Activity a
JOIN (SELECT player_id, MIN(event_date) AS first_day
FROM Activity
GROUP BY player_id) t
ON a.player_id=t.player_id
  
/*------------------------------------------------------------------------------*/
  
SELECT ROUND(COUNT(DISTINCT player_id) / (SELECT COUNT(DISTINCT player_id) FROM Activity),2) as fraction 
FROM Activity
WHERE (player_id, DATE_SUB(event_date, INTERVAL 1 DAY)) 
IN (SELECT player_id, MIN(event_date) as first_login FROM Activity GROUP BY player_id)

/*------------------------------------------------------------------------------*/
SELECT ROUND(SUM(login)/COUNT(DISTINCT player_id), 2) AS fraction
FROM (
  SELECT
    player_id,
    DATEDIFF(event_date, MIN(event_date) OVER(PARTITION BY player_id)) = 1 AS login
  FROM Activity
) AS t

/*----------------------------------------------------------------------------*/ 
SELECT ROUND(
COUNT(a.player_id)/(SELECT COUNT(DISTINCT player_id) FROM Activity),2
) AS fraction  
FROM Activity a
LEFT JOIN 
(SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id) f
ON a.player_id=f.player_id
WHERE DATEDIFF(a.event_date, f.first_login)=1

速度 1>2>3>4
