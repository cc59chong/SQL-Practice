select sum(TIV_2016) as TIV_2016
from insurance
where TIV_2015 in (select TIV_2015
                   from insurance
                   group by TIV_2015
                   having count(*) > 1)
and (LAT, LON) in (select LAT, LON
                   from insurance
                   group by LAT, LON
                   having count(*) = 1)
				   
/*----------------------------------------------------------------------------------*/

SELECT ROUND(SUM(TIV_2016),2) AS TIV_2016
FROM (SELECT TIV_2016,
      COUNT(*) OVER(PARTITION BY TIV_2015) AS CNT1,
      COUNT(*) OVER(PARTITION BY LAT, LON) AS CNT2
      FROM INSURANCE
      ) AS T
WHERE CNT1 > 1 AND CNT2 =1

/*----------------------------------------------------------------------------------*/

SELECT ROUND(SUM(TIV_2016),2) AS TIV_2016
FROM insurance a
WHERE (SELECT COUNT(*) FROM insurance b WHERE a.TIV_2015 = b.TIV_2015) >1
  AND (SELECT COUNT(*) FROM insurance c WHERE (a.LAT,a.LON) = (c.LAT,c.LON)) =1;
 
/*----------------------------------------------------------------------------------*/
SELECT ROUND(SUM(TIV_2016),2) AS TIV_2016 
FROM insurance a
WHERE EXISTS (SELECT * FROM insurance WHERE PID <> a.PID AND TIV_2015 = a.TIV_2015)
  AND NOT EXISTS (SELECT * FROM insurance WHERE PID <> a.PID AND (LAT,LON) = (a.LAT,a.LON));
  