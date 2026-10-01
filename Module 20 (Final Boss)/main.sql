/*
============================================================
MODULE 20: REAL-WORLD SQL PROJECT + INTERVIEW PREPARATION
============================================================

PROJECT:
College Management Database

GOAL:
Put everything learned in Modules 1-19 into one project.

Topics covered:
- Database
- Tables
- INSERT
- SELECT
- WHERE
- ORDER BY
- LIMIT
- UPDATE
- DELETE
- Constraints
- JOIN
- GROUP BY
- HAVING
- Subqueries
- CTE
- CASE
- Window Functions
- Indexes
- EXPLAIN
- Views
- Transactions
- Normalization
- Backend usage
- SQL Injection
- Interview Questions


============================================================
1. CREATE DATABASE
============================================================
*/

CREATE DATABASE college_db;

USE college_db;


/*
============================================================
2. CREATE COURSES TABLE
============================================================
*/

CREATE TABLE courses (
    id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL
);


/*
============================================================
3. INSERT COURSES
============================================================
*/

INSERT INTO courses (course_name)
VALUES
('CSE'),
('ECE'),
('IT'),
('ME');


/*
============================================================
4. CREATE STUDENTS TABLE
============================================================
*/

CREATE TABLE students (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    age INT,
    course_id INT,

    FOREIGN KEY (course_id)
    REFERENCES courses(id)
);


/*
============================================================
5. INSERT STUDENTS
============================================================
*/

INSERT INTO students (name, email, age, course_id)
VALUES
('Samir', 'samir@gmail.com', 21, 1),
('Rahul', 'rahul@gmail.com', 20, 1),
('Aman', 'aman@gmail.com', 22, 2),
('Priya', 'priya@gmail.com', 21, 3),
('Neha', 'neha@gmail.com', 20, 1);


/*
============================================================
6. CREATE TEACHERS TABLE
============================================================
*/

CREATE TABLE teachers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE
);


/*
============================================================
7. INSERT TEACHERS
============================================================
*/

INSERT INTO teachers (name, email)
VALUES
('Ravi', 'ravi@gmail.com'),
('Amit', 'amit@gmail.com'),
('Priya', 'priya@gmail.com');


/*
============================================================
8. CREATE ENROLLMENTS TABLE
============================================================
*/

CREATE TABLE enrollments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,

    FOREIGN KEY (student_id)
    REFERENCES students(id),

    FOREIGN KEY (course_id)
    REFERENCES courses(id)
);


/*
============================================================
9. BASIC SELECT
============================================================
*/

-- Get all students
SELECT *
FROM students;

-- Get specific columns
SELECT name, email
FROM students;


/*
============================================================
10. WHERE
============================================================
*/

-- Students from CSE
SELECT *
FROM students
WHERE course_id = 1;

-- Students older than 20
SELECT *
FROM students
WHERE age > 20;

-- Students whose age is 20
SELECT *
FROM students
WHERE age = 20;


/*
============================================================
11. AND / OR / NOT
============================================================
*/

-- CSE students older than 20
SELECT *
FROM students
WHERE course_id = 1
AND age > 20;

-- CSE or ECE students
SELECT *
FROM students
WHERE course_id = 1
OR course_id = 2;

-- Students who are NOT 20
SELECT *
FROM students
WHERE NOT age = 20;


/*
============================================================
12. ORDER BY
============================================================
*/

-- Youngest first
SELECT *
FROM students
ORDER BY age ASC;

-- Oldest first
SELECT *
FROM students
ORDER BY age DESC;

-- Sort by name
SELECT *
FROM students
ORDER BY name ASC;


/*
============================================================
13. LIMIT
============================================================
*/

-- Top 3 oldest students
SELECT *
FROM students
ORDER BY age DESC
LIMIT 3;


/*
============================================================
14. UPDATE
============================================================
*/

UPDATE students
SET age = 22
WHERE id = 1;


/*
IMPORTANT:
Always use WHERE carefully.

Without WHERE:

UPDATE students
SET age = 22;

This can update EVERY student.
*/


/*
============================================================
15. DELETE
============================================================
*/

DELETE FROM students
WHERE id = 5;


/*
IMPORTANT:
Without WHERE:

DELETE FROM students;

This can delete EVERY row.
*/


/*
============================================================
16. INNER JOIN
============================================================
*/

-- Get student name + course name

SELECT
    s.name,
    c.course_name
