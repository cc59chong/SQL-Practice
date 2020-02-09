/*511. Game Play Analysis I*/
/*Write an SQL query that reports the first login date for each player.*/
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

/*512. Game Play Analysis II*/
/*Write a SQL query that reports the device that is first logged in for each player.*/
SELECT a.player_id, a.device_id
FROM Activity a
JOIN 
(SELECT player_id, MIN(event_date) minDate
 FROM Activity
 GROUP BY player_id) b
ON a.player_id = b.player_id AND a.event_date = b.minDate;

SELECT player_id, device_id
FROM Activity
WHERE (player_id, event_date) IN (SELECT player_id, MIN(event_date)
                                  FROM Activity  
                                  GROUP BY player_id);

/*577. Employee Bonus*/								  
/*Select all employee's name and bonus whose bonus is < 1000.*/								  
SELECT name, bonus
FROM Employee
LEFT JOIN Bonus
ON Employee.empId = Bonus.empId
WHERE bonus < 1000 OR bonus is NULL;

/*584. Find Customer Referee*/
/*Write a query to return the list of customers NOT referred by the person with id '2'.*/
select name from customer
where referee_id <> 2
or referee_id is null;

SELECT name
FROM customer 
WHERE id NOT IN (SELECT id FROM customer WHERE referee_id = 2);

/*586. Customer Placing the Largest Number of Orders*/
/*Query the customer_number from the orders table for the customer who has placed the largest number of orders.
It is guaranteed that exactly one customer will have placed more orders than any other customer.*/
SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1;
      
select customer_number from orders 
group by customer_number
having count(customer_number) >= all 
(select count(customer_number) from orders group by customer_number);

/*595. Big Countries*/
/*A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.
Write a SQL solution to output big countries' name, population and area.*/
select name, population, area
from World
where area > 3000000 or population > 25000000;

/*596. Classes More Than 5 Students*/
/*There is a table courses with columns: student and class
Please list out all classes which have more than or equal to 5 students.*/
SELECT class 
FROM courses
GROUP BY class
Having count(DISTINCT student) >= 5;


/* ****597. Friend Requests I: Overall Acceptance Rate*******/
/*Write a query to find the overall acceptance rate of requests rounded to 2 decimals,
 which is the number of acceptance divide the number of requests.*/
select coalesce(round(count(distinct requester_id, accepter_id)/count(distinct sender_id, send_to_id),2),0) as accept_rate
from friend_request, request_accepted;
/*The COALESCE() function returns the first non-null value in a list.*/
/* https://www.w3schools.com/sql/func_mysql_coalesce.asp */
select
round(
    ifnull(
    (select count(*) from (select distinct requester_id, accepter_id from request_accepted) as A)
    /
    (select count(*) from (select distinct sender_id, send_to_id from friend_request) as B),
    0)
, 2) as accept_rate;


/*
# Follow-up 1: return the accept rate for every month*/
SELECT IF(req.req = 0, 0.00, round(acp.acp / req.req, 2)) AS accept_rate, acp.month 
FROM (SELECT COUNT(DISTINCT requester_id, accepter_id) AS acp, Month(accept_date) AS month FROM request_accepted) acp, 
    (SELECT COUNT(DISTINCT sender_id, send_to_id) AS req, Month(request_date) AS month FROM friend_request) req 
WHERE acp.month = req.month 
GROUP BY acp.month
/* Result
{
    "headers": ["accept_rate", "month"], 
    "values": [[0.80, 6]]
}
*/

/*# Follow-up 2: return the cumulative accept rate for every day
# Without null check*/
SELECT ROUND(
    COUNT(DISTINCT requester_id, accepter_id) / COUNT(DISTINCT sender_id, send_to_id), 2
) AS rate, date_table.dates
FROM request_accepted acp, friend_request req, 
(SELECT request_date AS dates FROM friend_request
UNION
SELECT accept_date FROM request_accepted
ORDER BY dates) as date_table
WHERE acp.accept_date <= date_table.dates
AND req.request_date <= date_table.dates
GROUP BY date_table.dates
/* Result
{
    "headers": ["rate", "dates"], 
    "values": [[0.25, "2016-06-03"], [0.75, "2016-06-08"], [0.80, "2016-06-09"], [0.80, "2016-06-10"]]
}
*/
