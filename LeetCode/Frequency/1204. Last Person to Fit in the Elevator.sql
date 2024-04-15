SELECT person_name
FROM
(SELECT person_name,
       SUM(weight) OVER(ORDER BY turn) m_weight
FROM Queue) t
WHERE m_weight<=1000
ORDER BY m_weight DESC
LIMIT 1
/*------------------------------------------------------------------------*/

SELECT person_name
FROM (SELECT person_name, 
             weight,
             turn, 
             SUM(weight) over(ORDER BY turn) AS cum_sum
             FROM queue) a
WHERE cum_sum <=1000
ORDER BY turn DESC LIMIT 1;

/*------------------------------------------------------------------------*/

SELECT q1.person_name
FROM Queue q1 
JOIN Queue q2 ON q1.turn >= q2.turn
GROUP BY q1.turn
having SUM(q2.weight) <=1000
order by q1.turn desc
limit 1;


/* The join of table instance q1 and q2 is performed so that only rows where q1.turn >= q2.turn are kept. 
Then when grouping by q1.turn, each q1.turn is associated with all values of q2.turn of lesser or equal value. 
Then we can calculate cumulative weights for q1.turn using q2. 

          
{"headers": ["person_id", "person_name", "weight", "turn", "person_id", "person_name", "weight", "turn"], 
"values": [[2, "Will Johnliams", 200, 4, 5, "George Washington", 250, 1], 
           [1, "James Elephant", 500, 6, 5, "George Washington", 250, 1],
           [6, "Thomas Jefferson", 400, 3, 5, "George Washington", 250, 1], 
           [3, "John Adams", 350, 2, 5, "George Washington", 250, 1], 
           [4, "Thomas Jefferson", 175, 5, 5, "George Washington", 250, 1],
           [5, "George Washington", 250, 1, 5, "George Washington", 250, 1]]}

*/
