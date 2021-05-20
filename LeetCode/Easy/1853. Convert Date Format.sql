SELECT CONCAT(DAYNAME(day), ', ', MONTHNAME(day),' ', DAY(day), ', ',YEAR(day)) AS day
FROM Days

SELECT DATE_FORMAT(day, "%W, %M %e, %Y") AS day
FROM Days