WITH rate_student (md, st, rt) 
AS (SELECT module_id, student_name, COUNT(DISTINCT step_id)
    FROM lesson
         INNER JOIN step USING(lesson_id)
         INNER JOIN step_student USING(step_id)
         INNER JOIN student USING(student_id)
    WHERE result = "correct"
    GROUP BY module_id, student_id)
SELECT md AS Модуль,
       st AS Студент,
       rt AS Пройдено_шагов,
       ROUND(rt / MAX(rt) OVER (PARTITION BY md) * 100, 1) AS  Относительный_рейтинг  
FROM rate_student
ORDER BY Модуль, Относительный_рейтинг DESC, Студент;
