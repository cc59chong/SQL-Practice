SELECT F1.follower, COUNT(DISTINCT F2.follower) AS num
FROM follow F1
INNER JOIN follow F2 ON F1.follower = F2.followee
GROUP BY F1.follower



/*
SELECT *
FROM follow F1
INNER JOIN follow F2 ON F1.follower = F2.followee


{"headers": ["F1.followee", "F1.follower", "F2.followee", "F2.follower"], 
 "values": [["A", "B", "B", "C"], 
            ["A", "B", "B", "D"], 
            ["B", "D", "D", "E"]]}

*/