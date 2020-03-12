/*-----1378. Replace Employee ID With The Unique Identifier-----*/
/*Write an SQL query to show the unique ID of each user, 
If a user doesn't have a unique ID replace just show null.
Return the result table in any order.*/
select eu.unique_id, e.name
from Employees e
left join EmployeeUNI eu on e.id = eu.id

/*-----1350. Students With Invalid Departments-----*/
/*Write an SQL query to find the id and the name of all students who are enrolled 
in departments that no longer exists.
Return the result table in any order.*/
select s.id, s.name 
from Students s 
left join Departments d on s.department_id = d.id
where d.id is null;

/*-----1068. Product Sales Analysis I-----*/
/*Write an SQL query that reports all product names of the products in the Sales table
 along with their selling year and price.*/
SELECT product_name, year, price
FROM Sales 
LEFT JOIN Product ON Sales.product_id = Product.product_id;

/*-----1303. Find the Team Size-----*/
/*Write an SQL query to find the team size of each of the employees.
  Return result table in any order.*/
select a.employee_id, b.team_size
from Employee a
inner join 
(select team_id,count(team_id) as team_size
from Employee
group by team_id) b
on a.team_id = b.team_id;

/*the result is right, but showed "wrong answer" on leetCode*/
select a.employee_id,count(a.employee_id) as team_dize
from Employee a
left join Employee b
on a.team_id = b.team_id
group by a.employee_id;

/*-----1069. Product Sales Analysis II-----*/
/*Write an SQL query that reports the total quantity sold for every product id.*/
select p.product_id, sum(s.quantity) as total_quantity
from Product p
inner join Sales s on p.product_id = s.product_id
group by s.product_id
order by p.product_id;

/*以下答案可通过，但不严谨，题目说了“for every product id”*/
SELECT product_id, SUM(quantity) AS total_quantity
FROM Sales
GROUP BY product_id;

/*-----511. Game Play Analysis I-----*/
/*Write an SQL query that reports the first login date for each player.*/
SELECT player_id, MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;

/*-----1251. Average Selling Price-----*/
/*Write an SQL query to find the average selling price for each product.
 average_price should be rounded to 2 decimal places.*/
select p.product_id, round(sum(u.units*p.price)/sum(u.units),2) as average_price
from Prices p
join UnitsSold u on p.product_id = u.product_id
where u.purchase_date between p.start_date and p.end_date
group by p.product_id

/*-----1179. Reformat Department Table-----*/
/*Write an SQL query to reformat the table such that there is a department id column
 and a revenue column for each month.*/
select id,
sum(case when month = 'Jan' then revenue else null end) as Jan_Revenue,
sum(case when month = 'Feb' then revenue else null end) as Feb_Revenue,
sum(case when month = 'Mar' then revenue else null end) as Mar_Revenue,
sum(case when month = 'Apr' then revenue else null end) as Apr_Revenue,
sum(case when month = 'May' then revenue else null end) as May_Revenue,
sum(case when month = 'Jun' then revenue else null end) as Jun_Revenue,
sum(case when month = 'Jul' then revenue else null end) as Jul_Revenue,
sum(case when month = 'Aug' then revenue else null end) as Aug_Revenue,
sum(case when month = 'Sep' then revenue else null end) as Sep_Revenue,
sum(case when month = 'Oct' then revenue else null end) as Oct_Revenue,
sum(case when month = 'Nov' then revenue else null end) as Nov_Revenue,
sum(case when month = 'Dec' then revenue else null end) as Dec_Revenue
from department
group by id
order by id;

select id,
max(case when month = 'Jan' then revenue else null end) as Jan_Revenue,
max(case when month = 'Feb' then revenue else null end) as Feb_Revenue,
max(case when month = 'Mar' then revenue else null end) as Mar_Revenue,
max(case when month = 'Apr' then revenue else null end) as Apr_Revenue,
max(case when month = 'May' then revenue else null end) as May_Revenue,
max(case when month = 'Jun' then revenue else null end) as Jun_Revenue,
max(case when month = 'Jul' then revenue else null end) as Jul_Revenue,
max(case when month = 'Aug' then revenue else null end) as Aug_Revenue,
max(case when month = 'Sep' then revenue else null end) as Sep_Revenue,
max(case when month = 'Oct' then revenue else null end) as Oct_Revenue,
max(case when month = 'Nov' then revenue else null end) as Nov_Revenue,
max(case when month = 'Dec' then revenue else null end) as Dec_Revenue
from department
group by id
order by id;