FROM students s
INNER JOIN courses c
ON s.course_id = c.id;


/*
============================================================
17. LEFT JOIN
============================================================
*/

SELECT
    s.name,
    c.course_name
FROM students s
LEFT JOIN courses c
ON s.course_id = c.id;


/*
============================================================
18. GROUP BY
============================================================
*/

-- Count students in each course

SELECT
    c.course_name,
    COUNT(*) AS total_students
FROM students s
JOIN courses c
ON s.course_id = c.id
GROUP BY c.course_name;


/*
============================================================
19. HAVING
============================================================
*/

-- Courses having more than 1 student

SELECT
    c.course_name,
    COUNT(*) AS total_students
FROM students s
JOIN courses c
ON s.course_id = c.id
GROUP BY c.course_name
HAVING COUNT(*) > 1;


/*
============================================================
20. AGGREGATE FUNCTIONS
============================================================
*/

-- Total students
SELECT COUNT(*) AS total_students
FROM students;

-- Average age
SELECT AVG(age) AS average_age
FROM students;

-- Maximum age
SELECT MAX(age) AS maximum_age
FROM students;

-- Minimum age
SELECT MIN(age) AS minimum_age
FROM students;

-- Total age
SELECT SUM(age) AS total_age
FROM students;


/*
============================================================
21. SUBQUERY
============================================================
*/

-- Students older than average age

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


/*
============================================================
22. SUBQUERY WITH MAX
============================================================
*/

-- Oldest student

SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);


/*
============================================================
23. CTE
============================================================
*/

-- Find students older than average age

WITH average_age AS (
    SELECT AVG(age) AS avg_age
    FROM students
)

SELECT *
FROM students
WHERE age > (
    SELECT avg_age
    FROM average_age
);


/*
============================================================
24. CTE WITH GROUP BY
============================================================
*/

WITH course_counts AS (
    SELECT
        course_id,
        COUNT(*) AS total_students
    FROM students
    GROUP BY course_id
)

SELECT *
FROM course_counts
WHERE total_students > 1;


/*
============================================================
25. CASE
============================================================
*/

-- Categorize students based on age

SELECT
    name,
    age,

    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS category

FROM students;


/*
============================================================
26. CASE WITH MULTIPLE CONDITIONS
============================================================
*/

SELECT
    name,
    age,

    CASE
        WHEN age < 20 THEN 'Teen'
        WHEN age <= 21 THEN 'Young Adult'
        ELSE 'Adult'
    END AS age_group

FROM students;


/*
============================================================
27. WINDOW FUNCTION - RANK
============================================================
*/

SELECT
    name,
    age,

    RANK() OVER (
        ORDER BY age DESC
    ) AS age_rank

FROM students;


/*
============================================================
28. ROW_NUMBER
============================================================
*/

SELECT
    name,
    age,

    ROW_NUMBER() OVER (
        ORDER BY age DESC
    ) AS row_num

FROM students;


/*
============================================================
29. DENSE_RANK
============================================================
*/

SELECT
    name,
    age,

    DENSE_RANK() OVER (
        ORDER BY age DESC
    ) AS age_rank

FROM students;


/*
============================================================
30. PARTITION BY
============================================================
*/

-- Rank students separately inside each course

SELECT
    name,
    course_id,
    age,

    RANK() OVER (
        PARTITION BY course_id
        ORDER BY age DESC
    ) AS age_rank

FROM students;


/*
============================================================
31. WINDOW FUNCTION + AVG
============================================================
*/

SELECT
    name,
    age,

    AVG(age) OVER () AS average_age

FROM students;


/*
============================================================
32. WINDOW FUNCTION + PARTITION BY
============================================================
*/

SELECT
    name,
    course_id,
    age,

    AVG(age) OVER (
        PARTITION BY course_id
    ) AS course_average_age

FROM students;


/*
============================================================
33. INDEX
============================================================
*/

-- Create index on email

CREATE INDEX idx_student_email
ON students(email);


/*
============================================================
34. SHOW INDEXES
============================================================
*/

SHOW INDEXES FROM students;


/*
============================================================
35. EXPLAIN
============================================================
*/

EXPLAIN
SELECT *
FROM students
WHERE email = 'samir@gmail.com';


/*
============================================================
36. DROP INDEX
============================================================
*/

DROP INDEX idx_student_email
ON students;


/*
============================================================
37. VIEW
============================================================
*/

