-- http://www.postgresqltutorial.com/postgresql-insert/


DROP TABLE users
DROP TABLE countries

CREATE TABLE users (
 id serial primary key,
 name VARCHAR(255) not null
)
ALTER TABLE users ADD COLUMN country_id integer;

CREATE TABLE countries (
  id serial primary key,
  name VARCHAR(255) not null
)

INSERT INTO users (name) VALUES ('Marcin')
INSERT INTO users (name) VALUES ('Marcin')
INSERT INTO users (name) VALUES ('Ania')

INSERT INTO countries (name) VALUES ('Poland')
INSERT INTO countries (name) VALUES ('United States')

UPDATE users SET country_id=1 WHERE id = 1

SELECT COUNT(*) FROM users where country_id IS NOT NULL

SELECT * FROM users LEFT JOIN countries on users.country_id = countries.id