/*-----1173. Immediate Food Delivery I-----*/
/*If the preferred delivery date of the customer is the same as the order date
 then the order is called immediate otherwise it's called scheduled.
Write an SQL query to find the percentage of immediate orders in the table,
rounded to 2 decimal places.*/
SELECT ROUND((SELECT COUNT(delivery_id) FROM Delivery 
             WHERE order_date = customer_pref_delivery_date)
             /
            (COUNT(delivery_id)) * 100, 2) AS immediate_percentage 
FROM Delivery;

/*-----595. Big Countries-----*/
/*A country is big if it has an area of bigger than 3 million square km or a population of more than 25 million.
Write a SQL solution to output big countries' name, population and area.*/
select name, population, area
from World
where area > 3000000 or population > 25000000;

/*-----613. Shortest Distance in a Line-----*/
/*Write a query to find the shortest distance between two points in these points.*/
SELECT MIN(ABS(a.x - b.x)) AS shortest
FROM point a, point b
WHERE a.x <> b.x;

SELECT
    MIN(ABS(p1.x - p2.x)) AS shortest
FROM
    point p1
        JOIN
    point p2 ON p1.x != p2.x;
	
/*-----1148. Article Views I-----*/
/*Write an SQL query to find all the authors that viewed at least one of their own articles,
 sorted in ascending order by their id.*/
SELECT DISTINCT author_id AS id
FROM Views
WHERE author_id = viewer_id
ORDER BY author_id; 

/*-----627. Swap Salary-----*/
/*Given a table salary, such as the one below, that has m=male and f=female values.
 Swap all f and m values (i.e., change all f values to m and vice versa)
 with a single update statement and no intermediate temp table.

Note that you must write a single update statement, 
DO NOT write any select statement for this problem.*/
UPDATE salary 
SET sex = IF(sex = 'm', 'f', 'm')

/*-----1327. List the Products Ordered in a Period-----*/
/*Write an SQL query to get the names of products with greater than or equal to 
100 units ordered in February 2020 and their amount.
Return result table in any order.*/
select p.product_name, a.total_unit as unit
from Products p
left join 
(select product_id, sum(unit) as total_unit
from Orders
where order_date between '2020-02-01' and '2020-02-29'
/*where month(order_date) = '02'and year(order_date) ='2020'*/
group by product_id) as a
on p.product_id = a.product_id
where total_unit >=100;

select p.product_name AS 'PRODUCT_NAME',
       sum(unit) AS 'UNIT'
from 
    Orders as o
left join 
    Products as p
ON 
    p.product_id = o.product_id
where order_date >= '2020-02-01' AND
      order_date <= '2020-02-31'
group by p.product_id
having sum(unit) >= 100

/*-----1082. Sales Analysis I-----*/
/*Write an SQL query that reports the best seller by total sales price,
 If there is a tie, report them all.*/
SELECT seller_id
FROM Sales
GROUP BY seller_id
HAVING SUM(price) >= ALL
(SELECT SUM(price) FROM Sales GROUP BY seller_id);
                    
/*
Wrong answer : 只有1
select seller_id
from Sales
where seller_id in (select max(mp) 
                   from (select sum(price) as mp
                          from Sales 
                          group by seller_id) a)
*/

/*-----1050. Actors and Directors Who Cooperated At Least Three Times-----*/
/*Write a SQL query for a report that provides the pairs (actor_id, director_id) 
where the actor have cooperated with the director at least 3 times.*/
select actor_id,director_id 
from ActorDirector
group by actor_id,director_id
having count(*) >=3

/*count（*） 可以统计所有的行数，包括为null的行
count（1） 统计的是第一个子字段的行数，为null的行数 不统计。
*/

/*-----586. Customer Placing the Largest Number of Orders-----*/
/*Query the customer_number from the orders table for the customer who has placed the largest number of orders.
It is guaranteed that exactly one customer will have placed more orders than any other customer.*/
SELECT customer_number
FROM orders
GROUP BY customer_number
ORDER BY COUNT(order_number) DESC
LIMIT 1;
/*Follow up: What if more than one customer have the largest number of orders,
 can you find all the customer_number in this case?  */  
