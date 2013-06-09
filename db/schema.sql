/*
* A table to hold records for countries.
* This table is already populated
*/

PRAGMA foreign_keys = ON;

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

create table contractor (
    id integer PRIMARY KEY,
    country_id integer not null,
    first_name varchar not null,
    last_name varchar not null,
    hourly_rate decimal not null,
    foreign key(country_id) references country(id)
);


create table contractor_skill (
    contractor_id integer not null,
    skill_id integer not null,
    foreign key(contractor_id) references contractor(id) on delete cascade,
    foreign key(skill_id) references skill(id) on delete cascade,
    PRIMARY KEY(contractor_id, skill_id)
);

-- TODO create indices on foreign keys
