/*
https://www.tutorialspoint.com/mysql/mysql-regexps.htm

REGEXP （Regular Expression Syntax）

the LIKE is asking for the condition matching ^ (which is the beginning of the string) 
and [aeiou] (which are the letters we are searching for at the beginning of the string). 
*/

SELECT DISTINCT CITY 
FROM STATION 
WHERE CITY REGEXP '^[aeiou]';