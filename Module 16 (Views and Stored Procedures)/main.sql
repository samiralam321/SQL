============================================================
MODULE 16: VIEWS AND STORED PROCEDURES
============================================================


1. WHAT IS A VIEW?
------------------------------------------------------------

A VIEW is a virtual table created from a SQL query.

Think:

VIEW = Saved SQL Query


Example:

CREATE VIEW cse_students AS
SELECT name, age, course
FROM students
WHERE course = 'CSE';


Now we can use:

SELECT *
FROM cse_students;


The view behaves like a table when querying it.


------------------------------------------------------------
2. WHY USE VIEWS?
------------------------------------------------------------

Views are useful when:

- A query is used frequently.
- A query is complicated.
- We want to hide unnecessary columns.
- We want simpler queries.
- We want controlled access to data.


Example:

Actual table:

employees
----------------------------------------------
id | name | salary | password | phone
----------------------------------------------


We don't want to expose password.

Create:

CREATE VIEW employee_public AS
SELECT id, name, phone
FROM employees;


Now:

SELECT *
FROM employee_public;


Users can access only the required columns.


------------------------------------------------------------
3. VIEW DOES NOT USUALLY STORE DATA SEPARATELY
------------------------------------------------------------

A normal view is mainly a saved query definition.

Example:

employees
    ↓
   VIEW
    ↓
employee_public


If the underlying table changes,
the view generally reflects those changes.


------------------------------------------------------------
4. CREATE A VIEW
------------------------------------------------------------

Syntax:

CREATE VIEW view_name AS
SELECT ...
FROM ...;


Example:

CREATE VIEW cse_students AS
SELECT id, name, age
FROM students
WHERE course = 'CSE';


Use it:

SELECT *
FROM cse_students;


Filter it:

SELECT *
FROM cse_students
WHERE age > 20;


Sort it:

SELECT *
FROM cse_students
ORDER BY age DESC;


------------------------------------------------------------
5. VIEW WITH JOIN
------------------------------------------------------------

A view can contain JOINs.

Example:

CREATE VIEW student_courses AS
SELECT
    s.name,
    c.course_name
FROM students_join s
JOIN enrollments e
    ON s.id = e.student_id
JOIN courses c
    ON e.course_id = c.id;


Now instead of writing the complete JOIN:

SELECT *
FROM student_courses;


This makes frequently used complex queries easier.


------------------------------------------------------------
6. MODIFY A VIEW
------------------------------------------------------------

Use:

CREATE OR REPLACE VIEW view_name AS
SELECT ...


Example:

CREATE OR REPLACE VIEW cse_students AS
SELECT id, name, age, course
FROM students
WHERE course = 'CSE';


------------------------------------------------------------
7. DELETE A VIEW
------------------------------------------------------------

DROP VIEW view_name;


Example:

DROP VIEW cse_students;


IMPORTANT:

DROP VIEW deletes only the view.

The original table still exists.


------------------------------------------------------------
8. WHAT IS A STORED PROCEDURE?
------------------------------------------------------------

A STORED PROCEDURE is a group of SQL statements
stored inside the database.

Think:

STORED PROCEDURE = Saved SQL Program


Instead of repeatedly writing multiple SQL statements,
we can call the procedure.


Flow:

Application
    ↓
CALL procedure
    ↓
Database
    ↓
Execute SQL statements


------------------------------------------------------------
9. BASIC STORED PROCEDURE
------------------------------------------------------------

Example:

DELIMITER //

CREATE PROCEDURE get_students()
BEGIN

    SELECT *
    FROM students;

END //

DELIMITER ;


Execute:

CALL get_students();


------------------------------------------------------------
10. WHY DO WE USE DELIMITER?
------------------------------------------------------------

Normally MySQL uses:

;


But a procedure contains multiple SQL statements:

BEGIN

    SELECT ...;
    UPDATE ...;
    INSERT ...;

END


So we temporarily change the delimiter:

DELIMITER //


After creating the procedure:

DELIMITER ;


Remember:

DELIMITER changes how MySQL recognizes
the END of the SQL statement.


------------------------------------------------------------
11. STORED PROCEDURE WITH PARAMETER
------------------------------------------------------------

We can pass values to procedures.

Example:

DELIMITER //

CREATE PROCEDURE get_students_by_course(
    IN course_name VARCHAR(50)
)
BEGIN

    SELECT *
    FROM students
    WHERE course = course_name;

END //

DELIMITER ;


Call:

CALL get_students_by_course('CSE');


Here:

IN course_name VARCHAR(50)

means course_name is an input parameter.


------------------------------------------------------------
12. IN, OUT AND INOUT
------------------------------------------------------------

IN
---

Used to pass a value INTO the procedure.

Example:

IN course_name VARCHAR(50)


OUT
---

Used to return a value FROM the procedure.

Example:

OUT total INT


INOUT
-----

Can be used for both input and output.

Example:

INOUT value INT


For beginners:

Focus mainly on IN parameters first.


------------------------------------------------------------
13. STORED PROCEDURE WITH UPDATE
------------------------------------------------------------

Example:

DELIMITER //

CREATE PROCEDURE increase_salary(
    IN employee_id INT,
    IN amount DECIMAL(10,2)
)
BEGIN

    UPDATE employees
    SET salary = salary + amount
    WHERE id = employee_id;

END //

DELIMITER ;


Call:

CALL increase_salary(1, 5000);


This increases employee 1's salary by 5000.


