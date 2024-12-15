CREATE TABLE people (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    surname VARCHAR(100),
    age INT,
    died_date TIMESTAMP
);

INSERT INTO people (name, surname, age, died_date)
SELECT 
    'chuvack' || i,
    'chuvackov' || i,
    (random() * 50 + 18)::int,
    timestamp '2000-01-01' + (random() * (interval '10 years'))
FROM generate_series(1, 2000000) i;

CREATE INDEX btree_name_idx ON people USING btree (name);
CREATE INDEX hash_surname_idx ON people USING hash (surname);
CREATE INDEX btree_two_idx ON people USING btree (age, died_date);
CREATE EXTENSION bloom;
CREATE INDEX bloom_multi_idx ON people USING bloom (name, surname);
CREATE EXTENSION btree_gist;
CREATE INDEX gist_expr_idx ON people USING gist (EXTRACT(year FROM died_date));

SELECT 
pg_size_pretty(pg_relation_size('btree_name_idx')) as btree_size,
pg_size_pretty(pg_relation_size('btree_two_idx')) as two_size,
pg_size_pretty(pg_relation_size('bloom_multi_idx')) as bloom_size,
pg_size_pretty(pg_relation_size('hash_surname_idx')) as hash_size,
pg_size_pretty(pg_relation_size('gist_expr_idx')) as gist_size;
