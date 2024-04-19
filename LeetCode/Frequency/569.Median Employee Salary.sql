WITH add_rank AS
    (SELECT id, company, salary,
        ROW_NUMBER()OVER(PARTITION BY company ORDER BY salary) AS rnk
    FROM Employee)
, add_count AS
    (SELECT company, COUNT(DISTINCT id) AS cnt
    FROM Employee
    GROUP BY company)

SELECT a.id, a.company, a.salary
FROM add_rank a
JOIN add_count b
ON a.company = b.company
AND a.rnk BETWEEN b.cnt / 2 AND b.cnt / 2 + 1


/*---------------------------------------------------------------------------*/

SELECT Id, Company, Salary
FROM (
SELECT *, 
       ROW_NUMBER() OVER(PARTITION BY COMPANY ORDER BY Salary ASC, Id ASC) AS RN_ASC,
       ROW_NUMBER() OVER(PARTITION BY COMPANY ORDER BY Salary DESC, Id DESC) AS RN_DESC
FROM Employee) AS temp
WHERE RN_ASC BETWEEN RN_DESC - 1 AND RN_DESC + 1 /*WHERE abs(RN_ASC-RN_DESC) BETWEEN 0 AND 1*、
ORDER BY Company, Salary;

| id | company | salary | RN_ASC | RN_DESC |
| -- | ------- | ------ | ------ | ------- |
| 4  | A       | 15314  | 6      | 1       |
| 1  | A       | 2341   | 5      | 2       |
| 6  | A       | 513    | 4      | 3       |
| 5  | A       | 451    | 3      | 4       |
| 2  | A       | 341    | 2      | 5       |
| 3  | A       | 15     | 1      | 6       |
| 10 | B       | 1345   | 6      | 1       |
| 11 | B       | 1221   | 5      | 2       |
| 9  | B       | 1154   | 4      | 3       |
| 12 | B       | 234    | 3      | 4       |
| 7  | B       | 15     | 2      | 5       |
| 8  | B       | 13     | 1      | 6       |
| 16 | C       | 2652   | 5      | 1       |
| 15 | C       | 2645   | 4      | 2       |
| 14 | C       | 2645   | 3      | 3       |
| 13 | C       | 2345   | 2      | 4       |
| 17 | C       | 65     | 1      | 5       |


/*---------------------------------------------------------------------------
WITH cte AS(
    SELECT e.*, t.cnt
FROM
(SELECT company, COUNT(id) cnt
FROM Employee
GROUP BY company) t
JOIN 
(SELECT *,
        ROW_NUMBER() OVER(PARTITION BY company ORDER BY salary) r
FROM Employee) e ON t.company=e.company)

SELECT id, company, salary
FROM(
SELECT *,
        CASE WHEN cnt%2=0 THEN r=cnt/2 OR r=cnt/2+1
            ELSE r=CEIL(cnt/2) END AS m
FROM cte) t
WHERE m=1

or

/*
SELECT id,company,salary
FROM cte
WHERE r BETWEEN cnt/2 AND cnt/2+1
*/

| id | company | salary | r | cnt | m |
| -- | ------- | ------ | - | --- | - |
| 3  | A       | 15     | 1 | 6   | 0 |
| 2  | A       | 341    | 2 | 6   | 0 |
| 5  | A       | 451    | 3 | 6   | 1 |
| 6  | A       | 513    | 4 | 6   | 1 |
| 1  | A       | 2341   | 5 | 6   | 0 |
| 4  | A       | 15314  | 6 | 6   | 0 |
| 8  | B       | 13     | 1 | 6   | 0 |
| 7  | B       | 15     | 2 | 6   | 0 |
| 12 | B       | 234    | 3 | 6   | 1 |
| 9  | B       | 1154   | 4 | 6   | 1 |
| 11 | B       | 1221   | 5 | 6   | 0 |
| 10 | B       | 1345   | 6 | 6   | 0 |
| 17 | C       | 65     | 1 | 5   | 0 |
| 13 | C       | 2345   | 2 | 5   | 0 |
| 14 | C       | 2645   | 3 | 5   | 1 |
| 15 | C       | 2645   | 4 | 5   | 0 |
| 16 | C       | 2652   | 5 | 5   | 0 |


