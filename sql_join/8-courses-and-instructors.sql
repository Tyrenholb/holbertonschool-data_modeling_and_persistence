SELECT courses.title AS course_title,
       instructors.name AS instructor_name
FROM courses
INNER JOIN instructors
    ON courses.instructor_id = instructors.id
ORDER BY course_title ASC;
