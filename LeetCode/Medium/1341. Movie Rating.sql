(
SELECT name AS results
FROM Users
JOIN (SELECT user_id, COUNT(movie_id) AS num
      FROM Movie_Rating
      GROUP BY user_id) t1
ON Users.user_id = t1.user_id
ORDER BY t1.num DESC, name LIMIT 1
)
UNION
(
SELECT title AS results
FROM Movies
JOIN (SELECT movie_id, AVG(rating) as rate
      FROM Movie_Rating
      WHERE MONTH(created_at) = 2
      GROUP BY movie_id) b
ON Movies.movie_id = b.movie_id
ORDER BY b.rate DESC, title LIMIT 1
)

/*----------------------------------------------------------------*/
(SELECT name results
FROM users u
JOIN movie_rating mr
ON u.user_id = mr.user_id
GROUP BY 1
ORDER BY count(rating) desc, 1 asc
Limit 1)

UNION

(SELECT title results
FROM movies m
JOIN movie_rating mr
ON m.movie_id = mr.movie_id
WHERE month(created_at) = 2
GROUP BY 1
ORDER BY avg(rating) desc, 1 asc
Limit 1)