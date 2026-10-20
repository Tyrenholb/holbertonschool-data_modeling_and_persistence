SELECT genre, SUM(stock) AS total_stock FROM books GROUP BY genre;
