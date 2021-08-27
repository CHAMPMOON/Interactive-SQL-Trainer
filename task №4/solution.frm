SELECT student_name AS Студент,
       CONCAT(LEFT(step_name, 20), "...") AS Шаг,
       result AS Результат,
       FROM_UNIXTIME(submission_time) AS Дата_отправки,
       SEC_TO_TIME(submission_time - LAG(submission_time, 1, submission_time) 
       OVER (ORDER BY  submission_time)) AS Разница
FROM step
     INNER JOIN step_student USING(step_id)
     INNER JOIN student USING(student_id)
WHERE student_name = "student_61";
