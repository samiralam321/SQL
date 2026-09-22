SELECT *
FROM students
WHERE age > 20;

-- This ans : Which student are older than 20 ?

-- But now suppose you ask :
-- Show those students from youngest to oldest

-- WHERE decides which rows we want
-- ORDER BY decides in what orders we want them
-- LIMIT decides how many rows we want

-- WHERE     → Which rows?
-- ORDER BY  → In what order?
-- LIMIT     → How many?


-------  ORDER BY

SELECT columns
FROM table
ORDER BY column;


SELECT *
FROM students
ORDER BY age;

-- this sort students by age : SQL sorts in asceding order.

--- For Text 

SELECT *
FROM students
ORDER BY age ASC;

-- ASC means Ascending 


--------------- Descesing Order -------------------

SELECT *
FROM students
ORDER BY age DESC;   -- DESC means Decreasing

--------------- WHERE + ORDER BY ---------------------

-- Give me CSE studetns from youngest to oldest

SELECT *
FROM students
WHERE course = 'CSE'
ORDER BY age ASC;

-- WHERE : keep only CSE students
-- ORDER BY : sort those students by age


SELECT name, age
FROM students
WHERE course = 'CSE'
ORDER BY age DESC;

-- Select name and age from studetns where course is CSE, ordered by age from highest to lowest



------------------------ LIMIT ------------------

-- Now suppsoe there are 10k students, u ask
-- Give me the oldest studetns
-- may be only want the first 5

SELECT *
FROM students
ORDER BY age DESC
LIMIT 5;

-- Sort the students from oldest to youngest, then give me only 5 rows


SELECT *
FROM students
LIMIT 3;

-- this gives you 3 rows, but without an explicit ordering requirements

-- If your requirements is give me the 3 oldest students : 

SELECT *
FROM students
ORDER BY age DESC
LIMIT 3;

------------------------

All students
    ↓
ORDER BY age DESC
    ↓
Oldest first
    ↓
LIMIT 3
    ↓
First 3 students

-------------------- Find the Youngest Students 

SELECT *
FROM students
ORDER BY age ACS
LIMIT 1;

ASC
↓
youngest first
↓
LIMIT 1
↓
only youngest student

-------------- Find the Oldest Students 

SELECT *
FROM students
ORDER BY age DESC
LIMIT 1;

DESC
↓
oldest first
↓
LIMIT 1


----------------------------------------

-- Top 3 oldest students

SELECT *
FROM students
ORDER BY age DESC
LIMIT 3;


-- This is a very common SQL pattern.

-- For example, in an application:

-- Top 10 products
-- Top 5 highest salaries
-- Top 20 scores
-- Latest 10 posts


--------------------- Latest Records ------------------

-- Suppose later we have created created_at

SELECT *
FROM posts
ORDER BY created_at DESC
LIMIT 10;

-- Meaning : Give me 10 most recent posts


------------- LIMIT with WHERE ---------------------

-- Give me 2 oldest CSE students 

SELECT *
FROM students
WHERE course = 'CSE'
ORDER BY age DECS
LIMIT 2;

--- WHat if you want the names alphabetically within the same age ?

SELECT *
FROM students
ORDER BY age ASC, name ASC;   -- Priority is age then name

-- This means : First sort by age. If two students have the same age, sort those students by names

----------------------------------------------------

--------- LIMIT with Two Numbers ------

LIMIT offset, count;

SELECT * 
FROM students
LIMIT 2,3;

-- Skip first 2 rows 
-- then returns 3 rows

-- This is useful for pagination
-- It helps in Backend APIs


--------------------- Pagination ----------------------

-- Suppose u have 1 Lakh Products 
--- We don't want to send all million products to the fronted

Page 1 → products 1-20
Page 2 → products 21-40
Page 3 → products 41-60


SELECT *
FROM students
LIMIT 0,10;   -- It will give first 10

SELECT *
FROM students
LIMIT 10,20    -- It will give Next 10 

SELECT *
FROM students
LIMIT 20,10;

-- Next 10


-------- Combine Everything -----------

------ Give me 3 oldest CSE students ---------

SELECT *
FROM students
WHERE course = 'CSE'
ORDER BY age DESC
LIMIT 3;



