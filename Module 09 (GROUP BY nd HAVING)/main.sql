-- GROUP BY puts rows having the same value into the same group

Students
   ↓
GROUP BY course
   ↓
┌─────────────┐
│ CSE         │
│ CSE         │
│ CSE         │
├─────────────┤
│ ECE         │
│ ECE         │
├─────────────┤
│ IT          │
└─────────────┘


SELECT course, COUNT(*)
FROM students
GROUP BY course;

-- It answers, how many students are there in each course?
-- Result : 
-- CSE -> 3
-- ECE -> 2
-- IT -> 1

-- take the students table, group students according to their course, and count how many students are in each course

| course | COUNT(*) |
| ------ | -------: |
| CSE    |        3 |
| ECE    |        2 |
| IT     |        1 |


-- COUNT(*) - it answers how many students are there in total?


COUNT()
SUM()
AVG()
MIN()
MAX()

-- are aggregate function

-- but : GROUP BY : is a clause that create group

GROUP BY
   ↓
creates groups

COUNT / SUM / AVG / MIN / MAX
   ↓
calculates something for each group

------------------ GROUP BY with SUM ------------------
-- Suppose we had a products table : 

products
| product | category    | price |
| ------- | ----------- | ----: |
| Laptop  | Electronics | 50000 |
| Mouse   | Electronics |  1000 |
| Chair   | Furniture   |  5000 |
| Table   | Furniture   | 10000 |

-- what is the total price of products in each cateogory

SELECT category, SUM(price)
FROM products
GROUP BY category;

| category    | SUM(price) |
| ----------- | ---------: |
| Electronics |      51000 |
| Furniture   |      15000 |


-- GROUP BY with AVG

-- what is the average age of each course?


SELECT course, AVF(age)
FROM students
GROUP BY course;

-- what is the youngest student age in each course?

SELECT course, MIN(age) AS younget_age
FROM students
GORUP BY course;

-- GROUP BY With MAX

SELECT course, MAX(age) AS oldest_age
FROM students
GROUP BY course;

-------------------------- HAVING ------------------------

-- Show only courses having more than 2 students


SELECT course, COUNT(*) AS total_students
FROM students
GROUP BY course
HAVING COUNT(*) > 2;

| course | total_students |
| ------ | -------------: |
| CSE    |              3 |


-- Example of WHERE
-- Find CSE students who are older than 20

SELECT *
FROM students
WHERE course = 'CSE'  -- WHERE works on individual rows
AND age > 20;

-- Example of HAVING 

-- Show courses that have more than 2 students

SELECT course, COUNT(*)
FROM students
GROUP BY course
HAVING COUNT(*) > 2;


-- WHERE -> Filters rows
-- HAVING -> filter groups


-------- WHERE + GROUP BY + HAVING ------------------

-- Find course having more than 1 student among students older than 20

-- break it down

-- Step (1) : Only consider students older than 20
WHERE age > 20

-- Step(2) : Group them by course
GROUP BY course

-- Step(3) : Keep only students with more than one student
HAVING COUNT(*) > 1

-- FINAL

SELECT course, COUNT(*) AS total_students
FROM students
WHERE age > 20
GROUP BY course
HAVING COUNT(*) > 1;

-- Conceptually SQL processe these clauses roughly as : 

FROM
  ↓
WHERE
  ↓
GROUP BY
  ↓
HAVING
  ↓
SELECT
  ↓
ORDER BY
  ↓
LIMIT

-- Qns : 

Show courses having at least 2 students, 
considering only students aged 20 or older, 
and sort them by student count from highest to lowest.


-- Break it down : 

WHERE age >= 20

-- Group
GROUP BY course

-- Keep Groups
HAVING COUNT(*) >= 2

-- Sort
ORDER BY COUNT(*) DESC


-- Final

SELECT course, COUNT(*) AS total_students
FROM students
WHERE age >= 20
GROUP BY course
HAVING COUNT(*) >= 2
ORDER BY COUNT(*) DESC

-- It is the realistic SQL Query 

------- GROUP BY + ORDER BY ---------------------

SELECT course, COUNT(*) AS total_students
FROM students
GROUP BY course
ORDER BY total_students DESC;


-- Combine Everything --------

-- GROUP BY + HAVING + ORDER BY + LIMIT

-- Give me top 2 courses by number of students, but only 
-- include courses with at least 1 students 

SELECT course, COUNT(*) AS total_students
FROM students
GROUP BY course
HAVING COUNT(*) >= 1
ORDER BY total_students DESC
LIMIT 2;



----------------- Practice -----------------

USE college_db;

-- Count students in each course
SELECT course, COUNT(*) AS total_students
FROM students
GROUP BY course;

-- Average age in each course
SELECT course, AVG(age) AS average_age
FROM students
GROUP BY course;

-- Youngest student age in each course
SELECT course, MIN(age) AS youngest_age
FROM students
GROUP BY course;

-- Oldest student age in each course
SELECT course, MAX(age) AS oldest_age
FROM students
GROUP BY course;

-- Multiple aggregate functions
SELECT
    course,
    COUNT(*) AS total_students,
    AVG(age) AS average_age,
    MIN(age) AS youngest_age,
    MAX(age) AS oldest_age
FROM students
GROUP BY course;

-- Courses having more than 2 students
SELECT course, COUNT(*) AS total_students
FROM students
GROUP BY course
HAVING COUNT(*) > 2;

-- Courses with more than 1 student,
-- considering only students older than 20
SELECT course, COUNT(*) AS total_students
FROM students
WHERE age > 20
GROUP BY course
HAVING COUNT(*) > 1;

-- Sort courses by number of students
SELECT course, COUNT(*) AS total_students
FROM students
GROUP BY course
ORDER BY total_students DESC;



---------------------------- FULL PATTERN ------------------------

SELECT column, AGGREGATE_FUNCTION(column)
FROM table
WHERE condition
GROUP BY column
HAVING aggregate_condition
ORDER BY column
LIMIT number;



