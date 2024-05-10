SELECT 
    'Low Salary' AS category,
    SUM(CASE WHEN income < 20000 THEN 1 ELSE 0 END) AS accounts_count
FROM 
    Accounts
    
UNION
SELECT  
    'Average Salary' category,
    SUM(CASE WHEN income >= 20000 AND income <= 50000 THEN 1 ELSE 0 END) 
    AS accounts_count
FROM 
    Accounts

UNION
SELECT 
    'High Salary' category,
    SUM(CASE WHEN income > 50000 THEN 1 ELSE 0 END) AS accounts_count
FROM 
    Accounts

/*----------------------------------------------------------------------*/
    
(select 
"Low Salary" as category,
(select count(*)  from Accounts where income < 20000) as accounts_count)
union all
(select 
"Average Salary" as category,
(select count(*) from Accounts where income >= 20000 and income <= 50000) as accounts_count)
union all 
(select 
"High Salary" as category,
(select count(*) from Accounts where income > 50000) as accounts_count)

/*----------------------------------------------------------------------*/

SELECT 'Low Salary' AS category, 
       COUNT(CASE WHEN income<20000 THEN 1 END) AS accounts_count
FROM Accounts
UNION
SELECT 'Average Salary' AS category, 
       COUNT(CASE WHEN income>=20000 AND income <=50000 THEN 1 END) AS accounts_count
FROM Accounts
UNION
SELECT 'High Salary' AS category, 
       COUNT(CASE WHEN income>50000 THEN 1 END) AS accounts_count
FROM Accounts
