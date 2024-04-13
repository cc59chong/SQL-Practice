SELECT t.request_at AS Day,
       ROUND(IFNULL(SUM(CASE WHEN t.status !='completed' THEN 1 END)
       /
       COUNT(t.status),0),2) AS 'Cancellation Rate'
FROM Trips t
LEFT JOIN Users c ON t.client_id=c.users_id
LEFT JOIN Users d ON t.driver_id=d.users_id
WHERE t.request_at BETWEEN "2013-10-01" AND "2013-10-03"
      AND c.banned='NO' AND d.banned='No'
GROUP BY t.request_at

/*adding ifnull*/


/*----------------------------------------------------------------*/
SELECT t.Request_at AS Day,
       ROUND(COUNT(CASE WHEN t.status = 'cancelled_by_driver' OR t.status = 'cancelled_by_client' THEN 1 END) 
             / 
             COUNT(t.status), 2) AS 'Cancellation Rate'
FROM Trips t
LEFT JOIN Users u1 ON u1.Users_Id = t.Client_Id 
LEFT JOIN Users u2 ON u2.Users_id = t.Driver_id
WHERE t.Request_at BETWEEN '2013-10-01' AND '2013-10-03'
      AND u1.Banned = 'No' 
      AND u2.Banned = 'No'
GROUP BY t.Request_at


/*----------------------------------------------------------------*/
SELECT
Request_at AS Day,
ROUND(SUM(CASE WHEN Status != 'completed' THEN 1 ELSE 0 END)/COUNT(*),2) AS "Cancellation Rate"
FROM Trips
WHERE Request_at BETWEEN '2013-10-01' and '2013-10-03'
AND Client_Id in (SELECT Users_id as banned_id FROM Users WHERE Banned = 'No')
AND Driver_Id in (SELECT Users_id as banned_id FROM Users WHERE Banned = 'No')
GROUP BY Request_at;

/*------------------------------------------------------------------------*/
SELECT
Request_at AS Day,
ROUND(COUNT(CASE WHEN Status != 'completed' THEN 1 END)/COUNT(*),2) AS "Cancellation Rate"
FROM Trips
WHERE Request_at BETWEEN '2013-10-01' and '2013-10-03'
      AND Client_Id IN (SELECT Users_Id FROM Users WHERE Role = "client" AND Banned = "No") 
      AND Driver_Id IN (SELECT Users_Id FROM Users WHERE Role = "driver" AND Banned = "No")
GROUP BY Request_at;
