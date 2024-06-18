SELECT a.sub_id AS post_id, COUNT(DISTINCT b.sub_id) AS number_of_comments
FROM Submissions a
LEFT JOIN Submissions b ON a.sub_id = b.parent_id
WHERE a.parent_id IS NULL
GROUP BY a.sub_id
ORDER BY post_id;

/*
SELECT *
FROM Submissions a
LEFT JOIN Submissions b ON a.sub_id = b.parent_id
WHERE a.parent_id IS NULL

| sub_id | parent_id | sub_id | parent_id |
| ------ | --------- | ------ | --------- |
| 1      | null      | 9      | 1         |
| 1      | null      | 4      | 1         |
| 1      | null      | 3      | 1         |
| 1      | null      | 3      | 1         |
| 2      | null      | 10     | 2         |
| 2      | null      | 5      | 2         |
| 1      | null      | 9      | 1         |
| 1      | null      | 4      | 1         |
| 1      | null      | 3      | 1         |
| 1      | null      | 3      | 1         |
| 12     | null      | null   | null      |

*/
