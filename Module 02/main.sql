-- Creating Database and Tables

-- Creating Database
CREATE DATABASE college_db;

-- There may be different database, so use keyowrd 'USE' to select database

-- Select Database
USE college_db;

--

CREATE DATABASE college_db;
USE college_db;


-- Create Table

CREATE TABLE students (  -- Created a table name "students"
    id INT,              -- Column Name + Data Type
    name VARCHAR(100),
    age INT
    course VARCHAR(50)
    is_active BOOLEAN 
);

-- Conceptually, MySQL creates :

students

┌────┬────────┬─────┬────────┐
│ id │ name   │ age │ course │
├────┼────────┼─────┼────────┤
│    │        │     │        │
│    │        │     │        │
│    │        │     │        │
└────┴────────┴─────┴────────┘


-- Looking at the Table Structure

DESCRIBE students;

-- We will get information similar to : 

Field    Type
-----------------------
id       int
name     varchar(100)
age      int
course   varchar(50)


----------------------  Practice --------------------------

CREATE DATABASE college_db;

-- Select database
USE college_db;

-- Show avaialbe tables
SHOW TABLES;

-- Create students table
CREATE TABLE students (
    id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);

-- Show tables
SHOW TABLES;

-- Show structure of students table
DESC students;


-------------- What is the database u created already existed, 
-- for safer side, use

CREATE DATABASE IF NOT EXISTS college_db;

-- Same for tables : 

CREATE TABLE IF NOT EXISTS students (
    id INT,
    name VARCHAR(100),
    age INT,
    course VARCHAR(50)
);


-- Our database will look like : 

college_db
│
└── students
      │
      ├── id
      ├── name
      ├── age
      └── course


