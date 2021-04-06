
SELECT h.hacker_id,h.name,COUNT(c.hacker_id)    
FROM Hackers h, Challenges c
WHERE h.hacker_id = c.hacker_id
GROUP BY h.hacker_id,h.name
HAVING COUNT(c.hacker_id) NOT IN (SELECT DISTINCT COUNT(hacker_id) 
                                  FROM Challenges
                                  WHERE hacker_id <> h.hacker_id
                                  GROUP BY hacker_id
                                  HAVING COUNT(hacker_id) 
							    < 
								  (SELECT MAX(x.challenge_count) 
                                                                   FROM (SELECT COUNT(c.challenge_id) AS challenge_count
         								 FROM Challenges c 
									 GROUP BY c.hacker_id) as x ))
ORDER BY count(c.hacker_id) desc, h.hacker_id 

SELECT MAX(x.challenge_count) 
FROM (SELECT COUNT(c.challenge_id) AS challenge_count
FROM Challenges c 
GROUP BY c.hacker_id) as x 

50

/* not working
SELECT c.hacker_id, h.name, COUNT(c.hacker_id) AS challenges_created
FROM Hackers h
JOIN Challenges c ON c.hacker_id = h.hacker_id
GROUP BY c.hacker_id
HAVING challenges_created =(SELECT MAX(a.cnt)
                            FROM (SELECT COUNT(hacker_id) AS cnt
                                  FROM Challenges
                                  GROUP BY hacker_id) a)
		OR challenges_created IN (SELECT b.cnt  
							      FROM (SELECT COUNT(*) as cnt
							            FROM Challenges
							            GROUP BY hacker_id) b
							      GROUP BY b.cnt
							      HAVING COUNT(b.cnt) = 1)
ORDER BY challenges_created DESC, c.hacker_id;
*/								  



MS SQL using WITH

/* count total submissions of challenges of each user */
WITH data
AS
(
SELECT c.hacker_id as id, h.name as name, count(c.hacker_id) as counter
FROM Hackers h
JOIN Challenges c on c.hacker_id = h.hacker_id
GROUP BY c.hacker_id, h.name
)
/* select records from above */
SELECT id,name,counter
FROM data
WHERE
counter=(SELECT max(counter) FROM data) /*select user that has max count submission*/
OR
counter in (SELECT counter FROM data
            GROUP BY counter
            HAVING count(counter)=1 ) /*filter out the submission count which is unique*/
            ORDER BY counter desc, id
