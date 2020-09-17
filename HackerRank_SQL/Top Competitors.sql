SELECT h.hacker_id, h.name
FROM Hackers h
JOIN Submissions s on h.hacker_id = s.hacker_id
JOIN Challenges c on s.challenge_id = c.challenge_id
JOIN Difficulty d on c.difficulty_level = d.difficulty_level
WHERE d.score = s.score AND d.difficulty_level = c.difficulty_level
GROUP BY h.hacker_id, h.name
HAVING COUNT(c.challenge_id) > 1
ORDER BY COUNT(c.challenge_id) DESC, h.hacker_id


select h.hacker_id,h.name 
from hackers h, challenges c, difficulty d, submissions s 
where h.hacker_id=s.hacker_id
and c.challenge_id=s.challenge_id
and c.difficulty_level=d.difficulty_level
and s.score=d.score
group by h.hacker_id,h.name having  count(h.hacker_id)>1
 order by count(c.challenge_id) desc,h.hacker_id