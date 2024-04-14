SELECT 
    (CASE WHEN MOD(id,2) != 0 AND id != (SELECT COUNT(*) FROM seat) THEN id + 1
          WHEN MOD(id, 2) = 0 THEN id-1
          ELSE id
     END) id,student
FROM seat
ORDER BY id;

/*------------------------------------------------------------------------*/

SELECT 
      (CASE WHEN id%2!=0 AND id != (SELECT MAX(id) FROM Seat) THEN id+1
            WHEN id%2=0 THEN id-1
            ELSE id
        END) AS id, student
FROM Seat
ORDER BY id
