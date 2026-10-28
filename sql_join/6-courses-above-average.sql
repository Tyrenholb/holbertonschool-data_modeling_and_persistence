SELECT courses.title AS course_title
FROM courses
INNER JOIN enrollments
    ON courses.id = enrollments.course_id
GROUP BY courses.id, courses.title
HAVING COUNT(*) > (
    SELECT AVG(enrollment_count)
    FROM (
        SELECT COUNT(*) AS enrollment_count
        FROM enrollments
        GROUP BY course_id
    ) AS course_counts
)
ORDER BY course_title ASC;
