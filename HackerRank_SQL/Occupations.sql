SELECT 
MIN(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
MIN(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
MIN(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
MIN(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM (
  SELECT a.Occupation,
         a.Name,
         (SELECT COUNT(*) 
            FROM Occupations AS b
            WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rank
  FROM Occupations AS a
) AS c
GROUP BY c.rank;


/*
This query creates the ranking value, smaller values are in alphabetical order.

 SELECT a.Occupation,
        a.Name,
        (SELECT COUNT(*) 
         FROM Occupations AS b
         WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rank
 FROM Occupations AS a
  
+------------+-----------+------+
| Occupation | Name      | rank |
+------------+-----------+------+
| Doctor     | Samantha  |    1 |
| Actor      | Julia     |    1 |
| Actor      | Maria     |    2 |
| Singer     | Meera     |    0 |

And then you can rotate row and column by this query

SELECT 
rank,
CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END AS Doctor,
CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END AS Professor,
CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END AS Singer,
CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END AS Actor
FROM (
  SELECT a.Occupation,
         a.Name,
         (SELECT COUNT(*) 
            FROM Occupations AS b
            WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rank
  FROM Occupations AS a
) AS c

+------+----------+-----------+--------+-------+
| rank | Doctor   | Professor | Singer | Actor |
+------+----------+-----------+--------+-------+
|    1 | Samantha | NULL      | NULL   | NULL  |
|    1 | NULL     | NULL      | NULL   | Julia |
|    2 | NULL     | NULL      | NULL   | Maria |
|    0 | NULL     | NULL      | Meera  | NULL  |
|    0 | NULL     | Ashely    | NULL   | NULL  |

Doctor and other occupations columns contain only a single value for each ranks, 
so you can reduce null value by MAX or MIN aggregate function with group by rank value.

SELECT 
rank,
MAX(CASE WHEN Occupation = 'Doctor' THEN Name ELSE NULL END) AS Doctor,
MAX(CASE WHEN Occupation = 'Professor' THEN Name ELSE NULL END) AS Professor,
MAX(CASE WHEN Occupation = 'Singer' THEN Name ELSE NULL END) AS Singer,
MAX(CASE WHEN Occupation = 'Actor' THEN Name ELSE NULL END) AS Actor
FROM (
  SELECT a.Occupation,
         a.Name,
         (SELECT COUNT(*) 
            FROM Occupations AS b
            WHERE a.Occupation = b.Occupation AND a.Name > b.Name) AS rank
  FROM Occupations AS a
) AS c
GROUP BY c.rank;

+------+----------+-----------+--------+-------+
| rank | Doctor   | Professor | Singer | Actor |
+------+----------+-----------+--------+-------+
|    0 | Jenny    | Ashely    | Meera  | Jane  |
|    1 | Samantha | Christeen | Priya  | Julia |
|    2 | NULL     | Ketty     | NULL   | Maria |
+------+----------+-----------+--------+-------+

