--SELECT

SELECT * FROM 'longlist';

SELECT "title" FROM "longlist";

SELECT "title", "author" FROM "longlist";

--LIMIT

SELECT "title" FROM "longlist" LIMIT 10;

SELECT "title" FROM "longlist" LIMIT 10;

--WHERE

SELECT "title", "author" FROM "longlist" WHERE "year" = 2023;

SELECT "title", "author" FROM "longlist" WHERE "year" = 2022;

SELECT "title", "author" FROM "longlist" WHERE "year" = 2021;

SELECT "title", "format" FROM "longlist" WHERE "format" != 'hardcover';

--NOT

SELECT "title", "format" FROM "longlist" WHERE NOT "format" = 'hardcover';

--OR

SELECT "title", "author" FROM "longlist" WHERE "year" = 2022 OR "year" = 2023;

SELECT "title", "format" FROM "longlist" WHERE ("year" = 2022 OR "year" = 2023) AND "format" != 'hardcover';

--NULL

SELECT "title", "translator" FROM "longlist" WHERE "translator" IS NULL;

SELECT "title", "translator" FROM "longlist" WHERE "translator" IS NOT NULL;

--LIKE

SELECT "title" FROM "longlist" WHERE "title" LIKE '%love%';

SELECT "title" FROM "longlist" WHERE "title" LIKE 'The%' ;

SELECT "title" FROM "longlist" WHERE "title" LIKE 'P_re';

SELECT "title" FROM "longlist" WHERE "title" LIKE 'T___';

--AND BEETWEEN

SELECT "title", "year" FROM "longlist" WHERE "year" >= 2019 AND "year" <= 2022;

SELECT "title", "year" FROM "longlist" WHERE "year" between 2019 AND 2022;

SELECT "title", "rating" FROM "longlist" WHERE "rating" > 4.0;

SELECT "title","rating", "votes" FROM "longlist" WHERE "rating" > 4.0 AND "votes" > 10000;

SELECT "title", "pages" FROM "longlist" WHERE "pages" <300;

--ORDER BY

SELECT "title", "rating" FROM "longlist" ORDER BY "rating" LIMIT 10;

SELECT "title", "rating" FROM "longlist" ORDER BY "rating" DESC LIMIT 10;

SELECT "title", "rating", "votes" FROM "longlist" ORDER BY "rating" DESC, "votes" DESC LIMIT 10;

--COUNT,AVG,MIN,MAX,SUM 

SELECT AVG("rating") FROM "longlist";

SELECT ROUND(AVG("rating"), 2) AS "averate rating" FROM "longlist";

SELECT MAX("rating") FROM "longlist";

SELECT MIN("rating") FROM "longlist";

SELECT SUM("votes") FROM "longlist";

SELECT COUNT(*) FROM "longlist";

SELECT COUNT(translator) FROM "longlist";

SELECT COUNT("publisher") FROM "longlist";

--DISTINCT

SELECT DISTINCT "publisher" FROM "longlist";

SELECT COUNT(DISTINCT "publisher") FROM "longlist"