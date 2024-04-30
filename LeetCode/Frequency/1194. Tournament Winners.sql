WITH t1 AS(
SELECT player_id, SUM(score) AS score
FROM(
SELECT first_player AS player_id, SUM(first_score) AS score
FROM Matches
GROUP BY 1
UNION ALL
SELECT second_player AS player_id, SUM(second_score ) AS score
FROM Matches
GROUP BY 1) a
GROUP BY 1)
, t2 AS(
SELECT p.player_id,
       p.group_id,
       t1.score,
       DENSE_RANK()OVER(PARTITION BY p.group_id ORDER BY t1.score DESC, p.player_id) rak
FROM Players p
JOIN t1 ON p.player_id=t1.player_id)

SELECT group_id, player_id
FROM t2
WHERE rak = 1
	
/*----------------------------------------------------------------------------------------------------------------------------*/

	
SELECT group_id,player_id
FROM(
SELECT group_id,
       player_id,
       SUM(CASE WHEN player_id=first_player THEN first_score
            WHEN player_id=second_player THEN second_score
        END) AS score
FROM Players p
JOIN Matches m ON p.player_id=m.first_player OR p.player_id=m.second_player
GROUP BY group_id, player_id
ORDER by score DESC, player_id) t
GROUP BY group_id
/*----------------------------------------------------------------------------------------------------------------------------*/
	
select group_id, player_id from 
(
    select p.player_id, 
           p.group_id, 
           rank() over(partition by p.group_id order by player_total.score desc, p.player_id asc) 'rank'
    /*or  row_number() over(partition by p.group_id order by player_total.score desc, p.player_id asc) 'rank'  */
    from players p 
    join
        (
            select player_id, sum(player_score.score) as score
            from (
                    (select first_player as player_id, first_score as score from Matches)
                        union all
                    (select second_player as player_id, second_score as score from Matches)
                 ) player_score 
            group by player_id
        ) player_total
    on p.player_id = player_total.player_id
) rank_table 
where rank_table.rank = 1

/*----------------------------------------------------------------------------------------------------------------------------*/


/*
1. Join Players and Matches on player_id in (first_player, second_player).
2. Sum up the first_score and the second_score whenever the player_id equals to the first_player or the second_player respctively
3. Rank the total scores in desc and player_id in asc
4. Select from sub-query where rank = 1
*/

select	group_id, player_id from
	(	select 	p.group_id, 
                p.player_id,
		        rank() over (partition by p.group_id order by
		        sum(case when p.player_id = m.first_player then m.first_score else m.second_score end) desc,
		        p.player_id asc) rk
	from players p	
    join matches m 
    on p.player_id in (m.first_player, m.second_player)
	group by p.group_id, p.player_id
	)  t where rk = 1

/*---------------------------------------------------------------------------------------------*/

-- Common Table Expression for Consolidating Scores
WITH PlayerScores AS (
  -- Combine scores where player is the first player
  SELECT 
    first_player AS player_id, 
    first_score AS score 
  FROM 
    matches 
  UNION ALL 
    -- Combine scores where player is the second player
  SELECT 
    second_player AS player_id, 
    second_score AS score 
  FROM 
    matches
), 
TotalScores AS (
  -- Aggregate Total Scores for Each Player
  SELECT 
    player_id, 
    SUM(score) AS total_score 
  FROM 
    PlayerScores 
  GROUP BY 
    player_id
) -- Select the Winner in Each Group
SELECT 
  DISTINCT group_id, 
  -- Use window function to determine the player with the highest score in each group
  -- In case of a tie, the player with the lowest player_id is chosen
  FIRST_VALUE(TotalScores.player_id) OVER (
    PARTITION BY group_id 
    ORDER BY 
      total_score DESC, 
      TotalScores.player_id
  ) AS player_id -- Winner player_id
FROM 
  TotalScores -- Join with Players table to get group information
  LEFT JOIN players ON TotalScores.player_id = players.player_id

/*----------------------------------------------------------------------------------*/

Here's a breakdown of the logic:

1. Combine Scores for Each Playing Position

This step creates a unified view of scores, regardless of whether the player was playing in the first or second position in a match. The UNION ALL combines scores from both positions into a single table with two columns: player_id and score.

WITH PlayerScores AS (
    SELECT first_player AS player_id, first_score AS score 
    FROM matches 
    UNION ALL 
    SELECT second_player AS player_id, second_score AS    score 
    FROM matches
)

| player_id | score |
| --------- | ----- |
| 15        | 3     |
| 30        | 1     |
| 30        | 2     |
| 40        | 5     |
| 35        | 1     |
| 45        | 0     |
| 25        | 2     |
| 15        | 0     |
| 20        | 2     |
| 50        | 1     |

2. Aggregate Total Scores for Each Player

Here, the total score for each player is calculated by summing up their scores across all matches. This aggregation is essential to determine the overall performance of each player in the tournament.

TotalScores AS (
    SELECT player_id, SUM(score) AS total_score 
    FROM PlayerScores 
    GROUP BY player_id
)

| player_id | total_score |
| --------- | ----------- |
| 15        | 3           |
| 30        | 3           |
| 40        | 5           |
| 35        | 1           |
| 45        | 0           |
| 25        | 2           |
| 20        | 2           |
| 50        | 1           |

3. Select the Winner in Each Group

The final step is to determine the winner in each group.

Distinct Groups: The DISTINCT keyword ensures that each group is represented once.
Window Function: FIRST_VALUE is used within an OVER clause, partitioned by group_id. This window function selects the player with the highest score in each group. In case of a tie (same score), the player with the lower player_id is chosen, as specified by the ORDER BY clause.
Join with Players Table: The LEFT JOIN with the players table brings in the group_id information, linking it to the total scores of players.

SELECT DISTINCT group_id, 
    FIRST_VALUE(TotalScores.player_id) OVER (
        PARTITION BY group_id 
        ORDER BY total_score DESC, TotalScores.player_id
    ) AS player_id
FROM TotalScores 
LEFT JOIN players ON TotalScores.player_id = players.player_id
