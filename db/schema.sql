-- CRUD ------SQL
-- C - Create - insert
-- R - Read   - select
-- U - Update - update
-- D - Delete - delete

-- read
SELECT * FROM dishes;
SELECT * FROM dishes ORDER BY id ASC
SELECT * FROM dishes ORDER BY id DESC
-- create
INSERT INTO dishes (name) VALUES ('pudding');
INSERT INTO dishes (name) VALUES ('cake');

-- delete
DELETE FROM dishes WHERE id = 2;

-- update
UPDATE dishes 
SET image_url = 'https://kirbiecravings.com/wp-content/uploads/2019/01/microwave-custard-pudding-3a-700x659.jpg'
WHERE id = 1;

CREATE TABLE dishes (
    id SERIAL PRIMARY KEY,
    name TEXT,
    image_url TEXT
);

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    email TEXT,
    password_digest TEXT
);

ALTER TABLE dishes ADD COLUMN user_id INTEGER