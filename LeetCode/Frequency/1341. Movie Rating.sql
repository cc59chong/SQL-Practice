(SELECT name AS results
FROM MovieRating mr
JOIN Users u ON mr.user_id=u.user_id
GROUP BY mr.user_id
ORDER BY COUNT(rating) DESC, name
LIMIT 1)
UNION ALL
(SELECT title AS results
FROM MovieRating mr
JOIN Movies m ON mr.movie_id=m.movie_id
WHERE LEFT(created_at,7) = '2020-02'
GROUP BY mr.movie_id
ORDER BY AVG(rating) DESC, title
LIMIT 1)


(
SELECT name AS results
FROM Users
JOIN (SELECT user_id, COUNT(movie_id) AS num
      FROM Movie_Rating
      GROUP BY user_id) t1
ON Users.user_id = t1.user_id
ORDER BY t1.num DESC, name LIMIT 1
)
UNION ALL
(
SELECT title AS results
FROM Movies
JOIN (SELECT movie_id, AVG(rating) as rate
      FROM Movie_Rating
      WHERE MONTH(created_at) = 2 /*最好是LEFT(created_at,7) = '2020-02'*/
      GROUP BY movie_id) b
ON Movies.movie_id = b.movie_id
ORDER BY b.rate DESC, title LIMIT 1
)
