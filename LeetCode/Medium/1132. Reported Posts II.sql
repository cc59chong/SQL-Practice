
SELECT ROUND(SUM(percent) / COUNT(DISTINCT action_date)/*AVG(percent)*/, 2) AS average_daily_percent 
FROM (SELECT a.action_date,
             COUNT(DISTINCT r.post_id) / COUNT(DISTINCT a.post_id) * 100 as percent
             FROM Actions a
      LEFT JOIN Removals r ON a.post_id = r.post_id
      WHERE a.extra = 'spam'
      GROUP BY a.action_date) temp;
	  
	  
	  
	  
/*--------------------------------------------------------------------------------*/
select ROUND(sum(daily_avg)/count(date)*100,2) as average_daily_percent
FROM (select t.action_date as date,
            (count(distinct case when remove_date is not null then post_id else null end)
             /
             count(distinct post_id)) as daily_avg
FROM (SELECT a.post_id, a.action_date, r.remove_date
      from Actions a left join Removals r on a.post_id = r.post_id
      WHERE a.extra='spam') t
GROUP BY t.action_date) t2;