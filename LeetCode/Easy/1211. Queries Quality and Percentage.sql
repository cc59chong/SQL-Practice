
SELECT query_name,
      ROUND(AVG(rating/position),2) AS quality,
      ROUND(IFNULL(SUM(CASE WHEN rating < 3 THEN 1 END)/COUNT(rating)*100,0)
        ,2) AS poor_query_percentage 
FROM Queries
WHERE query_name IS NOT NULL /*in case quert_name is NULL*/
GROUP BY 1

/*---------------------------------------------------------------------*/

SELECT query_name,
       ROUND((SUM(rating/position) / COUNT(query_name)), 2) AS quality,
       ROUND((SUM(IF (rating<3, 1, 0)) / COUNT(query_name) * 100), 2) AS poor_query_percentage
FROM Queries
GROUP BY query_name;
