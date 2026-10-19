CREATE TABLE books (
    id INTEGER PRIMARY KEY,
    title varchar(255) NOT NULL,
    author varchar(255) NOT NULL,
    genre varchar(255) NOT NULL,
    price int NOT NULL,
    stock int NOT NULL,
    published_year int
);
