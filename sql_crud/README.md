# SQL - CRUD

This project practises creating, reading, updating, and deleting a book
inventory in SQLite. The 33 task files also cover filtering, sorting, limiting,
aggregate functions, and grouped results.

## General requirements

- Correction environment: Ubuntu 20.04 with the SQLite 3.x CLI.
- Each task must be written in a `.sql` file.
- Each task must contain one SQL query only, unless the task states otherwise.
- Run task files with input redirection: `sqlite3 DATABASE < TASK.sql`.

Each checked-in task contains a single SQL statement. A multi-row insert is
still one statement; the setup files are run separately.

## Databases and table

| File | What it contains |
| --- | --- |
| [`books_dataset.db`](books_dataset.db) | The larger book inventory used for query and mutation exercises; inspected with 119 rows |
| [`my_database.db`](my_database.db) | A smaller inventory containing the five books from the insertion exercise |

Both databases contain a `books` table:

| Column | Definition |
| --- | --- |
| `id` | `INTEGER PRIMARY KEY` |
| `title` | `TEXT NOT NULL` |
| `author` | `TEXT NOT NULL` |
| `genre` | `TEXT NOT NULL` |
| `price` | `REAL NOT NULL` |
| `stock` | `INTEGER NOT NULL` |
| `published_year` | `INTEGER NOT NULL` |

Row counts describe the checked-in snapshots, not fixed results after updates
or deletions. Prices and stock have no additional non-negative check constraints.

## Task files

| File | What it does |
| --- | --- |
| [`0-create_table.sql`](0-create_table.sql) | Creates the `books` table |
| [`1-insert_data.sql`](1-insert_data.sql) | Inserts five books with explicit IDs `1` through `5` |
| [`2-select_all.sql`](2-select_all.sql) | Selects every column and row |
| [`3-select_columns.sql`](3-select_columns.sql) | Selects title and price |
| [`4-filter_by_genre.sql`](4-filter_by_genre.sql) | Selects title and author for Tech books |
| [`4-filter_by_price.sql`](4-filter_by_price.sql) | Selects titles and prices above `20` |
| [`4-filter_with_and.sql`](4-filter_with_and.sql) | Selects Tech books priced above `30` |
| [`4-filter_with_or.sql`](4-filter_with_or.sql) | Selects Fantasy books or books priced below `10` |
| [`5-update_by_condition.sql`](5-update_by_condition.sql) | Adds `5` to stock for books published before `2000` |
| [`5-update_by_id.sql`](5-update_by_id.sql) | Sets the price of book ID `3` to `35.00` |
| [`5-update_with_and.sql`](5-update_with_and.sql) | Reduces Tech prices by 10% where stock exceeds `5` |
| [`6-delete_by_condition.sql`](6-delete_by_condition.sql) | Deletes books with zero stock |
| [`6-delete_by_id.sql`](6-delete_by_id.sql) | Deletes book ID `8` |
| [`6-delete_with_and.sql`](6-delete_with_and.sql) | Deletes books published before `1950` with prices below `9` |
| [`7-limit_results.sql`](7-limit_results.sql) | Selects the three lowest-priced titles and prices |
| [`7-order_and_limit.sql`](7-order_and_limit.sql) | Selects up to five titles with the highest stock |
| [`7-order_by_price_asc.sql`](7-order_by_price_asc.sql) | Lists titles and prices in ascending price order |
| [`7-order_by_year_desc.sql`](7-order_by_year_desc.sql) | Lists titles and publication years, newest first |
| [`8-average_price.sql`](8-average_price.sql) | Calculates the overall average price |
| [`8-count_books.sql`](8-count_books.sql) | Counts books as `total_books` |
| [`8-max_stock.sql`](8-max_stock.sql) | Finds the highest stock value |
| [`8-min_price.sql`](8-min_price.sql) | Finds the lowest price as `Lowest_price` |
| [`8-total_stock.sql`](8-total_stock.sql) | Sums stock as `total_stock` |
| [`9-average_price_by_genre.sql`](9-average_price_by_genre.sql) | Calculates average price per genre |
| [`9-count_by_author.sql`](9-count_by_author.sql) | Counts books per author as `total_author` |
| [`9-count_by_genre.sql`](9-count_by_genre.sql) | Counts books per genre as `total_genre` |
| [`9-total_stock_by_genre.sql`](9-total_stock_by_genre.sql) | Sums stock per genre |
| [`10-average_price_by_genre.sql`](10-average_price_by_genre.sql) | Calculates average price per genre with the alias `avg` |
| [`10-cheapest_available.sql`](10-cheapest_available.sql) | Selects the four lowest-priced titles and prices; does not filter stock |
| [`10-delete_zero_stock.sql`](10-delete_zero_stock.sql) | Deletes zero-stock books |
| [`10-increase_stock.sql`](10-increase_stock.sql) | Adds `3` to stock where stock is below `5` |
| [`10-select_tech_books.sql`](10-select_tech_books.sql) | Selects title, price, and stock for Tech books published from `2000` onward |
| [`10-stock_by_genre.sql`](10-stock_by_genre.sql) | Sums stock per genre |

## Usage

From the repository root, run a read-only query on the supplied dataset:

```bash
cd sql_crud
sqlite3 books_dataset.db < 10-select_tech_books.sql
```

For a fresh five-book example, choose a new database filename:

```bash
sqlite3 practice_books.db < 0-create_table.sql
sqlite3 practice_books.db < 1-insert_data.sql
sqlite3 practice_books.db < 10-select_tech_books.sql
```

The final command prints:

```text
Clean Code|32.5|7
```

SQLite's default CLI output separates columns with `|` and omits headers.
The stored numeric value does not preserve the original `32.50` formatting.

For mutation exercises on the larger dataset, copy it first:

```bash
cp books_dataset.db practice_inventory.db
sqlite3 practice_inventory.db < 10-increase_stock.sql
```

Updates and deletes normally print no rows. Inspect results with a separate
query rather than adding another statement to the task file.

## Checks and behavior

- All 33 files were accepted as one SQL statement and executed successfully
  with local SQLite CLI 3.46.1 on disposable databases. The four original
  database files in the repository were unchanged by verification.
- The fresh-database example output above was verified. This was a local
  SQLite 3.x check, not a correction run on Ubuntu 20.04.
- Table creation has no `IF NOT EXISTS` clause. Repeating it on an existing
  table fails; repeating the insert can conflict with its explicit primary keys.
- Update and delete results depend on the database's current state. Repeating
  an increment or percentage discount can change values again.
- Queries without `ORDER BY` have no guaranteed row order. Sorting by price
  or stock alone also leaves ties without a secondary ordering rule.
- Despite its filename, `10-cheapest_available.sql` can include zero-stock
  books. It currently finds the cheapest rows, not only available inventory.
- Use existing input paths carefully: SQLite can create a new empty database
  when a filename is misspelled, after which table queries will fail.

## Clean up

Remove only the practice databases created above when finished:

```bash
rm -f practice_books.db practice_inventory.db
```
