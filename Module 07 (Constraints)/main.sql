-- How do i design a database that does not allow bad data?

CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);

-- technically this works but the database
-- currently does not know important rules

Can two students have the same ID?
Can a student have no name?
Can age be negative?
Can two students have the same email?

-- so we need to tell the database these rules
-- These rules are called constraints 


User tries to insert data
          ↓
      Constraint
          ↓
     Is it valid?
       ↙     ↘
     YES      NO
      ↓        ↓
    Store    Reject

-- A database should protect itself from bad data, Constraints help enforce that protection

-- Main Constraints 

PRIMARY KEY
FOREIGN KEY
NOT NULL
UNIQUE
DEFAULT
CHECK

--------------- Primary Key --------------

-- A primary key uniquely identifies each row in a table

-- Primary key should be Unique and Not Null

-- instead of 

CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);

-- we can write 

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR (100),
    age INT,
    course VARCHAR (50)
);

-- what happens if we insert duplicated IDs

INSERT INTO students
VALUES(1, 'Samir', 21, 'CSE');

INSERT INTO students
VALUES(1,'Rahul', 20, 'CSE');

-- The database reject coz id = 1 already exists


------ AUTO_INCREMENT ---------

id INT PRIMARY KEY AUTO_INCREMENT

-- mysql automatically generates the ID

--

CREATE TABLE students (
    id INT PRIMARY KEY,  -- Primary key used to identify a row
    name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,  -- Unique ensures that values don't repeat
    age INT CHECK (age >= 0),
    course VARCHAR(50)
    is_active BOOLEAN DEFAULT TRUE  -- Default means : Use this value if the use doesn't provide one
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
    marks INT CHECK (marks >= 0 AND marks <=100)
);


--------------------- FOREIGN KEY ----------------------

students
| id | name  |
| -: | ----- |
|  1 | Samir |
|  2 | Rahul |

orders
| order_id | student_id |
| -------: | ---------: |
|      101 |          1 |
|      102 |          2 |


-- here orders.student_id -> students.id

-- the student_id in orders refers to a student
-- we can enfore that relationship with a foreign key 

--- Creating a Foregin Key

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    student_id INT,
    FOREIGN KEY(student_id) REFERENCES students(id)
);


-- THIS MEANS 

orders.student_id
        ↓
must refer to
        ↓
students.id




PRIMARY KEY → unique identity
NOT NULL    → value required
UNIQUE      → no duplicates
DEFAULT     → automatic value
CHECK       → condition must be true
FOREIGN KEY → valid relationship


























