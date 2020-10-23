SELECT ad_id,
       ROUND(CASE WHEN (SUM(action = 'Clicked') + SUM(action = 'Viewed')) = 0 THEN 0
                  ELSE SUM(action = 'Clicked') / (SUM(action = 'Clicked') + SUM(action = 'Viewed')) * 100 
             END,2) AS ctr
FROM Ads
GROUP BY ad_id
ORDER BY ctr DESC, ad_id ASC; 