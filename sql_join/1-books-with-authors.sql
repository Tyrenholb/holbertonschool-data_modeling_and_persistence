SELECT books.title, authors.name
FROM books
INNER JOIN authors ON books.author_id = authors.id
ORDER BY books.title asc;
