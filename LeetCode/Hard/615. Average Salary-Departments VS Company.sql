
WITH c AS 
(SELECT LEFT(s.pay_date, 7) AS month,  AVG(s.amount) AS com_avg 
 FROM salary s
 JOIN employee e ON s.employee_id = e.employee_id
 GROUP BY MONTH(s.pay_date)
 ),

d AS 
(SELECT LEFT(s.pay_date, 7) AS pay_month, e.department_id, AVG(s.amount) AS de_avg
 FROM salary s
 JOIN employee e ON s.employee_id = e.employee_id
 GROUP BY e.department_id, pay_month
 ）

SELECT d.pay_month, 
       d.department_id,
       (CASE WHEN c.com_avg > d.de_avg THEN 'lower'
             WHEN c.com_avg < d.de_avg THEN 'higher'
             ELSE 'same'
        END) AS comparison
FROM c
JOIN d ON c.month = d.pay_month


/*------------------------------------------------------------------------------*/
with t as   
   (select DISTINCT date_format(pay_date,'%Y-%m') pay_month,
        department_id,
        avg(amount) over(partition by date_format(pay_date,'%Y-%m')) com,
        avg(amount) over(partition by date_format(pay_date,'%Y-%m'),department_id) dept
    from salary s
    join employee e ON s.employee_id = e.employee_id)

select pay_month, department_id,
    case when dept>com then 'higher'
        when dept<com then 'lower'
        else 'same' end as comparison
from t