select customer_number 
from orders 
group by customer_number
having count(customer_number) >= all 
(select count(customer_number) from orders group by customer_number);

/*-----1241. Number of Comments per Post-----*/
SELECT s1.sub_id as post_id, COUNT(distinct s2.sub_id) as number_of_comments
FROM submissions s1
LEFT JOIN submissions s2
ON s1.sub_id = s2.parent_id
WHERE s1.parent_id IS NULL
GROUP BY s1.sub_id

/*-----584. Find Customer Referee-----*/
/*Write a query to return the list of customers NOT referred by the person with id '2'.*/
select name from customer
where referee_id <> 2
or referee_id is null;

SELECT name
FROM customer 
WHERE id NOT IN (SELECT id FROM customer WHERE referee_id = 2);

/*-----1280. Students and Examinations-----*/
/*Write an SQL query to find the number of times each student attended each exam.
Order the result table by student_id and subject_name.*/
/*此题的重点在于没有attend exam要用0表示出来，以及First, CROSS JOIN，Second, LEFT JOIN*/
select s.student_id, s.student_name, su.subject_name, count(e.subject_name) as attended_exams
from (Students s, Subjects su) /*(Students stu CROSS JOIN Subjects su) */
left join Examinations e on s.student_id = e.student_id and su.subject_name = e.subject_name
group by s.student_id, su.subject_name
order by s.student_id, su.subject_name；

/* case when count(e.subject_name) is null then 0 else count(e.subject_name) end as attended_exams 

   ifnull(count(e.subject_name),0) as attended_exams
*/

/*-----1211. Queries Quality and Percentage-----*/
select query_name,
       round(sum(rating/position)/count(position),2) as quality,
       round(sum(if(rating<3,1,0))/count(rating)* 100 ,2) as poor_query_percentage
from Queries
group by query_name;

/*-----620. Not Boring Movies-----*/
/*write a SQL query to output movies with an odd numbered ID and a description that is
 not 'boring'. Order the result by rating.*/
SELECT *
FROM cinema
WHERE mod(id,2) = 1 AND description != 'boring'
ORDER BY rating DESC;

/*-----577. Employee Bonus-----*/								  
/*Select all employee's name and bonus whose bonus is < 1000.*/								  
SELECT name, bonus
FROM Employee
LEFT JOIN Bonus
ON Employee.empId = Bonus.empId
WHERE bonus < 1000 OR bonus is NULL;

/*-----610. Triangle Judgement-----*/
/*Could you help Tim by writing a query to judge whether these three sides can form a 
triangle, assuming table triangle holds the length of the three sides x, y and z.*/
SELECT x,y,z,
       CASE WHEN x + y > z AND x + z > y AND y + z > x THEN 'Yes' ELSE 'No' END AS triangle
FROM triangle; 

SELECT *, 
       IF (x + y > z AND x + z > y AND y + z > x, 'Yes','No') AS triangle
FROM triangle; 

/*-----1075. Project Employees I-----*/
/*Write an SQL query that reports the average experience years of all the employees 
for each project, rounded to 2 digits.*/
select p.project_id, round((sum(e.experience_years)/count(p.employee_id)),2) as average_years
from Project p
left join Employee e on p.employee_id = e.employee_id
group by p.project_id;

/*-----1294. Weather Type in Each Country-----*/
/*Write an SQL query to find the type of weather in each country for November 2019.
The type of weather is Cold if the average weather_state is less than or equal 15, 
Hot if the average weather_state is greater than or equal 25 and Warm otherwise.*/
select c.country_name,
       case when avg(weather_state) <= 15 then 'Cold' 
            when avg(weather_state) >= 25 then 'Hot'
            else 'Warm' end as weather_type
from Weather w
left join Countries c on w.country_id = c.country_id
where w.day between '2019-11-01' and '2019-11-30' /*month(w.day) = 11*/
group by c.country_name;

/*-----1113. Reported Posts-----*/
/*Write an SQL query that reports the number of posts reported yesterday for each report reason.
 Assume today is 2019-07-05.*/
select extra as report_reason, count(distinct(post_id)) as report_count
from Actions
where action_date = '2019-07-04' and action = 'report'
group by extra;

