SELECT question_id as survey_log
FROM
(
    SELECT question_id,
        SUM(case when action="answer" THEN 1 ELSE 0 END) as num_answer,
        SUM(case when action="show" THEN 1 ELSE 0 END) as num_show
    FROM survey_log
    GROUP BY question_id
) as tbl
ORDER BY (num_answer / num_show) DESC
LIMIT 1


/*-----------------------------------------------------------------------------*/
SELECT
    question_id AS 'survey_log'
FROM
    survey_log
GROUP BY question_id
ORDER BY COUNT(answer_id) / SUM(IF(action = 'show', 1, 0)) DESC
LIMIT 1;