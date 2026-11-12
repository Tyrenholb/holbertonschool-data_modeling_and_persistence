# SQL - Data Modeling and Persistence

This repository contains my Holberton School projects on storing and querying
data with SQLite. The exercises start with a book inventory, then introduce
related tables, joins, junction tables, aggregate functions, and subqueries.

There are 48 SQL task files across two project folders. Each folder has a
README explaining every task, its database, and how to run it.

## Project folders

| Folder | Tasks | What it covers |
| --- | --- | --- |
| [`sql_crud`](sql_crud/README.md) | 33 | Table creation, inserts, selects, filters, updates, deletes, ordering, limits, and aggregate/grouped inventory summaries |
| [`sql_join`](sql_join/README.md) | 15 | Inner and left joins, one-to-many and many-to-many relationships, counts, `HAVING`, and subqueries |

## General requirements

- Correction environment: Ubuntu 20.04.
- Database tool: SQLite 3.x CLI.
- Each task must be written in a `.sql` file.
- Each task must contain one SQL query only, unless the task states otherwise.
- Task files are executed using input redirection:

```bash
sqlite3 DATABASE < TASK.sql
```

The existing project instructions use this execution form. Each current task
contains one SQL statement. Multi-row inserts and nested subqueries do not
require extra standalone statements.

## Included databases

| Database | Purpose |
| --- | --- |
| [`sql_crud/books_dataset.db`](sql_crud/books_dataset.db) | Larger book inventory for filters, aggregates, updates, and deletes |
| [`sql_crud/my_database.db`](sql_crud/my_database.db) | Five-book example corresponding to the create/insert exercises |
| [`sql_join/library.db`](sql_join/library.db) | Authors/books and students/courses/enrollments for join tasks `1` through `7` |
| [`sql_join/academy.db`](sql_join/academy.db) | Instructors, courses, students, registrations, and assignments for join tasks `8` through `15` |

The inventory and library databases use different book schemas. Likewise,
`library.db` and `academy.db` have different course-related schemas. Use the
database specified by the task rather than relying only on a shared table name.

## Run a query

From the repository root:

```bash
sqlite3 sql_crud/books_dataset.db < sql_crud/10-select_tech_books.sql
sqlite3 sql_join/library.db < sql_join/3-students-and-courses.sql
sqlite3 sql_join/academy.db < sql_join/8-courses-and-instructors.sql
```

SQLite's default CLI format uses `|` between columns and does not print headers.
Query results depend on the selected database and any earlier data changes.
Commands without result-producing statements, such as a successful update,
normally print no rows.

For readable inspection, headers and column layout can be requested as CLI
options:

```bash
sqlite3 -header -column sql_join/academy.db < sql_join/11-course-registration-count.sql
```

Those options change the output format. Keep display commands outside task
files and use the format expected for correction.

## Practise data changes

Use a copy for update and deletion exercises:

```bash
cp sql_crud/books_dataset.db practice_inventory.db
sqlite3 practice_inventory.db < sql_crud/10-increase_stock.sql
```

To build the five-book example from scratch, choose a new filename:

```bash
sqlite3 practice_books.db < sql_crud/0-create_table.sql
sqlite3 practice_books.db < sql_crud/1-insert_data.sql
sqlite3 practice_books.db < sql_crud/10-select_tech_books.sql
```

The final command prints:

```text
Clean Code|32.5|7
```

The create statement expects a missing table; the insert uses fixed primary
keys. Repeating setup on the same database can fail. Repeating mutations can
change the data again. A misspelled database path can also create an empty
SQLite file rather than open the intended dataset.

Remove only the practice files when finished:

```bash
rm -f practice_inventory.db practice_books.db
```

## Verification and current behavior

All 48 task files were accepted individually as one SQL statement and executed
successfully with local SQLite CLI 3.46.1 using disposable databases. The
fresh-database example output was also verified. The four checked-in database
files were unchanged by those checks.

This was local execution verification, not a correction run on Ubuntu 20.04.
Folder READMEs explain details that affect interpretation, including the missing
stock filter in `10-cheapest_available.sql`, different average calculations in
the join tasks, and ordering that is only guaranteed where specified by SQL.
