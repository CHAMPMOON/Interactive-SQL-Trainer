WITH max_time_st (st, md, lp, tm)
AS (SELECT student_id, 
           module_id, lesson_position,
           MAX(submission_time)
    FROM lesson
         INNER JOIN step USING(lesson_id)
         INNER JOIN step_student USING(step_id)
    WHERE result = "correct"
    GROUP BY student_id, module_id, lesson_position)
SELECT student_name AS Студент, 
       CONCAT(md, ".", lp) AS Урок, 
       FROM_UNIXTIME(tm) AS Макс_время_отправки,
       IF(md = 1, "-",
          CEILING((tm - LAG(tm) OVER (ORDER BY student_name, FROM_UNIXTIME(tm))) / 86400)) AS Интервал  
FROM max_time_st 
     INNER JOIN student ON max_time_st.st  = student.student_id
WHERE st IN (SELECT student_id
             FROM step 
                  INNER JOIN step_student USING(step_id)
             GROUP BY student_id
             HAVING COUNT(DISTINCT lesson_id) = 3);
