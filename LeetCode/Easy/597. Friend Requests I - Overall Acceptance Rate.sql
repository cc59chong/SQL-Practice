/* ****597. Friend Requests I: Overall Acceptance Rate*******/
/*In social network like Facebook or Twitter, people send friend requests and accept others’ requests as well. Now given two tables as below:
 Table: friend_request
| sender_id | send_to_id |request_date|
|-----------|------------|------------|
| 1         | 2          | 2016_06-01 |
| 1         | 3          | 2016_06-01 |
| 1         | 4          | 2016_06-01 |
| 2         | 3          | 2016_06-02 |
| 3         | 4          | 2016-06-09 |
 Table: request_accepted
| requester_id | accepter_id |accept_date |
|--------------|-------------|------------|
| 1            | 2           | 2016_06-03 |
| 1            | 3           | 2016-06-08 |
| 2            | 3           | 2016-06-08 |
| 3            | 4           | 2016-06-09 |
| 3            | 4           | 2016-06-10 |
 
Write a query to find the overall acceptance rate of requests rounded to 2 decimals, which is the number of acceptance divide the number of requests.
 For the sample data above, your query should return the following result.
 
|accept_rate|
|-----------|
|       0.80|
 

Note:
The accepted requests are not necessarily from the table friend_request. In this case, you just need to simply count the total accepted requests
 (no matter whether they are in the original requests), and divide it by the number of requests to get the acceptance rate.
It is possible that a sender sends multiple requests to the same receiver, and a request could be accepted more than once. 
In this case, the ‘duplicated’ requests or acceptances are only counted once.
If there is no requests at all, you should return 0.00 as the accept_rate.
 
Explanation: There are 4 unique accepted requests, and there are 5 requests in total. So the rate is 0.80.
 Follow-up:
Can you write a query to return the accept rate but for every month?
How about the cumulative accept rate for every day? */

select coalesce(round(count(distinct requester_id, accepter_id)/count(distinct sender_id, send_to_id),2),0) as accept_rate
from friend_request, request_accepted;
/*The COALESCE() function returns the first non-null value in a list.*/
/* https://www.w3schools.com/sql/func_mysql_coalesce.asp */

select ifnull(round(count(distinct requester_id, accepter_id)/count(distinct sender_id, send_to_id),2),0) as accept_rate
from friend_request, request_accepted;


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

/*----------------------------------------------------------------------------------------------------------------*/
/*
# Follow-up 1: return the accept rate for every month*/
select ifnull(round(count(distinct requester_id, accepter_id)/count(distinct sender_id, send_to_id),2),0) as accept_rate, month(accept_date) as month
from friend_request, request_accepted
where month(request_date) = month(accept_date)
group by month(accept_date)

select
round(
    ifnull(
    (select count(distinct requester_id, accepter_id) from request_accepted as A)
    /
    (select count(distinct sender_id, send_to_id) from friend_request as B),
    0)
, 2) as accept_rate, month(accept_date) as month
from friend_request, request_accepted
where month(request_date) = month(accept_date)
group by month(accept_date);


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
SELECT IFNULL(round(acp.acp / req.req, 2)，0.00)
SELECT coalesce(round(acp.acp / req.req, 2),0.00)
/*----------------------------------------------------------------------------------------------------------------*/
/*# Follow-up 2: return the cumulative accept rate for every day*/
select round(count(distinct requester_id, accepter_id)/count(distinct sender_id, send_to_id),2) as accept_rate, date_table.dates
from friend_request, request_accepted,
     (select request_date as dates from friend_request 
      union 
      select accept_date from request_accepted order by dates) as date_table
where accept_date <= date_table.dates AND request_date <= date_table.dates
group by date_table.dates;


/*# Without null check*/
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
