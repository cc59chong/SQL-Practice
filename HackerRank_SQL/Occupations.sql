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

set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(
  select 
    case when Occupation='Doctor' then (@r1:=@r1+1)
         when Occupation='Professor' then (@r2:=@r2+1)
         when Occupation='Singer' then (@r3:=@r3+1)
         when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
  from OCCUPATIONS
  order by Name
) Temp
group by RowNumber

/*
Let me break it down in steps (answer in MySQL)
Step 1:
Create a virtual table in your head of the data given to us. It look like this https://imgur.com/u6DEcNQ
*/
SELECT
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
FROM OCCUPATIONS
/*
Step 2:
Create an index column with respect to occupation as "RowNumber".https://imgur.com/QzVCWFn

Notice from the image, under professor column, the first Name is indexed as 1, the next name "Birtney" as 2. That is what I mean by index w.r.t occupation.

The below code will only give the "RowNumber" column, to get the result like in image proceed to step 3.
*/
set @r1=0, @r2=0, @r3=0, @r4=0;

SELECT 
    case when Occupation='Doctor' then (@r1:=@r1+1)
         when Occupation='Professor' then (@r2:=@r2+1)
         when Occupation='Singer' then (@r3:=@r3+1)
         when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber
FROM OCCUPATIONS
/*
Step 3:
Combine the result from step 1 and step 2:
*/
set @r1=0, @r2=0, @r3=0, @r4=0;

SELECT 
    case when Occupation='Doctor' then (@r1:=@r1+1)
         when Occupation='Professor' then (@r2:=@r2+1)
         when Occupation='Singer' then (@r3:=@r3+1)
         when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
    case when Occupation='Doctor' then Name end as Doctor,
    case when Occupation='Professor' then Name end as Professor,
    case when Occupation='Singer' then Name end as Singer,
    case when Occupation='Actor' then Name end as Actor
FROM OCCUPATIONS
/*
Step 4:
Now, Order_by name then Group_By RowNumber.

Using Min/Max, if there is a name, it will return it, if not, return NULL.
*/
set @r1=0, @r2=0, @r3=0, @r4=0;
select min(Doctor), min(Professor), min(Singer), min(Actor)
from(select 
        case when Occupation='Doctor' then (@r1:=@r1+1)
             when Occupation='Professor' then (@r2:=@r2+1)
             when Occupation='Singer' then (@r3:=@r3+1)
             when Occupation='Actor' then (@r4:=@r4+1) end as RowNumber,
        case when Occupation='Doctor' then Name end as Doctor,
        case when Occupation='Professor' then Name end as Professor,
        case when Occupation='Singer' then Name end as Singer,
        case when Occupation='Actor' then Name end as Actor
    from OCCUPATIONS
    order by Name
	) temp
group by RowNumber;
/*
**EDIT** I can see many asking why MIN or temp?

temp - Since I created a temporary table inside the query, I have to give it an alise. It is a good practise.

Why MIN in the select statement? Since some of us here may not be fimilar with sql, I'll start with where I left so you get the whole picture.

Once you complete step 3, add "ORDER BY Name" (Refer above code on where to add Order by clause). The result will look like this https://imgur.com/aBHUqN6
What changed? the names in all four columns are sorted as per alphabetical order.

Now, we only want the names and not the NULL values from our virtual table. How can we do that? - There maybe be multiple ways, lets us consider the MIN/MAX (Yes, you can replace MIN with MAX and you will get the same result)

Without GROUP BY clause - When a MIN/MAX is used in a Select statement, it will return The "LOWEST" element from each column (which happened to be the first element because we used ORDER BY, if you use MAX, you will get the last element from each column). It will look like this https://imgur.com/XDZzc4Z That means, you will always get a single row from a table.
*/
SET @r1=0,@r2=0,@r3=0,@r4=0;
SELECT MIN(Doctor),MIN(Professor),MIN(Singer),MIN(Actor)
FROM (SELECT 
        CASE WHEN OCCUPATION = 'Doctor' THEN (@r1:=@r1+1)
              WHEN OCCUPATION = 'Professor' THEN (@r2:=@r2+1)
              WHEN OCCUPATION = 'Singer' THEN (@r3:=@r3+1)
              WHEN OCCUPATION = 'Actor' THEN (@r4:=@r4+1) END AS RowNumber,
        CASE WHEN OCCUPATION = 'Doctor' THEN Name END AS Doctor,
        CASE WHEN OCCUPATION = 'Professor' THEN Name END AS Professor,
        CASE WHEN OCCUPATION = 'Singer' THEN Name END AS Singer,
        CASE WHEN OCCUPATION = 'Actor' THEN Name END AS Actor
      FROM OCCUPATIONS
      ORDER BY Name) as temp
/*	  
4.With GROUP BY clause - The result set will have one row for EACH group (which is RowNumber in our case).
*/
