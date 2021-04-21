# Write your MySQL query statement below
SELECT c.Name
FROM Candidate c
JOIN (SELECT CandidateId
      FROM Vote
      GROUP BY CandidateID
      ORDER BY COUNT(id) DESC
      LIMIT 1) t
ON c.id = t.CandidateId