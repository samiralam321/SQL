--------------------- INSERT and SELECT -----------------

CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);

-- This creates only table and it is empty, now we can add data 
-- using insertion or select the data 


-- INSERT

INSERT INTO students
VALUES(1,'Samir',21,'CSE');

-- INSERT More Students

INSERT INTO students
VALUES(2,'Rahul',20, 'CSE');

-- INSERT Rows in one INSERT

INSERT INTO students
VALUES
(4, 'Priya', 21, 'IT'),
(5, 'Neha', 20, 'CSE'),
(6, 'Arjun', 22, 'ECE');

-- Safe Approach ---

INSERT INTO students(id, name, age, course)
VALUES(1,'Samir',21,'CSE');

-- Column Order May Change

INSERT INTO students(name,age,course,id)
VALUES('Samir',21,'CSE',1);

------------ Select --------------

SELECT * FROM students -- * means select all columns
-- Select everything from the students table

------------ Selecting Specific Columns ----------------

SELECT name
FROM students;

-- Result

Samir
Rahul
Aman
Priya
Neha
Arjun


-------- Select Two Columns --------------

SELECT name,age
FROM students;

| name  | age |
| ----- | --: |
| Samir |  21 |
| Rahul |  20 |
| Aman  |  22 |
| Priya |  21 |
| Neha  |  20 |
| Arjun |  22 |


-- Select Three Columns ---

SELECT name,age,course
FROM sudents;

| name  | age | course |
| ----- | --: | ------ |
| Samir |  21 | CSE    |
| Rahul |  20 | CSE    |
| Aman  |  22 | ECE    |
| Priya |  21 | IT     |
| Neha  |  20 | CSE    |
| Arjun |  22 | ECE    |


--- Select Structure -------

SELECT columns
FROM table;

-- Select with Calculations -------

SELECT name,age+1
FROM students;

| name  | age + 1 |
| ----- | ------: |
| Samir |      22 |
| Rahul |      21 |
| Aman  |      23 |
| Priya |      22 |
| Neha  |      21 |
| Arjun |      23 |

-- It does not permanently change the age column


--- Better way to write this ----

SELECT name, age+1 AS next_age
FROM students;

| name  | next_age |
| ----- | -------: |
| Samir |       22 |
| Rahul |       21 |
| Aman  |       23 |


-- Select did not modify anything 














