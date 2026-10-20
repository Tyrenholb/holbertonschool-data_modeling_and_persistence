SELECT authors.name AS author_name, books.title FROM authors LEFT JOIN books ON authors.id = books.author_id ORDER BY author_name A
SC, title ASC;
