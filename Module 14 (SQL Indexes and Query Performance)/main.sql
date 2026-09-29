-- Hpw does a database find data quickly when a table contains millions of rows ?
-- this is where indexes come in

-- An index is a special data strucutre that helps the database find rows faster

--- Creating an Index

-- Syntax

CREATE INDEX index_name
ON table_name(column_name)

CREATE INDEX idx_student_name
ON students(name);

-- Normal Index (Duplicates values are allowed)

CREATE INDEX idx_name
ON students(name)

-- Unique index (Duplicates values are not allowed)
CREATE UNIQUE INDEX idx_email
ON users(email)


-- Indexes Make INSERT Slower

-- Indexes generally improvde read performance but add storage an write -maintences cost

-- Indexes are usually commonful on columns frequently used n:


--- Composite Index

-- suppose u frequently query :
SELECT *
FROM students
WHERE course = 'CSE'
AND age = 21;

-- u can create a multi-column index

CREATE INDEX idx_course_age
ON students (course,age);

-- this is called compostive index or multi - column index


-- So an index organize information so the database can locate matching rows efficiently


------------------ EXPLAIN ----------------
-- used for understanding query performance 

EXPLAIN
SELECT *
FROM students
WHERE name = 'Samir';

-- MySQL returns information about how it plans to execute the query

-- we might see column such as : 

id
select_type
table
type
possible_keys
key
rows
Extra


--- Example

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(150),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- create indexes

CREATE INDEX idx_employee_name
ON employees(name)

CREATE INDEX idx_employee_department
ON employees(dapartment)

CREATE UNIQUE INDEX idx_employee_email
ON employees(email);

SHWO INDEXES FROM employees;




















