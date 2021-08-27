SET @cnt = (SELECT COUNT(DISTINCT step_id)
            FROM step_student);

WITH count_step_student (student_id, Прогресс) 
    AS (SELECT student_id, ROUND(COUNT(DISTINCT step_id) / @cnt * 100)
        FROM step_student
        WHERE result = "correct"
        GROUP BY student_id)
SELECT student_name AS Студент, Прогресс,
       CASE
           WHEN Прогресс = 100 THEN "Сертификат с отличием"
           WHEN Прогресс > 79 THEN "Сертификат"
           ELSE ""
       END AS Результат 
FROM count_step_student
     INNER JOIN student USING(student_id)
ORDER BY Прогресс DESC, Студент;
