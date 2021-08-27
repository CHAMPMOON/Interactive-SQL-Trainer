SET @avg_time := (SELECT AVG(submission_time - attempt_time)
                  FROM step_student
                  WHERE submission_time - attempt_time <= 3600 AND
                  student_id = 59);

WITH help_table (Шаг, Время_попытки, Студент, Номер_попытки, Результат, step_id, attempt_time)
AS (SELECT CONCAT(module_id, ".", lesson_position, ".", step_position),
           IF(submission_time - attempt_time <= 60*60, 
              submission_time - attempt_time,
              @avg_time),
              student_name,
              DENSE_RANK() OVER (PARTITION BY module_id, lesson_position, step_position 
                          ORDER BY step_id, attempt_time),
              result,
              step_id, attempt_time
    FROM lesson
         INNER JOIN step USING(lesson_id)
         INNER JOIN step_student USING(step_id)
         INNER JOIN student USING(student_id)
    WHERE student_name = "student_59")
SELECT Студент, Шаг, Номер_попытки, Результат, SEC_TO_TIME(ROUND(Время_попытки)) AS Время_попытки,
       ROUND(Время_попытки / SUM(Время_попытки) OVER(PARTITION BY Шаг) * 100, 2) AS Относительное_время
FROM help_table
ORDER BY step_id, attempt_time;
