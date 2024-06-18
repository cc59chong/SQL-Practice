SELECT c.country_name, w.weather_type
FROM Countries c
JOIN (
SELECT country_id,
       CASE WHEN AVG(weather_state) <=15 THEN 'Cold'
            WHEN AVG(weather_state) >=25 THEN 'Hot'
            ELSE 'Warm'
        END AS weather_type
FROM Weather
WHERE LEFT(day,7)='2019-11'
GROUP BY country_id) w
ON c.country_id=w.country_id

/*-----------------------------------------------------------*/
       
SELECT c.country_name, 
       CASE WHEN AVG(w.weather_state) <= 15 THEN 'Cold' 
            WHEN AVG(w.weather_state) >= 25 THEN 'Hot'
            ELSE 'Warm' 
       END AS weather_type
FROM Weather w
LEFT JOIN Countries c ON w.country_id = c.country_id
WHERE MONTH(w.day) = 11
GROUP BY w.country_id;
