WITH SUM_View_Stats AS 
(SELECT challenge_id,
        SUM(total_views) AS total_views, 
        SUM(total_unique_views) AS total_unique_views
 FROM View_Stats 
 GROUP BY challenge_id
),

SUM_Submission_Stats AS 
(SELECT challenge_id, 
        SUM(total_submissions) AS total_submissions, 
        SUM(total_accepted_submissions) AS total_accepted_submissions
 FROM Submission_Stats 
 GROUP BY challenge_id
)

SELECT con.contest_id, 
       con.hacker_id, 
       con.name,
       SUM(total_submissions),
       SUM(total_accepted_submissions),
       SUM(total_views),
       SUM(total_unique_views)
FROM Contests con
INNER JOIN Colleges col ON con.contest_id = col.contest_id
INNER JOIN Challenges cha ON cha.college_id = col.college_id
LEFT JOIN SUM_View_Stats vs ON vs.challenge_id = cha.challenge_id
LEFT JOIN SUM_Submission_Stats ss ON ss.challenge_id = cha.challenge_id
GROUP BY con.contest_id,con.hacker_id,con.name
HAVING SUM(total_submissions)!=0 OR
       SUM(total_accepted_submissions) !=0 OR
       SUM(total_views) !=0 OR
       SUM(total_unique_views) !=0
ORDER BY con.contest_ID