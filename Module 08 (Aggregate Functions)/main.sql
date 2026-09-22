-- Untill now most of our queirs worked row by row
-- but what if we want to calculate something from a group of rows
-- that is where eggregate functions do 

-- An aggregate functions takes value from multiple rows and produces a single result 

Many rows
   ↓
Aggregate Function
   ↓
One result


--- Count ---

SELECT COUNT(*)
FROM students

-- means : Count the rows in the table

-- Give the result a Name

SELECT COUNT(*) AS total_students
FROM students;

-- Count with Where
-- Count how many CSE students are there?

SELECT COUNT(*) AS total_cse
FROM students
WHERE course = 'CSE';


-- SUM() ----

-- It calculates the total numeric values

SELECT SUM(age) AS total_age  -- Read it like this : select age as total_age and now perform the function on that age 
FROM students 


-- Sum with WHERE

SELECT SUM(age) AS cse_total_age
FROM students
WHERE course = 'CSE';

-- Note that : SUM works with Numbers only 


-- AVG() Calculate the average 

SELECT AVG(age) AV average_age
FROM students;


-- AVG with WHERE

SELECT AVG(age) AS cse_average_age
FROM students
WHERE course = 'CSE';


-- MIN() gives the smallest value

SELECT MIN(age) as youngest_age
FROM students;

SELECT MAX(age) as oldest_age
FROM students;


-- All Operations Together

SELECT
    COUNT(*) AS total_students,
    SUM(age) AS total_age,
    AVG(age) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;



-- Aggregrate Functions + WHERE

-- What is the maximum age of CSE students ? 

SELECT MAX(age) AS oldest_cse_student
FROM students
WHERE course = 'CSE';


-- How many students are older than 20? 

SELECT COUNT(*) AS student_above_20
FROM students
WHERE age > 20;


-- What is the average age of students who are not from CSE ?

SELECT AVG(age) AS average_age
FROM students
WHERE course <> 'CSE';


-- Remember

COUNT(*) 
→ counts rows

COUNT(column)
→ counts non-NULL values


---------------- COUNT(DISTINCT ...) ------------------

SELECT COUNT(DISTINCT course) AS total_courses
FROM students;



----------- Practice -------

USE college_db;

-- Count all students
SELECT COUNT(*) AS total_students
FROM students;

-- Count CSE students
SELECT COUNT(*) AS total_cse
FROM students
WHERE course = 'CSE';

-- Total age
SELECT SUM(age) AS total_age
FROM students;

-- Average age
SELECT AVG(age) AS average_age
FROM students;

-- Youngest age
SELECT MIN(age) AS youngest_age
FROM students;

-- Oldest age
SELECT MAX(age) AS oldest_age
FROM students;

-- All statistics together
SELECT
    COUNT(*) AS total_students,
    SUM(age) AS total_age,
    AVG(age) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students;

























































































































