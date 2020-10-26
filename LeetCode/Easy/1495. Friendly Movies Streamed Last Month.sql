SELECT DISTINCT title
FROM Content
WHERE Kids_content = 'Y'
      AND content_type = 'Movies'
      AND content_id IN (SELECT content_id
                         FROM TVProgram
                         WHERE YEAR(program_date) = '2020' AND MONTH(program_date) = 6);