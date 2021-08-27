SELECT "I" AS Группа,
       student_name AS Студент, 
       COUNT(step_id) AS Количество_шагов
FROM (SELECT student_name, step_id, submission_time, result,
             IF(LEAD(result) OVER(PARTITION BY student_name, step_id ORDER BY student_name, submission_time DESC) =                 "correct" AND result = "wrong", 1, 0) AS one_group
      FROM student
           INNER JOIN step_student USING(student_id)) AS query_in
GROUP BY student_name, one_group
HAVING one_group = 1
UNION
SELECT "II", student_name, COUNT(step_id)
FROM (SELECT student_name, step_id, result
      FROM student
           INNER JOIN step_student USING(student_id)
      WHERE result = "correct"
      GROUP BY student_name, step_id, result
      HAVING COUNT(result) > 1) AS query_in
GROUP BY student_name
UNION
SELECT "III", student_name, COUNT(step_id)
FROM (SELECT student_name, step_id, COUNT(result) as all_cnt
      FROM student
           INNER JOIN step_student USING(student_id)
      GROUP BY student_name, step_id) AS q_1
      INNER JOIN 
     (SELECT student_name, step_id, COUNT(result) as wrong_cnt
      FROM student
           INNER JOIN step_student USING(student_id)
      WHERE result = "wrong"
      GROUP BY student_name, step_id) AS q_2
      USING(student_name, step_id)
WHERE all_cnt = wrong_cnt
GROUP BY student_name
ORDER BY Группа, Количество_шагов DESC, Студент