-- Create a view containing student + course information

CREATE VIEW student_details AS

SELECT
    s.id,
    s.name,
    s.email,
    c.course_name

FROM students s

JOIN courses c
ON s.course_id = c.id;


/*
============================================================
38. USE VIEW
============================================================
*/

SELECT *
FROM student_details;


/*
============================================================
39. FILTER A VIEW
============================================================
*/

SELECT *
FROM student_details
WHERE course_name = 'CSE';


/*
============================================================
40. MODIFY VIEW
============================================================
*/

CREATE OR REPLACE VIEW student_details AS

SELECT
    s.id,
    s.name,
    s.email,
    s.age,
    c.course_name

FROM students s

JOIN courses c
ON s.course_id = c.id;


/*
============================================================
41. DROP VIEW
============================================================
*/

DROP VIEW student_details;


/*
============================================================
42. TRANSACTION
============================================================
*/

-- Example:
-- Transfer money between two accounts

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

COMMIT;


/*
============================================================
43. ROLLBACK
============================================================
*/

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

-- Something goes wrong

ROLLBACK;


/*
============================================================
44. SAVEPOINT
============================================================
*/

START TRANSACTION;

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

SAVEPOINT point1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

ROLLBACK TO point1;

COMMIT;


/*
============================================================
45. ACID
============================================================

A = ATOMICITY
    All operations succeed or none are applied.

C = CONSISTENCY
    Database remains valid.

I = ISOLATION
    Transactions should not improperly interfere.

D = DURABILITY
    Committed changes remain saved.


Easy way:

A → All or Nothing
C → Database stays Valid
I → Transactions are Isolated
D → Data stays Durable


============================================================
46. NORMALIZATION
============================================================

Normalization means organizing database tables to:

- Reduce duplicate data
- Avoid data inconsistency
- Prevent anomalies
- Make the database easier to maintain


1NF
---
Atomic values.

No multiple values inside one cell.


2NF
---
1NF + No Partial Dependency.


3NF
---
2NF + No Transitive Dependency.


Easy way:

1NF → Atomic
2NF → No Partial Dependency
3NF → No Transitive Dependency


============================================================
47. SQL INJECTION
============================================================

SQL Injection is an attack where malicious input
is used to manipulate an SQL query.


BAD:

query = "SELECT * FROM users WHERE email = '" + email + "'";


The user input becomes part of the SQL code.


SAFE APPROACH:

Use parameterized queries.

Concept:

User Input
    ↓
Parameter
    ↓
SQL Query
    ↓
Database


Never directly concatenate untrusted user input
into SQL queries.


============================================================
48. SQL IN BACKEND DEVELOPMENT
============================================================

Typical architecture:

Frontend
    ↓
HTTP Request
    ↓
FastAPI
    ↓
Business Logic
    ↓
SQL / ORM
    ↓
MySQL
    ↓
Database
    ↓
Result
    ↓
FastAPI
    ↓
JSON Response
    ↓
Frontend


CRUD mapping:

CREATE → POST
READ   → GET
UPDATE → PUT / PATCH
DELETE → DELETE


SQL mapping:

POST
 ↓
INSERT


GET
 ↓
SELECT


PUT / PATCH
 ↓
UPDATE


DELETE
 ↓
DELETE


============================================================
49. ORM
============================================================

ORM = Object Relational Mapping


It allows backend code to work with database
data using programming-language objects.

Flow:

Python
   ↓
ORM
   ↓
SQL
   ↓
MySQL


Popular Python ORM:

SQLAlchemy


IMPORTANT:

You should understand SQL even when using an ORM.

SQL knowledge helps you:

- Debug queries
- Optimize queries
- Understand database behavior
- Write complex queries


============================================================
50. CONNECTION POOL
============================================================

Creating a new database connection for every request
can be expensive.

A connection pool keeps reusable connections.

Concept:

             CONNECTION POOL

        ┌────┬────┬────┬────┐
        │ C1 │ C2 │ C3 │ C4 │
        └────┴────┴────┴────┘
                 ↓
               MySQL


Request
   ↓
Get available connection
   ↓
Execute query
   ↓
Return connection to pool


This improves database connection management.


============================================================
51. ENVIRONMENT VARIABLES
============================================================

Never hardcode database passwords.

BAD:

password = "mypassword123"


Better:

.env

DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=college_db


Add .env to .gitignore:

.env


Never upload secrets to GitHub.


============================================================
52. BACKEND CRUD EXAMPLE
============================================================

CREATE:

POST /students

SQL:

INSERT INTO students(name, age, course_id)
VALUES ('Samir', 21, 1);


READ:

GET /students

SQL:

SELECT *
FROM students;


READ ONE:

GET /students/1

SQL:

SELECT *
FROM students
WHERE id = 1;


UPDATE:

PUT /students/1

SQL:

UPDATE students
SET age = 22
WHERE id = 1;


DELETE:

DELETE /students/1

SQL:

DELETE FROM students
WHERE id = 1;


============================================================
53. REAL BACKEND FLOW
============================================================

User
 ↓
Frontend
 ↓
HTTP Request
 ↓
FastAPI
 ↓
Validate Input
 ↓
Business Logic
 ↓
SQL Query / ORM
 ↓
MySQL
 ↓
Database Result
 ↓
FastAPI
 ↓
JSON Response
 ↓
Frontend


============================================================
54. IMPORTANT SQL INTERVIEW QUESTIONS
============================================================


Q1. What is SQL?
----------------

SQL is a language used to communicate with
relational databases.


Q2. What is DBMS?
-----------------

DBMS is software used to create, manage and
interact with databases.


Q3. What is a Primary Key?
--------------------------

A Primary Key uniquely identifies each row
in a table.


Q4. What is a Foreign Key?
--------------------------

A Foreign Key creates a relationship between
tables.


Q5. DELETE vs DROP?
-------------------

DELETE
→ Removes rows.

DROP
→ Removes the database object itself.


Q6. DELETE vs TRUNCATE?
-----------------------

DELETE
→ Removes rows.
→ Can use WHERE.

TRUNCATE
→ Removes all rows.
→ Cannot use WHERE.


Q7. WHERE vs HAVING?
--------------------

WHERE
→ Filters rows.

HAVING
→ Filters groups.


Q8. INNER JOIN vs LEFT JOIN?
----------------------------

INNER JOIN
→ Returns matching rows.

LEFT JOIN
→ Returns all rows from the left table
  plus matching rows from the right table.


Q9. What is an Index?
---------------------

An Index is a data structure that can help
the database find rows faster.


Q10. Does an Index always make queries faster?
----------------------------------------------

No.

Indexes also:

- Consume storage.
- Add overhead to INSERT.
- Add overhead to UPDATE.
- Add overhead to DELETE.

The database optimizer decides whether an index
is useful for a particular query.


Q11. What is Normalization?
---------------------------

Normalization is organizing tables to reduce
data duplication and prevent anomalies.


Q12. What is 1NF?
-----------------

Atomic values.


Q13. What is 2NF?
-----------------

1NF + No Partial Dependency.


Q14. What is 3NF?
-----------------

2NF + No Transitive Dependency.


Q15. What is a Transaction?
---------------------------

A transaction is a group of database operations
treated as one logical unit.


Q16. What is COMMIT?
-------------------

COMMIT permanently saves transaction changes.


Q17. What is ROLLBACK?
----------------------

ROLLBACK undoes changes made during the
current transaction.


Q18. What is ACID?
------------------

A → Atomicity
C → Consistency
I → Isolation
D → Durability


Q19. What is a View?
--------------------

A View is a virtual table based on a SQL query.


Q20. What is a Stored Procedure?
--------------------------------

A Stored Procedure is a group of SQL statements
stored inside the database.


Q21. What is a CTE?
-------------------

CTE = Common Table Expression.

It is a named query result used within
a larger query.


Q22. What is a Window Function?
------------------------------

A Window Function performs calculations across
related rows while keeping individual rows
in the result.


Q23. GROUP BY vs Window Function?
---------------------------------

GROUP BY
→ Combines/collapses rows into groups.

Window Function
→ Keeps individual rows and calculates
  values across related rows.


Q24. ROW_NUMBER vs RANK vs DENSE_RANK?
---------------------------------------

ROW_NUMBER
→ Gives every row a unique number.

RANK
→ Same rank for ties + gaps.

DENSE_RANK
→ Same rank for ties + no gaps.


Example:

Values:

100
100
90
80


ROW_NUMBER:

100 → 1
100 → 2
90  → 3
80  → 4


RANK:

100 → 1
100 → 1
90  → 3
80  → 4


DENSE_RANK:

100 → 1
100 → 1
90  → 2
80  → 3


Q25. What is SQL Injection?
---------------------------

SQL Injection is an attack where malicious
input is used to manipulate an SQL query.

Prevent it using:

- Parameterized queries
- Prepared statements
- Proper ORM/query APIs


============================================================
55. MOST IMPORTANT SQL COMMANDS
============================================================

DATABASE:

CREATE DATABASE database_name;

USE database_name;

DROP DATABASE database_name;


TABLE:

CREATE TABLE table_name (...);

SHOW TABLES;

DESC table_name;

DROP TABLE table_name;


INSERT:

INSERT INTO table_name (...)
VALUES (...);


SELECT:

SELECT *
FROM table_name;


UPDATE:

UPDATE table_name
SET column = value
WHERE condition;


DELETE:

DELETE FROM table_name
WHERE condition;


FILTER:

WHERE


SORT:

ORDER BY


LIMIT:

LIMIT


GROUP:

GROUP BY


FILTER GROUPS:

HAVING


JOIN:

INNER JOIN
LEFT JOIN
RIGHT JOIN


SUBQUERY:

SELECT ...
WHERE column IN (
    SELECT ...
);


CTE:

WITH cte_name AS (
    SELECT ...
)
SELECT *
FROM cte_name;


CASE:

CASE
    WHEN condition THEN result
    ELSE result
END


WINDOW:

ROW_NUMBER() OVER (...);

RANK() OVER (...);

DENSE_RANK() OVER (...);

LAG() OVER (...);

LEAD() OVER (...);


INDEX:

CREATE INDEX index_name
ON table_name(column);


EXPLAIN:

EXPLAIN
SELECT ...;


VIEW:

CREATE VIEW view_name AS
SELECT ...;


TRANSACTION:

START TRANSACTION;

COMMIT;

ROLLBACK;

SAVEPOINT name;

ROLLBACK TO name;


/*
============================================================
56. FINAL SQL ROADMAP
============================================================

MODULE 1
SQL Fundamentals + Database Basics

MODULE 2
Creating Databases and Tables

MODULE 3
INSERT, SELECT and Basic Queries

MODULE 4
WHERE, AND, OR, NOT

MODULE 5
ORDER BY and LIMIT

MODULE 6
UPDATE and DELETE

MODULE 7
Constraints

MODULE 8
Aggregate Functions

MODULE 9
GROUP BY and HAVING

MODULE 10
SQL JOINs

MODULE 11
Subqueries

MODULE 12
String, Date and Mathematical Functions

MODULE 13
CASE Statements

MODULE 14
Indexes and Query Performance

MODULE 15
Normalization and Database Design

MODULE 16
Views and Stored Procedures

MODULE 17
Transactions and ACID

MODULE 18
CTEs and Window Functions

MODULE 19
SQL for Backend Development

MODULE 20
Real-World SQL Project + Interview Preparation


============================================================
57. FINAL MENTAL MODEL
============================================================

DATABASE
    ↓
TABLES
    ↓
ROWS + COLUMNS
    ↓
CRUD
    ↓
FILTERING
    ↓
SORTING
    ↓
AGGREGATION
    ↓
GROUP BY + HAVING
    ↓
JOINS
    ↓
SUBQUERIES
    ↓
CTEs
    ↓
CASE
    ↓
WINDOW FUNCTIONS
    ↓
INDEXES
    ↓
EXPLAIN
    ↓
NORMALIZATION
    ↓
VIEWS
    ↓
TRANSACTIONS
    ↓
BACKEND
    ↓
FastAPI + MySQL
    ↓
REAL APPLICATION


============================================================
58. WHAT TO DO AFTER THIS COURSE
============================================================

1. Practice SQL regularly.

2. Solve SQL problems on platforms such as
   LeetCode and HackerRank.

3. Build the College Management Database yourself.

4. Learn MySQL database administration basics.

5. Connect MySQL with FastAPI.

6. Learn SQLAlchemy.

7. Learn database migrations.

8. Build a real backend project.

9. Practice SQL + DBMS interview questions.

10. Use EXPLAIN to understand query performance.


============================================================
MODULE 20 COMPLETE
============================================================

SQL ROADMAP COMPLETE.

NEXT STEP:

SQL
 ↓
MySQL Practice
 ↓
FastAPI + MySQL
 ↓
SQLAlchemy
 ↓
Backend Project
 ↓
Backend Interview Preparation

============================================================
*/