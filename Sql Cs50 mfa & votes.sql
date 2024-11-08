-- .Schema
create table 'collections'
(
    'id'               INTEGER,
    'title'            TEXT NOT NULL,
    'accession_number' TEXT NOT NULL UNIQUE,
    'acquired'         NUMERIC,
    primary key ('id')
);

create table 'artists'
(
    'id'   INTEGER,
    'name' TEXT NOT NULL,
    primary key ('id')
);

create table 'created'
(
    'artist_id'     INTEGER,
    'collection_id' INTEGER,
    primary key (artist_id, collection_id),
    foreign key (artist_id) references artists (id),
    foreign key (collection_id) references collections (id)
);

CREATE TABLE "transactions"
(
    "id"     INTEGER,
    "title"  TEXT,
    "action" TEXT,
    PRIMARY KEY ("id")
);
--INSERT 

--INSERT INTO --used to add data to the table

INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
VALUES (1, 'Profusion of flowers', '56.257', '1956-04-12');

INSERT INTO "collections" ("id", "title", "accession_number", "acquired")
VALUES (2, 'Farmers working at dawn', '11.6152', '1911-08-03');

---- Adds a new item to the collections, demonstrating primary key auto-increments
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Spring outing', '14.76', '1914-01-08');

--UNIQUE ERROR
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Spring outing', '14.76', '1914-01-08');

--NULL ERROR
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES (NULL, NULL, '1900-01-10');

---- Adding multiple rows to a table
INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Imaginative landspace', '56.496', NULL),
       ('Peonies and butterfly', '06.1899', '1906-01-01');


--IMPORT

---- Imports into an existing table by specifying mode and skipping header columns
-- .import --csv --skip 1 mfa.csv collections

---- Imports into a temporary using a CSV without primary keys
 -- .import --csv mfa.csv temp

---- Inserts into final table by selecting from temporary table
INSERT INTO "collections" ("title", "accession_number", "acquired")
SELECT "title", "accession_number", "acquired"
FROM "temp";

--DELETE

DELETE
FROM "collections"
WHERE "title" = 'Spring outing';

DELETE
FROM "collections"
WHERE "acquired" IS NULL;

DELETE
FROM "collections"
WHERE "acquired" < '1909-01-01';

--Foreign Key Constraints

--In another possibility, we can specify the action to be taken when an ID referenced by a foreign key is deleted. 
--To do this, we use the keyword ON DELETE followed by the action to be taken.


/*
ON DELETE
RESTRICT: --This restricts us from deleting IDs when the foreign key constraint is violated.
ON DELETE
NO ACTION: --This allows the deletion of IDs that are referenced by a foreign key and nothing happens.
ON DELETE
SET NULL: --This allows the deletion of IDs that are referenced by a foreign key and sets the foreign key references to NULL.
ON DELETE
SET DEFAULT: --This does the same as the previous, but allows us to set a default value instead of NULL.
ON DELETE
CASCADE: --This allows the deletion of IDs that are referenced by a foreign key and also proceeds to cascadingly delete the referencing foreign key rows. 
--For example, if we used this to delete an artist ID, all the artist’s affiliations with the artwork would also be deleted from the created table.
*/


--UPDATE

-- Updates authorship (correctly) for a piece with a previously unknown authorship
UPDATE "created"
SET "artist_id" = (SELECT "id"
                   FROM "artists"
                   WHERE "name" = 'Li Yin')
WHERE "collection_id" = (SELECT "id"
                         FROM "collections"
                         WHERE "title" = 'Farmers working at dawn');

-- Imports votes.csv
-- .import votes.csv votes

-- Counts votes
SELECT "title", COUNT("title")
FROM "votes"
GROUP BY "title";

--trim

-- Removes trailing whitespace
UPDATE "votes"
SET "title" = trim("title");

--upper

-- Forces to uppercase
UPDATE "votes"
SET "title" = upper("title");

-- Manually updates the titles of "Farmers working at dawn"
UPDATE "votes"
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FARMERS WORKING';

UPDATE "votes"
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" = 'FAMERS WORKING AT DAWN';

-- Fixes misspellings of "Farmers working at dawn"
UPDATE "votes"
SET "title" = 'FARMERS WORKING AT DAWN'
WHERE "title" LIKE 'Fa%';

-- Fixes misspellings of "Imaginative landscape"
UPDATE "votes"
SET "title" = 'IMAGINATIVE LANDSCAPE'
WHERE "title" LIKE 'Imag%';

-- Fixes misspellings of "Profusion of flowers"
UPDATE "votes"
SET "title" = 'PROFUSION OF FLOWERS'
WHERE "title" LIKE 'Profusion %';

--TRIGGERS

-- Creates a trigger to log sold items from collections
CREATE TRIGGER "sell"
    BEFORE DELETE
    ON "collections"
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUES (OLD."title", 'sold');
END;

DELETE
FROM "collections"
WHERE "title" = 'Profusion of flowers';

-- Creates a trigger to log bought items
CREATE TRIGGER "buy"
    AFTER INSERT
    ON "collections"
BEGIN
    INSERT INTO "transactions" ("title", "action")
    VALUES (NEW."title", 'bought');
END;

INSERT INTO "collections" ("title", "accession_number", "acquired")
VALUES ('Profusion of flowers', '56.257', '1956-04-12');

ALTER TABLE "collections"
    ADD COLUMN "deleted" INTEGER DEFAULT 0;

UPDATE "collections"
SET "deleted" = 1
WHERE "title" = 'Farmers working at dawn';