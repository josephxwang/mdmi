DROP TABLE IF EXISTS federal_reports;
DROP TABLE IF EXISTS organization_reports;


DROP TABLE IF EXISTS stations CASCADE;
DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS organizations CASCADE;
DROP TABLE IF EXISTS affiliations CASCADE;
DROP TABLE IF EXISTS people_stations CASCADE;
DROP TABLE IF EXISTS sources_lookup CASCADE;
DROP TABLE IF EXISTS sources CASCADE;

DROP TYPE IF EXISTS station_status;
CREATE TYPE station_status AS ENUM ('active', 'empty', 'transition', 'planning');

CREATE TABLE sources(
	id SERIAL PRIMARY KEY,
	name TEXT,
	link TEXT
);

CREATE TABLE sources_lookup(
	id SERIAL PRIMARY KEY,
	source_id INTEGER,
	pages TEXT,
	CONSTRAINT fk_src_id FOREIGN KEY (source_id) REFERENCES sources(id)
);

CREATE TABLE organizations(
	id SERIAL PRIMARY KEY,
	name TEXT
);

CREATE TABLE people(
	id SERIAL PRIMARY KEY,
	name TEXT,
	title TEXT,
	gender TEXT,
	race TEXT,
	tribe TEXT,
	notes TEXT
);

CREATE TABLE stations(
	id SERIAL PRIMARY KEY,
	name TEXT,
	state TEXT,
	county TEXT,
	lat REAL,
	lon REAL,
	historic_place TEXT,
	historic_name TEXT,
	official_start INTEGER,
	official_end INTEGER,
	notes TEXT,
	source_id INTEGER,
	CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES sources_lookup(id)
);

CREATE TABLE federal_reports(
	id SERIAL PRIMARY KEY,
	station_id INTEGER,
	year INTEGER,
	total_expenditure REAL,
	total_income REAL,
	property_value REAL,
	num_students INTEGER,
	allowance REAL,
	notes TEXT,
	source_id INTEGER,
	CONSTRAINT fk_fed_station FOREIGN KEY(station_id) REFERENCES stations(id),
	CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES sources_lookup(id) 
);

CREATE TABLE organization_reports(
	id SERIAL PRIMARY KEY,
	station_id INTEGER,
	year INTEGER,
	status STATION_STATUS,
	num_students INTEGER,
	num_teachers INTEGER,
	notes TEXT,
	source_id INTEGER,
	CONSTRAINT fk_org_station FOREIGN KEY(station_id) REFERENCES stations(id),
	CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES sources_lookup(id)
);



CREATE TABLE affiliations(
	org_id INTEGER,
	station_id INTEGER,
	year INTEGER,
	type TEXT,
	distribution_amt REAL,
	notes TEXT,
	source_id INTEGER,
	PRIMARY KEY (org_id, station_id, year),
	CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES sources_lookup(id),
	CONSTRAINT fk_station_id FOREIGN KEY (station_id) REFERENCES stations(id),
	CONSTRAINT fk_org_id FOREIGN KEY (org_id) REFERENCES organizations(id)
);


CREATE TABLE people_stations(
	station_id INTEGER,
	people_id INTEGER,
	year INTEGER,
	role TEXT,
	notes TEXT,
	source_id INTEGER,
	PRIMARY KEY (station_id, people_id, year),
	CONSTRAINT fk_source_id FOREIGN KEY (source_id) REFERENCES sources_lookup(id),
	CONSTRAINT fk_station_id FOREIGN KEY (station_id) REFERENCES stations(id),
	CONSTRAINT fk_people_id FOREIGN KEY (people_id) REFERENCES people(id)
);

