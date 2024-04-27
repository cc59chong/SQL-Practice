SELECT DISTINCT a.seat_id
FROM cinema a, cinema b
WHERE a.free = '1' AND b.free = '1' AND ABS(a.seat_id - b.seat_id) = 1
ORDER BY a.seat_id;
