-- Update

UPDATE table_name
SET column = value
WHERE condition;

--

UPDATE students
SET course = 'IT'
WHERE id = 1;

-- In the student table, change the course to IT where the student's id is 1

-- Change Rahul age from 20 to 21

UPDATE students
SET age = 21
WHERE id = 2;

-- Update Multiple Columns

UPDATE students
SET age = 23, course = 'CSE'
WHERE id = 3;


--

UPDATE students
SET age = 22
WHERE course = 'ECE';

-- Update using Calulations

UPDATE students
SET age = age + 1

-- This updates every student's age

-- UPDATE with WHERE + Calculations

UPDATE students
SET age = age + 1
WHERE course = 'CSE';

-------------------  DELETE ---------------

DELETE FROM students
WHERE id = 6;

-- DELETE : Removes the rows, but the tables still exists

---------------- DROP ------------------

-- It removes the entire table

DROP TABLE students;

--- Delete Specific Rows 

DELETE FROM students
WHERE course = 'ECE';


DELETE FROM students
WHERE course = 'CSE'
AND age < 21;

-- OR

DELETE FROM students
WHERE course = 'ECE'
OR course = 'IT';


-- INSERT : Adds a new row
-- UPDATE : Changes an existing row

--

USE college_db;

-- Check Samir before updating
SELECT *
FROM students
WHERE id = 1;

-- Update Samir's course
UPDATE students
SET course = 'IT'
WHERE id = 1;

-- Check after update
SELECT *
FROM students
WHERE id = 1;


-- Update Rahul's age
UPDATE students
SET age = 21
WHERE id = 2;


-- Update multiple columns
UPDATE students
SET age = 23,
    course = 'CSE'
WHERE id = 3;


-- Increase age of CSE students
UPDATE students
SET age = age + 1
WHERE course = 'CSE';


-- Check before deleting
SELECT *
FROM students
WHERE id = 6;

-- Delete Arjun
DELETE FROM students
WHERE id = 6;
























