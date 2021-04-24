
SELECT ROUND(SQRT(MIN(POW(p1.x-p2.x,2) + POW(p1.y-p2.y,2))),2) AS shortest
FROM point_2d p1, point_2d p2
WHERE (p1.x, p1.y) != (p2.x, p2.y)

/*------------------------------------------------------------------------*/

select ROUND(SQRT(min((p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y))),2) as shortest
from point_2d p1,point_2d p2
where p1.x <> p2.x or p1.y <> p2.y;