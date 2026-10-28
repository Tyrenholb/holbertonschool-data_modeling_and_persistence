SELECT courses.title AS course_title
FROM courses
LEFT JOIN enrollments
    ON courses.id = enrollments.course_id
GROUP BY courses.id, courses.title
HAVING COUNT(enrollments.student_id) > (
    SELECT AVG(enrollment_count)
    FROM (
        SELECT COUNT(enrollments.student_id) AS enrollment_count
        FROM courses
        LEFT JOIN enrollments
            ON courses.id = enrollments.course_id
        GROUP BY courses.id
    ) AS course_counts
)
ORDER BY course_title ASC;
