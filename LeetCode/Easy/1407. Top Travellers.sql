SELECT u.name, IFNULL(SUM(r.distance), 0) AS travelled_distance
FROM Users u
LEFT JOIN Rides r ON u.id = r.user_id
GROUP BY r.user_id
ORDER BY SUM(r.distance) DESC, u.name;