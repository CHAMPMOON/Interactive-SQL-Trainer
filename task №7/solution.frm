WITH st_ls (st, ls, tm)
    AS (SELECT student_id, lesson_id, SUM(submission_time - attempt_time)
        FROM step
             INNER JOIN step_student USING(step_id)
        WHERE (submission_time - attempt_time) / 3600 <= 4
        GROUP BY student_id, lesson_id)
SELECT ROW_NUMBER() OVER (ORDER BY ROUND(AVG(tm) / 3600, 2)) AS Номер,
       CONCAT(module_id, ".", lesson_position, " ", lesson_name) AS Урок, 
       ROUND(AVG(tm) / 3600, 2) AS Среднее_время
FROM st_ls
     INNER JOIN lesson ON st_ls.ls = lesson.lesson_id
GROUP BY ls;
