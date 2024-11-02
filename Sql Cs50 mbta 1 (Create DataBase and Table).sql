-- ".schema" shows the schema of the table or database

--Normalizing
--Normalization; These are the processes carried out during the database design phase to prevent data duplication, data loss or data delay.

--CREATE TABLE --creates table
create table 'riders'
(
    'id',
    'name'
);

create table 'stations'
(
    'id',
    'name',
    'line'
);

--"riders" "stations" join table
create table 'visits'
(
    'rider_id',
    'station_id'
);

--DROP TABLE -- deletes existing table

drop table riders;
drop table stations;
drop table visits;
drop table swipes;

--Data Types and Storage Classes

--Null: nothing, or empty value
--Integer: numbers without decimal points
--Real: decimal or floating point numbers
--Text: characters or strings
--Blob: Binary Large Object, for storing objects in binary (useful for images, audio etc.)

--PRIMARY KEY
--primary key is the unique identification number in a table

--FOREIGN KEY
--A FOREIGN KEY is a field (or collection of fields) that references a PRIMARY KEY in another table.

--Column Constraints

--CHECK: allows checking for a condition, like all values in the column must be greater than 0
--DEFAULT: uses a default value if none is supplied for a row
--NOT NULL: dictates that a null or empty value cannot be inserted into the column
--UNIQUE: dictates that every value in this column must be unique


create table 'riders'
(
    'id'   INTEGER,
    'name' TEXT NOT NULL,
    primary key (id)
);

create table 'stations'
(
    'id'   INTEGER,
    'name' TEXT NOT NULL UNIQUE,
    'line' TEXT NOT NULL,
    primary key (id)
);
create table 'visits'
(
    'id'         INTEGER,
    'rider_id'   INTEGER,
    'station_id' INTEGER,
    primary key (id),
    foreign key (rider_id) references riders (id),
    foreign key (station_id) references stations (id)
);

--- Create Schema
create table 'swipes'
(
    'id'         INTEGER,
    'rider_id'   INTEGER,
    'station_id' INTEGER,
    'type'       TEXT    not null CHECK (type in ('enter', 'exit', 'deposit')),
    'datatime'   NUMERIC not null DEFAULT CURRENT_TIMESTAMP,
    'amount'     NUMERIC not null CHECK (amount != 0),
    primary key (id),
    foreign key (rider_id) references riders (id),
    foreign key (station_id) references stations (id)
);


--Altering Tables

--ALTER TABLE

-- Renames "vists" table to "swipes"
alter table visits
    rename to 'swipes';

-- Adds "ttpe" column to "swipes" table (intentional typo)
alter table swipes
    add column 'ttpe' TEXT;

-- Fixes typo using RENAME COLUMN
alter table swipes
    rename column ttpe to 'type';

--delete column
alter table swipes
    drop column type;





