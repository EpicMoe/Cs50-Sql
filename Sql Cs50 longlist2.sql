--Subqueries

--Find all books published by MacLehose Press, with a nested query
SELECT "title"
FROM "books"
WHERE "publisher_id" = (SELECT "id"
                        FROM "publishers"
                        WHERE "publisher" = 'MacLehose Press');

-- Find all ratings for "In Memory of Memory"
SELECT "rating"
FROM "ratings"
WHERE "book_id" = (SELECT "id"
                   FROM "books"
                   WHERE "title" = 'In Memory of Memory');

-- Find average rating for "In Memory of Memory"
SELECT AVG("rating")
FROM "ratings"
WHERE "book_id" = (SELECT "id"
                   FROM "books"
                   WHERE "title" = 'In Memory of Memory');
--find the author of flight book
SELECT "name"
FROM "authors"
WHERE "id" = (SELECT "author_id"
              FROM "authored"
              WHERE "book_id" = (SELECT "id"
                                 FROM "books"
                                 WHERE "title" = 'Flights'));

-- Which author wrote "The Birthday Party"?
SELECT "id"
FROM "books"
WHERE "title" = 'The Birthday Party';

SELECT "author_id"
FROM "authored"
WHERE "book_id" = (SELECT "id"
                   FROM "books"
                   WHERE "title" = 'The Birthday Party');

SELECT "name"
FROM "authors"
WHERE "id" = (SELECT "author_id"
              FROM "authored"
              WHERE "book_id" = (SELECT "id"
                                 FROM "books"
                                 WHERE "title" = 'The Birthday Party'));

--IN

---- Find all books by Fernanda Melchor
SELECT "title"
FROM "books"
WHERE "id" IN (SELECT "book_id"
               FROM "authored"
               WHERE "author_id" = (SELECT "id"
                                    FROM "authors"
                                    WHERE "name" = 'Fernanda Melchor'));
--UNION

SELECT "name"
FROM "translators"
UNION
SELECT "name"
FROM "authors";

--Combine authors and translators into one result set
SELECT 'author' AS "profession", "name"
FROM "authors"
UNION
SELECT 'translator' AS "profession", "name"
FROM "translators";

--INTERSECT

--Find authors and translators
SELECT "name"
FROM "authors"
INTERSECT
SELECT "name"
FROM "translators";

-- Find books translated by Sophie Hughes
SELECT "book_id"
FROM "translated"
WHERE "translator_id" = (SELECT "id"
                         FROM "translators"
                         WHERE name = 'Sophie Hughes');

-- Find books translated by Margaret Jull Costa
SELECT "book_id"
FROM "translated"
WHERE "translator_id" = (SELECT "id"
                         FROM "translators"
                         WHERE name = 'Margaret Jull Costa');

--Find intersection of books
SELECT "book_id"
FROM "translated"
WHERE "translator_id" = (SELECT "id"
                         FROM "translators"
                         WHERE "name" = 'Sophie Hughes')
INTERSECT
SELECT "book_id"
FROM "translated"
WHERE "translator_id" = (SELECT "id"
                         FROM "translators"
                         WHERE "name" = 'Margaret Jull Costa');

--EXCEPT

--Find translators who are not authors
SELECT "name"
FROM "authors"
EXCEPT
SELECT "name"
FROM "translators";

--GROUP BY

-- Find average rating for each book
SELECT "book_id", ROUND(AVG("rating"), 2) AS "average rating"
FROM "ratings"
GROUP BY "book_id";

-- Join titles
SELECT "title", ROUND(AVG("rating"), 2) AS "average rating"
FROM "ratings"
         JOIN "books" ON "books"."id" = "ratings"."book_id"
GROUP BY "book_id";

--Choosing books with a rating of 4.0 or higher
SELECT "title", ROUND(AVG("rating"), 2) AS "average rating"
FROM "ratings"
         JOIN "books" ON "books"."id" = "ratings"."book_id"
GROUP BY "book_id"
HAVING "average rating" > 4.0;