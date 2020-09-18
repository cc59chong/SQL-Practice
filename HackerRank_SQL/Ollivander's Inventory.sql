
SELECT w.id, p.age, w.coins_needed, w.power
FROM Wands w
JOIN Wands_Property p ON w.code = p.code
WHERE (w.power, p.age, w.coins_needed) IN (SELECT w1.power, p1.age, MIN(w1.coins_needed)
                                           FROM Wands w1
                                           JOIN Wands_Property p1 ON w1.code = p1.code
                                           WHERE p1.is_evil = 0
                                           GROUP BY w1.power, p1.age)
ORDER BY w.power DESC, p.age DESC;


select w.id, p.age, w.coins_needed, w.power 
from Wands as w 
join Wands_Property as p 
on (w.code = p.code) 
where p.is_evil = 0 
and w.coins_needed = (select min(coins_needed) 
                      from Wands as w1 
					  join Wands_Property as p1 
					  on (w1.code = p1.code) 
					  where w1.power = w.power and p1.age = p.age) 
order by w.power desc, p.age desc
