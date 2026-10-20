# SQL CRUD

Practice using SQLite to manage and query a book inventory database.

## Topics Covered

- Retrieving data with SELECT
- Filtering rows with WHERE, AND and OR
- Sorting results with ORDER BY
- Limiting results with LIMIT
- Updating prices and stock with UPDATE
- Deleting rows with DELETE
- Summarising data with COUNT, SUM, AVG, MIN and MAX
- Grouping results with GROUP BY

## Database

The books table contains:

- id
- title
- author
- genre
- price
- stock
- published_year

## Usage

Open the database from the sql_crud directory:

    sqlite3 books_dataset.db

Run a SQL file from the terminal:

    sqlite3 books_dataset.db < 10-select_tech_books.sql

For readable output inside SQLite:

    .headers on
    .mode box

