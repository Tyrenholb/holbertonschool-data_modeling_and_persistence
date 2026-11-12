# SQL - Joins and Subqueries

Fifteen read-only SQLite queries practise relationships between tables,
matching and unmatched rows, junction tables, grouped counts, and subqueries.
The tasks use two databases with different course-related schemas.

## General requirements

- Correction environment: Ubuntu 20.04 with the SQLite 3.x CLI.
- Each task must be written in a `.sql` file.
- Each task must contain one SQL query only, unless the task states otherwise.
- Run task files with input redirection: `sqlite3 DATABASE < TASK.sql`.

Every checked-in file contains one `SELECT` statement. Subqueries are part of
that statement, not additional standalone queries.

## Databases and relationships

| Database | Tasks | Tables and relationships |
| --- | --- | --- |
| [`library.db`](library.db) | `1` through `7` | Authors have books through `books.author_id`. Students and courses are connected by the `enrollments` junction table. |
| [`academy.db`](academy.db) | `8` through `15` | Courses refer to instructors. Students and courses are connected by `registrations`; assignments refer to courses. |

Both junction tables use a composite primary key of `student_id` and
`course_id`. The supplied schemas declare foreign keys for their relationships.
SQLite foreign-key enforcement is connection-specific; declaring a foreign key
alone does not establish that it is enabled for later write operations.

The book table here uses an `author_id` relationship and differs from the flat
inventory table in `sql_crud`. The two databases also have different student
and course definitions, so select the correct database for each task.

## Task files

| File | What it does |
| --- | --- |
| [`1-books-with-authors.sql`](1-books-with-authors.sql) | Inner-joins books to authors and orders by book title |
| [`2-authors-with-books.sql`](2-authors-with-books.sql) | Keeps every author with a left join, including authors without books; orders by author name then book title |
| [`3-students-and-courses.sql`](3-students-and-courses.sql) | Lists student/course enrollment pairs, ordered by student and course names |
| [`4-courses-and-students.sql`](4-courses-and-students.sql) | Keeps every course, including courses without enrollments, and lists matching students |
| [`5-students-with-enrollments.sql`](5-students-with-enrollments.sql) | Uses an `IN` subquery to find students with at least one enrollment |
| [`6-courses-above-average.sql`](6-courses-above-average.sql) | Finds courses whose enrollment count exceeds the average across course groups present in `enrollments` |
| [`7-course-enrollment-count.sql`](7-course-enrollment-count.sql) | Counts enrollments for every course, including zero; orders by count descending then title |
| [`8-courses-and-instructors.sql`](8-courses-and-instructors.sql) | Inner-joins courses to their instructors, ordered by course title |
| [`9-instructors-and-courses.sql`](9-instructors-and-courses.sql) | Keeps every instructor with a left join, including those without courses |
| [`10-students-and-registered-courses.sql`](10-students-and-registered-courses.sql) | Lists student/course registration pairs, ordered by student and course names |
| [`11-course-registration-count.sql`](11-course-registration-count.sql) | Counts registrations for every course, including zero; orders by count descending then title |
| [`12-students-with-registrations.sql`](12-students-with-registrations.sql) | Uses an `IN` subquery to find students with at least one registration |
| [`13-courses-above-average-assignments.sql`](13-courses-above-average-assignments.sql) | Finds courses above the average assignment count, including zero-assignment courses in that average |
| [`14-courses-and-assignments.sql`](14-courses-and-assignments.sql) | Keeps every course and lists its assignments, ordered by course and assignment titles |
| [`15-instructors-with-active-courses.sql`](15-instructors-with-active-courses.sql) | Finds instructors with at least one course that has a registration; orders instructor names alphabetically |

## Usage

From the repository root:

```bash
cd sql_join
sqlite3 library.db < 3-students-and-courses.sql
sqlite3 library.db < 7-course-enrollment-count.sql
sqlite3 academy.db < 8-courses-and-instructors.sql
sqlite3 academy.db < 13-courses-above-average-assignments.sql
```

The queries print values in selected-column order, separated by `|`, with no
headers in the default SQLite CLI mode. Actual names and counts come from
the chosen database. Unmatched right-side values from left joins are SQL
`NULL`, which the default CLI displays as empty fields.

For human-readable inspection, request headers and columns through CLI options:

```bash
sqlite3 -header -column academy.db < 11-course-registration-count.sql
```

Display options change the output format. Use the expected correction format
when submitting, and keep CLI settings outside the one-query task files.

## Understanding the queries

- An inner join returns matching rows. A left join also retains unmatched rows
  from its left-hand table.
- Count queries use `COUNT` on a joined identifier, rather than `COUNT(*)`,
  so an unmatched left-join row contributes zero instead of one.
- The student and instructor `IN` queries return each qualifying outer row
  once even if several related rows match.
- Task 6 averages the course groups found in `enrollments`; courses with no
  enrollments are excluded from that average. Task 13 instead starts from all
  courses with a left join, so zero-assignment courses are included.
- Task 15 uses registration existence as its definition of an active course.
  It does not filter an explicit course-status field.
- Ordering follows each query's `ORDER BY`. Identical sort-key values may still
  have no defined relative order.

## Verification

All 15 files were accepted as single SQL statements and executed successfully
with local SQLite CLI 3.46.1 against temporary copies of the corresponding
database. The original database files were unchanged. This verifies local
execution, not a full Ubuntu 20.04 correction run or an independent assessment
against task instructions that are not included in the repository.
