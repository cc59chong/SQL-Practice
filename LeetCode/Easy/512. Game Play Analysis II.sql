SELECT DISTINCT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN (SELECT player_id, MIN(event_date)
                                  FROM Activity
                                  GROUP BY player_id)；
								  
SELECT a.player_id, a.device_id
FROM Activity a
JOIN 
(SELECT player_id, MIN(event_date) minDate
 FROM Activity
 GROUP BY player_id) b
ON a.player_id = b.player_id AND a.event_date = b.minDate;