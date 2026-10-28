# SQL Joins and Subqueries

Practice SQL relationships, joins, aggregation, and subqueries using SQLite.

## Topics

- One-to-many and many-to-many relationships
- Foreign keys and junction tables
- `INNER JOIN` and `LEFT JOIN`
- `COUNT()`, `GROUP BY`, and `HAVING`
- Subqueries with `IN` and `AVG()`

## Files

- **Tasks 1–7:** Books, authors, students, courses, and enrollments using `library.db`.
- **Tasks 8–15:** Instructors, students, courses, registrations, and assignments using `academy.db`.

Each `.sql` file contains one read-only query.

## Usage

Run queries from this directory with SQLite 3:

```bash
sqlite3 library.db < 3-students-and-courses.sql
sqlite3 academy.db < 8-courses-and-instructors.sql
```
