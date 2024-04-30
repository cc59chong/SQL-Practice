SELECT team_id, team_name,
SUM(
    CASE WHEN team_id = host_team AND host_goals > guest_goals THEN 3
         WHEN team_id = guest_team AND guest_goals > host_goals THEN 3
         WHEN host_goals = guest_goals THEN 1
         ELSE 0
    END          
) AS "num_points"
FROM Teams t
LEFT JOIN Matches m ON t.team_id = m.host_team OR t.team_id = m.guest_team
GROUP BY team_id, team_name
ORDER BY num_points DESC, team_id;

/*-------zj---------------------------------------------------------------------*/


SELECT t.team_id, t.team_name, IFNULL(t2.num_points,0) AS num_points 
FROM Teams t
LEFT JOIN (SELECT host_team AS team, SUM(host_point) AS num_points 
           FROM (
                 SELECT host_team,
                 CASE WHEN host_goals > guest_goals THEN 3 
                      WHEN host_goals = guest_goals THEN 1
                      WHEN host_goals < guest_goals THEN 0
                 END AS host_point
                 FROM Matches

                 UNION ALL

                SELECT guest_team,
                CASE WHEN host_goals < guest_goals THEN 3 
                     WHEN host_goals = guest_goals THEN 1
                     WHEN host_goals > guest_goals THEN 0
                END AS guest_point
               FROM Matches) t1
          GROUP BY host_team ) t2
ON t.team_id = t2.team
ORDER BY num_points DESC, t.team_id;

速度 2>1