/*-----603. Consecutive Available Seats-----*/
SELECT DISTINCT a.seat_id 
FROM cinema a, cinema b
WHERE ABS(a.seat_id - b.seat_id) = 1 AND a.free = '1' AND b.free = '1'
ORDER BY a.seat_id;

/*-----607. Sales Person-----*/
/*Given three tables: salesperson, company, orders.
Output all the names in the table salesperson, who didn’t have sales to company 'RED'.*/
select s.name
from salesperson s
where s.sales_id not in
(select o.sales_id
from orders o 
left join company c on o.com_id = c.com_id
where c.name = 'RED');

/*-----182. Duplicate Emails-----*/
SELECT Email
FROM Person 
GROUP BY Email
HAVING COUNT(Email) > 1;

select distinct a.Email
from Person a, Person b
where a.Email = b.Email and a.Id != b.Id;

/*-----1322. Ads Performance-----*/
/*Write an SQL query to find the ctr of each Ad.
Round ctr to 2 decimal points. Order the result table by ctr in descending order 
and by ad_id in ascending order in case of a tie.*/
select ad_id,
      round(case when (sum(action='Clicked') + sum(action='Viewed'))=0
            then 0
            else sum(action='Clicked') 
                  / 
                  (sum(action='Clicked') +sum(action='Viewed'))*100
            end,2) as ctr
from Ads
group by ad_id
order by ctr DESC, ad_id ASC;  

/*-----181. Employees Earning More Than Their Managers-----*/
/*The Employee table holds all employees including their managers.
 Every employee has an Id, and there is also a column for the manager Id.*/
/*Write your MySQL query statement below*/
SELECT a.Name AS Employee
FROM Employee a, Employee b 
WHERE a.ManagerId = b.Id AND a.Salary > b.Salary;

/*-----175. Combine Two Tables-----*/
/* Write your MySQL query statement below*/
SELECT FirstName, LastName, City, State
FROM Person p
LEFT JOIN Address a on p.PersonId = a.PersonId;

/*-----1084. Sales Analysis III-----*/
/*Write an SQL query that reports the products that were only sold in spring 2019. 
That is, between 2019-01-01 and 2019-03-31 inclusive.*/
select distinct p.product_id, p.product_name 
from (select product_id 
from Sales
where sale_date between '2019-01-01' and '2019-03-31'
and product_id not in (select product_id
                       from Sales 
                       where sale_date not between '2019-01-01' and '2019-03-31')) as a
left join Product p on a.product_id = p.product_id;

select distinct p.product_id, p.product_name
from Product p
WHERE p.product_id IN (SELECT s.product_id 
                       FROM Sales s
                       where s.product_id not in (select s.product_id
                                                  from Sales s
                                                  where s.sale_date not between '2019-01-01' and '2019-03-31')
);  

SELECT product_id, product_name 
FROM Product 
WHERE product_id IN(SELECT product_id
                    FROM Sales
                    GROUP BY product_id
                    HAVING MIN(sale_date) >= '2019-01-01' AND MAX(sale_date) <= '2019-03-31');
/*运行有错
select distinct p.product_id, p.product_name
from Product p
left join Sales s on p.product_id = s.product_id
where s.product_id in (select s.product_id
                       from Sales s
                       where s.sale_date between '2019-01-01' and '2019-03-31'
                       )
      and s.product_id not in (select s.product_id
                               from Sales s
                               where s.sale_date between '2019-04-01' and '2019-12-31'
                               );     
*/

/*-----512. Game Play Analysis II-----*/
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
								  
/*-----1141. User Activity for the Past 30 Days I-----*/
/*Write an SQL query to find the daily active user count for a period of 30 days ending
 2019-07-27 inclusively. A user was active on some day if he/she made at least one activity
 on that day.*/
select activity_date as day, count(distinct user_id) as active_users from Activity
where datediff("2019-07-27", activity_date) < 30
group by activity_date ; 

select activity_date as day, count(distinct user_id) as active_users
from Activity
where activity_date between DATE_SUB('2019-07-27', INTERVAL 29 DAY) and '2019-07-27'
group by activity_date;

