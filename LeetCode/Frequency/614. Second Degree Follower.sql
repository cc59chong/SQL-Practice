SELECT F1.follower, COUNT(DISTINCT F2.follower) AS num
FROM follow F1
INNER JOIN follow F2 ON F1.follower = F2.followee
GROUP BY F1.follower



/*
SELECT *
FROM follow F1
INNER JOIN follow F2 ON F1.follower = F2.followee


| followee | follower | followee | follower |
| -------- | -------- | -------- | -------- |
| Alice    | Bob      | Bob      | Cena     |
| Alice    | Bob      | Bob      | Donald   |
| Bob      | Donald   | Donald   | Edward   |

*/

SELECT followee AS follower, num
FROM(
SELECT followee, COUNT(follower) num
FROM Follow
GROUP BY followee) t
WHERE followee IN (SELECT DISTINCT follower FROM Follow)
ORDER BY follower