------------------------------------------------------------
14. STORED PROCEDURE CAN CONTAIN MULTIPLE STATEMENTS
------------------------------------------------------------

Example:

DELIMITER //

CREATE PROCEDURE employee_operation()
BEGIN

    SELECT *
    FROM employees;

    UPDATE employees
    SET salary = salary + 1000
    WHERE id = 1;

END //

DELIMITER ;


A procedure can contain:

SELECT
INSERT
UPDATE
DELETE

and other SQL statements.


------------------------------------------------------------
15. DELETE A STORED PROCEDURE
------------------------------------------------------------

DROP PROCEDURE procedure_name;


Example:

DROP PROCEDURE get_students;


This removes the procedure from the database.


------------------------------------------------------------
16. VIEW VS STORED PROCEDURE
------------------------------------------------------------

VIEW
------------------------------------------------------------

VIEW
↓
Virtual Table
↓
Saved Query
↓
Mainly used for querying data
↓
Can be used with SELECT


STORED PROCEDURE
------------------------------------------------------------

STORED PROCEDURE
↓
Saved SQL Logic
↓
Can contain multiple statements
↓
Can accept parameters
↓
Can perform SELECT, INSERT, UPDATE, DELETE


EASY WAY TO REMEMBER:

VIEW
= Saved Query


STORED PROCEDURE
= Saved SQL Program


------------------------------------------------------------
17. REAL BACKEND EXAMPLE
------------------------------------------------------------

Suppose an e-commerce database has:

users
products
orders
order_items


A VIEW can provide:

User Name
Order ID
Product
Amount
Order Date


without repeatedly writing a complicated JOIN.


A STORED PROCEDURE could perform:

Create Order
    ↓
Insert Order
    ↓
Insert Order Items
    ↓
Update Stock


This can group multiple database operations.


------------------------------------------------------------
18. VIEW VS TABLE
------------------------------------------------------------

TABLE
------------------------------------------------------------

- Stores actual data.
- Data physically belongs to the table.
- Can INSERT, UPDATE and DELETE data directly.


VIEW
------------------------------------------------------------

- Virtual representation of data.
- Based on a query.
- Usually does not store a separate copy of the data.
- Used mainly to simplify access to data.


------------------------------------------------------------
19. IMPORTANT COMMANDS
------------------------------------------------------------

CREATE VIEW:

CREATE VIEW view_name AS
SELECT ...


USE VIEW:

SELECT *
FROM view_name;


MODIFY VIEW:

CREATE OR REPLACE VIEW view_name AS
SELECT ...


DELETE VIEW:

DROP VIEW view_name;


CREATE PROCEDURE:

DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN

    SQL statements;

END //

DELIMITER ;


CALL PROCEDURE:

CALL procedure_name();


DELETE PROCEDURE:

DROP PROCEDURE procedure_name;


------------------------------------------------------------
20. INTERVIEW QUESTIONS
------------------------------------------------------------

Q1. What is a View?

A View is a virtual table based on a SQL query.


Q2. Does a View usually store a separate copy of data?

No. A normal view primarily stores the query definition.


Q3. Why are Views used?

To simplify complex queries, reuse queries and control
which data is exposed.


Q4. What is a Stored Procedure?

A Stored Procedure is a group of SQL statements stored
inside the database.


Q5. What is DELIMITER?

It temporarily changes the statement delimiter so MySQL
can correctly process multiple statements inside a
stored procedure.


Q6. What is the difference between View and Stored Procedure?

View:
    Saved Query / Virtual Table

Stored Procedure:
    Saved SQL Logic / Program


Q7. Can a Stored Procedure accept parameters?

Yes.

Example:

IN course_name VARCHAR(50)


Q8. How do you execute a Stored Procedure?

CALL procedure_name();


------------------------------------------------------------
21. FINAL CHEAT SHEET
------------------------------------------------------------

VIEW
    ↓
Virtual Table
    ↓
Saved Query


CREATE VIEW
    ↓

CREATE VIEW view_name AS
SELECT ...


USE VIEW
    ↓

SELECT *
FROM view_name;


DROP VIEW
    ↓

DROP VIEW view_name;



STORED PROCEDURE
    ↓
Saved SQL Logic
    ↓
Can accept parameters
    ↓
Can contain multiple SQL statements


CREATE PROCEDURE
    ↓

DELIMITER //

CREATE PROCEDURE procedure_name()
BEGIN
    SQL statements;
END //

DELIMITER ;


CALL
    ↓

CALL procedure_name();


DROP PROCEDURE
    ↓

DROP PROCEDURE procedure_name;



============================================================
MODULE 16 COMPLETE
============================================================











- This module is about two useful MySQL features:

-- Views → Save a query as a virtual table.
-- Stored Procedures → Save SQL logic inside the database and execute it when needed.

--- View : A View is a virtual table created from a SQL query

-- suppose we have 

SELECT name, age, course
FROM students
WHERE course = 'CSE';

-- and if we frequenlty need this query, we can create a view

CREATE VIEW cse_student AS
SELECT name, age, course
FROM students
WHERE course = 'CSE;

-- now we can simply write : 

-- SELECT *
-- FROM cse_students;

-- 2. Why use Views?

-- Views are useful when:

-- A query is used frequently.
-- A query is complicated.
-- You want to hide unnecessary columns.
-- You want to simplify database access.
-- You want to provide controlled access to data.


CREATE VIEW employee_public AS
SELECT id, name, phone
FROM employees;

-- users can query
SELECT *
FROM employee_public;




















