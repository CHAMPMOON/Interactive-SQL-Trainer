INSERT INTO step_keyword 
SELECT step_id, keyword_id
FROM step CROSS JOIN keyword
WHERE CONCAT(step_name, "  ") LIKE CONCAT("% ", keyword_name, "_ %") OR
      CONCAT(step_name, "  ") LIKE CONCAT("% ", keyword_name, " %") OR
      CONCAT(step_name, "  ") LIKE CONCAT("% ", keyword_name, "()%") 
ORDER BY keyword_id, step_id;    
 
