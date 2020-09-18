
SELECT b.hacker_id, h.name, b.total
FROM Hackers h
JOIN (SELECT a.hacker_id, SUM(a.score) as total 
      FROM (SELECT hacker_id, challenge_id, MAX(score) as score
            FROM Submissions 
            GROUP BY hacker_id, challenge_id) a
      GROUP BY a.hacker_id
      HAVING SUM(a.score) >0) b
ON h.hacker_id = b.hacker_id
ORDER BY b.total DESC, b.hacker_id
/*
SELECT hacker_id, challenge_id, MAX(score) as score
FROM Submissions 
GROUP BY hacker_id, challenge_id

486 20594 45 
486 68420 29 
597 20594 107 
775 68420 31 
964 28665 55 
1700 14825 66 
1700 38705 49 
------------------------------------------------------------
SELECT a.hacker_id, SUM(a.score)
FROM (SELECT hacker_id, challenge_id, MAX(score) as score
      FROM Submissions 
      GROUP BY hacker_id, challenge_id) a
GROUP BY a.hacker_id
HAVING SUM(a.score) >0

486 74 
597 107 
775 31 
964 55 
1700 115 
1746 32 