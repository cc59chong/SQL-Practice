SELECT a.product_id, p.product_name, a.report_year, a.total_amount
FROM
   (SELECT product_id, '2018' AS report_year,
           average_daily_sales * (DATEDIFF(LEAST(period_end, '2018-12-31'), GREATEST(period_start, '2018-01-01'))+1) AS total_amount
    FROM Sales
    WHERE YEAR(period_start) = 2018 OR YEAR(period_end) = 2018
   UNION
    SELECT product_id, '2019' AS report_year,
        average_daily_sales * (DATEDIFF(LEAST(period_end, '2019-12-31'), GREATEST(period_start, '2019-01-01'))+1) AS total_amount
    FROM Sales
    WHERE YEAR(period_start) <= 2019 AND YEAR(period_end) >= 2019
   UNION
    SELECT product_id, '2020' AS report_year,
        average_daily_sales * (DATEDIFF(LEAST(period_end, '2020-12-31'), GREATEST(period_start, '2020-01-01'))+1) AS total_amount
    FROM Sales
    WHERE YEAR(period_start) = 2020 OR YEAR(period_end) = 2020) a
JOIN Product p ON a.product_id = p.product_id
ORDER BY a.product_id, a.report_year;