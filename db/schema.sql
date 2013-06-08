/*
* A table to hold records for countries.
* This table is already populated
*/

create table country (
	id integer PRIMARY KEY,
	name varchar not null unique
);

/*
* A table to hold records for skills.
* This table is already populated
*/

create table skill (
	id integer PRIMARY KEY,
	name varchar not null unique
);
