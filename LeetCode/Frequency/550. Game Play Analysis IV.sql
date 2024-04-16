

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



/*------------------??????----------------------------------------------------*/ 
-- SELECT ROUND(COUNT(t2.player_id)/COUNT(t1.player_id),2) AS fraction
-- FROM
-- (SELECT player_id, MIN(event_date) AS first_login 
--  FROM Activity GROUP BY player_id) t1 
--  LEFT JOIN Activity t2
--  ON t1.player_id = t2.player_id AND t1.first_login = t2.event_date - 1
