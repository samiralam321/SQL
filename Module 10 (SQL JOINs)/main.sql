-- Untill now, most of our queires worked with one table
-- Real application have many tables, and we need a way to connect themm
-- this is exactly what JOIN does 
-- JOIN is used to combine rows from two or more tables using a related columns

-- The basic JOIN 

-- The basic JOIN syntax

SELECT columns
FROM table1
JOIN table2
ON table1.common_column = table2.common_column;


SELECT students.name, departments.dept_name
FROM students
JOIN departments
ON students.depth_id == departments.dept_id;


students

id    name      dept_id
-----------------------
1     Rahul       101
2     Aman        102
3     Priya       101
4     Rohit       103



departments

dept_id    dept_name
--------------------
101        CSE
102        ECE
103        ME

---------------------- INNER JOIN -------------------------

SELECT columns
FROM table1
INNER JOIN table2
OR tabl1.column = table2.column;

Example : 

SELECT students.name, departments.dept_name
FROM students
INNER JOIN departments
ON students.dept_id = departments.dept_id;

-- Understand it with the help of the examples  

students

id    name      dept_id
-----------------------
1     Rahul       101
2     Aman        102
3     Priya       101
4     Rohit       103
5     Karan       999


departments

dept_id    dept_name
--------------------
101        CSE
102        ECE
103        ME


-- Karan has dept_id = 999, but there is no 999 in departments
-- Therefore INNER JOIN does not include Karan 

-- Because INNER JOIN keeps only matching rows



---------------------- LEFT JOIN ------------------------

-- Give me ALL students, even if their department does not exist

-- Syntax : 

SELECT columns
FROM table1
LEFT JOIN table2
ON table1.column = table2.column;


SELECT students.name, departments.dept_name
FROM students
LEFT JOIN departments
ON students.depth_id = departments.dept_id;

name     dept_name
------------------
Rahul    CSE
Aman     ECE
Priya    CSE
Rohit    ME
Karan    NULL


------------- Right JOIN is basically the opposite -----------------

SELECT students.name, departments.dept_name
FROM students
RIGHT JOIN departments
ON students.dept_id = departments.dept_id;

name      dept_name
-------------------
Rahul     CSE
Aman      ECE
Priya     CSE
Rohit     ME
NULL      Civil

-- RIGHT JOIN : says, keep everything from the RIGHT table
-- civil stays even though there is no student










-- Create our JOIN practice database

USE college_db;

CREATE TABLE students_join (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE course (
    id INt PRIMAARY KEY,
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollements (
    id INT PRIMARY KEY,
    student_id INT,
    course_id INT,

    FOREIGN KEY(student_id) REFERENCES students_join(id),
    FOREIGN KEY(course_id) REFERENCES courses(id)
)


-- insert data 

INSERT INTO students_join
VALUES
(1, 'Samir'),
(2, 'Rahul'),
(3, 'Aman'),
(4, 'Priya'),
(5, 'Neha'),
(6, 'Arjun');


-- Insert into courses

INSERT INTO courses
VALUES
(101, 'CSE'),
(102, 'ECE'),
(103, 'IT'),
(104, 'ME');

-- Enrollements 

INSERT INTO enrollments
VALUES
(1, 1, 101),
(2, 2, 101),
(3, 3, 102),
(4, 4, 103),
(5, 5, 101);


-- JOIN : Combine related rows from two or more tables 



