/*-----1076. Project Employees II-----*/
/*Write an SQL query that reports all the projects that have the most employees.*/
select project_id 
from Project
group by project_id
having count(employee_id) = (select max(n) 
                             from (select count(employee_id) as n 
                                   from Project 
                                   group by project_id) as nt)

/*-----1083. Sales Analysis II-----*/
/*Write an SQL query that reports the buyers who have bought S8 but not iPhone. 
Note that S8 and iPhone are products present in the Product table.*/
SELECT          DISTINCT buyer_id
FROM            Sales AS s
LEFT JOIN       Product AS p
ON              s.product_id = p.product_id
WHERE           p.product_name = 'S8' AND 
                buyer_id NOT IN (SELECT DISTINCT buyer_id 
                                 FROM            Sales AS s
                                 LEFT JOIN       Product AS p
                                 ON              s.product_id = p.product_id
                                 WHERE           p.product_name = 'iPhone');

/*----183. Customers Who Never Order----*/
/*Write a SQL query to find all customers who never order anything.*/
SELECT Customers.Name AS Customers
FROM Customers
LEFT JOIN Orders ON Customers.Id = Orders.CustomerId
WHERE Orders.CustomerId IS NULL;								 

/*-----619. Biggest Single Number-----*/
/*write a SQL query to find the biggest number, which only appears once*/
select max(num) as num
from my_numbers
where num in (select num 
              from my_numbers
              group by num
              having count(*) = 1);

SELECT
    MAX(num) AS num
FROM
    (SELECT
        num
    FROM
        my_numbers
    GROUP BY num
    HAVING COUNT(num) = 1) AS t;  

/*-----597. Friend Requests I: Overall Acceptance Rate-----*/
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

select
round(
    ifnull(
    (select count(distinct requester_id, accepter_id) from request_accepted as A)
    /
    (select count(distinct sender_id, send_to_id) from friend_request as B),
    0)
, 2) as accept_rate;    

SELECT IF(req.req = 0, 0.00, round(acp.acp / req.req, 2)) AS accept_rate
FROM (SELECT COUNT(DISTINCT requester_id, accepter_id) AS acp FROM request_accepted) acp, 
    (SELECT COUNT(DISTINCT sender_id, send_to_id) AS req FROM friend_request) req 
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

/*-----196. Delete Duplicate Emails-----*/
DELETE FROM Person 
WHERE Id NOT IN (SELECT MIN(a.Id) FROM (SELECT * FROM Person) a
Group by a.Email);

DELETE p1 FROM Person p1, Person p2
WHERE
    p1.Email = p2.Email AND p1.Id > p2.Id;

/*-----596. Classes More Than 5 Students-----*/
/*There is a table courses with columns: student and class
Please list out all classes which have more than or equal to 5 students.*/
SELECT class 
FROM courses
GROUP BY class
Having count(DISTINCT student) >= 5;

/*----197. Rising Temperature----*/
select b.Id
from Weather a, Weather b
where datediff(b.RecordDate, a.RecordDate) =1 and b.Temperature > a.Temperature;

/*-----1142. User Activity for the Past 30 Days II-----*/
/*Write an SQL query to find the average number of sessions per user for a period of 30 days 
ending 2019-07-27 inclusively, rounded to 2 decimal places. The sessions we want to count 
for a user are those with at least one activity in that time period.*/
select ifnull(round(count(distinct session_id)/count(distinct user_id),2),0.00) as average_sessions_per_user
from Activity
where activity_date between '2019-06-28' and '2019-07-27';

/*-----176. Second Highest Salary-----*/
/*Write a SQL query to get the second highest salary from the Employee table.
For example, given the above Employee table, the query should return 200 as the second highest salary. 
If there is no second highest salary, then the query should return null.*/
/* Write your MySQL query statement below*/
SELECT Max(Salary) AS SecondHighestSalary 
FROM Employee 
WHERE Salary NOT IN (SELECT MAX(Salary) FROM Employee);

SELECT
    (SELECT DISTINCT
            Salary
        FROM
            Employee
        ORDER BY Salary DESC
        LIMIT 1 OFFSET 1) AS SecondHighestSalary
;

SELECT
    IFNULL(
      (SELECT DISTINCT Salary
       FROM Employee
       ORDER BY Salary DESC
        LIMIT 1 OFFSET 1),
    NULL) AS SecondHighestSalary
;

