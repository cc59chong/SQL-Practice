SELECT DISTINCT a.seat_id
FROM cinema a, cinema b
WHERE a.free = '1' AND b.free = '1' AND ABS(a.seat_id - b.seat_id) = 1
ORDER BY a.seat_id;

/*
| seat_id | free | seat_id | free |
| ------- | ---- | ------- | ---- |
| 5       | 1    | 1       | 1    |
| 4       | 1    | 1       | 1    |
| 3       | 1    | 1       | 1    |
| 1       | 1    | 1       | 1    |
| 5       | 1    | 3       | 1    |
| 4       | 1    | 3       | 1    |
| 3       | 1    | 3       | 1    |
| 1       | 1    | 3       | 1    |
| 5       | 1    | 4       | 1    |
| 4       | 1    | 4       | 1    |
| 3       | 1    | 4       | 1    |
| 1       | 1    | 4       | 1    |
| 5       | 1    | 5       | 1    |
| 4       | 1    | 5       | 1    |
| 3       | 1    | 5       | 1    |
| 1       | 1    | 5       | 1    |*/
