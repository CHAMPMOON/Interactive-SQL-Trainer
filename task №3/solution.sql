SELECT CONCAT(module_id, ".", lesson_position, ".", 
              IF(step_position < 10, CONCAT("0", step_position), step_position), 
              " ", step_name) AS Шаг
FROM module
     INNER JOIN lesson USING(module_id)
     INNER JOIN step USING(lesson_id)
     INNER JOIN step_keyword USING(step_id)
     INNER JOIN keyword USING(keyword_id)
WHERE keyword_name IN ("MAX", "AVG")
GROUP BY Шаг
HAVING COUNT(*) = 2
ORDER BY Шаг;
