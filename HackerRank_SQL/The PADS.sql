SELECT 
CONCAT (Name, CASE WHEN Occupation = 'Doctor' THEN '(D)'
                   WHEN Occupation = 'Professor' THEN '(P)'
                   WHEN Occupation = 'Singer' THEN '(S)'
                   WHEN Occupation = 'Actor' THEN '(A)'
				   END)
FROM OCCUPATIONS
ORDER BY Name;

SELECT 
CONCAT (Name, '(', SUBSTRING(Occupation, 1, 1), ')') 
FROM OCCUPATIONS
ORDER BY Name;

SELECT 
CONCAT (Name, '(', SUBSTR(Occupation, 1, 1), ')') 
FROM OCCUPATIONS
ORDER BY Name;

SELECT 
CONCAT (Name, '(', MID(Occupation, 1, 1), ')') 
FROM OCCUPATIONS
ORDER BY Name;


SELECT 'There are a total of' , COUNT(Name), CONCAT(LOWER(Occupation),'s.')
FROM OCCUPATIONS
GROUP BY Occupation
ORDER BY COUNT(Name), Occupation;

