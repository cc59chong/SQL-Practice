SELECT session_id
FROM Playback
WHERE session_id NOT IN
(SELECT p.session_id
FROM Playback p
JOIN Ads a
ON p.customer_id = a.customer_id
WHERE a.timestamp BETWEEN p.start_time AND end_time)



SELECT session_id 
FROM Playback 
LEFT JOIN Ads 
ON Ads.timestamp BETWEEN Playback.start_time AND Playback.end_time 
AND Playback.customer_id = Ads.customer_id
WHERE ad_id IS NULL