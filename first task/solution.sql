SELECT CONCAT(LEFT(CONCAT(module_id, " ", module_name), 16), "...") AS Модуль,
       CONCAT(LEFT(CONCAT(module_id, ".", lesson_position, " ", lesson_name), 16), "...") AS Урок,
       CONCAT(module_id, ".", lesson_position, ".", step_position, " ", step_name) AS Шаг
FROM module
     INNER JOIN lesson USING(module_id)
     INNER JOIN step USING(lesson_id)
WHERE step_name LIKE "%ложенн%запрос%"
ORDER BY Модуль, Урок, Шаг;
