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
group by id;

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
group by id;


/* 可以不用写else null end*/

/*
Why use max?

Because, without aggregation, for each department id's revenue, 
there exists as many rows as there are values for months for that department
for example column names : ['id','jan_revenue','feb_revenue','mar_revenue',......]
 and values: [1,9000,null,null,....], [1,null,8000,null,.....],[2,null,null,7000,....],[2,6000,null,null,....], [2,null,5000,null,.....],[2,null,null,5000,....]

So we need some form of aggregation to bring all months values for a department in a single row, 
since there is only one value for a month for a department, we can use aggregation like min or max, 
anything works, but you need to use aggregation. Basically, we need one row for each id not multiple rows, 
which is achieved using aggregation
*/
