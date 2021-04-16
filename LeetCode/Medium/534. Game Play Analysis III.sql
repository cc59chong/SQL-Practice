SELECT a1.player_id, a1.event_date, SUM(a2.games_played) AS games_played_so_far 
FROM Activity a1, Activity a2
WHERE a1.player_id = a2.player_id AND a1.event_date >=  a2.event_date
GROUP BY 1,2
ORDER BY 1,2

/*-------------------------------------------------------------------------------------------*/
SELECT
    player_id, 
    event_date,  
    sum(games_played) over(PARTITION BY player_id ORDER BY event_date) AS 'games_played_so_far'
FROM activity