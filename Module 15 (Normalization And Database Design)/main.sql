-- Normalization : is about organizing database tables
-- properly so that we reduce the duplicated and avoid data-realted problem

-- suppose we have a table 

Student
------------------------------------------------
Student_ID | Name  | Course | Teacher | Teacher_Phone
------------------------------------------------
1          | Samir | CSE    | Ravi    | 9876543210
2          | Rahul | CSE    | Ravi    | 9876543210
3          | Aman  | CSE    | Ravi    | 9876543210


-- if Ravi's phone number changes, we have to update multiple rows

--- Primary Key : Uniquely identifes a row
--- Foreign Key : Connects one table to another 

============================================================
MODULE 15: NORMALIZATION AND DATABASE DESIGN
============================================================

1. WHAT IS NORMALIZATION?
------------------------------------------------------------

Normalization is the process of organizing database tables
to:

- Reduce duplicate data
- Avoid data inconsistency
- Prevent update, insert and delete anomalies
- Make the database easier to maintain

Main levels:

1NF → First Normal Form
2NF → Second Normal Form
3NF → Third Normal Form


------------------------------------------------------------
2. PROBLEM WITHOUT NORMALIZATION
------------------------------------------------------------

Suppose we have:

Students
------------------------------------------------------------
Student_ID | Name  | Course | Teacher | Teacher_Phone
------------------------------------------------------------
1          | Samir | CSE    | Ravi    | 9876543210
2          | Rahul | CSE    | Ravi    | 9876543210
3          | Aman  | CSE    | Ravi    | 9876543210
------------------------------------------------------------

Teacher information is repeated.

If Ravi's phone number changes, we need to update
multiple rows.

This can create:

1. Update Anomaly
2. Insert Anomaly
3. Delete Anomaly


------------------------------------------------------------
3. ANOMALIES
------------------------------------------------------------

A) UPDATE ANOMALY
-----------------

Same information is stored in multiple rows.

If Ravi's phone number changes:

9876543210 → 9999999999

We need to update many rows.

If we forget one row, data becomes inconsistent.


B) INSERT ANOMALY
-----------------

Suppose we want to add a new teacher.

But the table requires Student_ID.

We cannot add the teacher properly without also
having student information.


C) DELETE ANOMALY
-----------------

Suppose Aman is the only student enrolled in a course.

If we delete Aman's record, we may accidentally
lose information about that course or teacher.


------------------------------------------------------------
4. FIRST NORMAL FORM (1NF)
------------------------------------------------------------

A table is in 1NF when:

- Each cell contains a single value.
- Values are atomic.
- No multiple values are stored in one cell.
- No repeating groups.


BAD:

Student_ID | Name  | Skills
------------------------------------
1          | Samir | C++, Python, SQL


The Skills column contains multiple values.


GOOD:

Student_ID | Skill
-------------------
1          | C++
1          | Python
1          | SQL


REMEMBER:

1NF = Atomic values


------------------------------------------------------------
5. SECOND NORMAL FORM (2NF)
------------------------------------------------------------

A table must:

1. Already be in 1NF.
2. Have no Partial Dependency.

Partial dependency mainly occurs when we have
a COMPOSITE PRIMARY KEY.


Example:

Student_ID + Course_ID → Grade

But:

Student_ID → Student_Name


Student_Name depends only on Student_ID,
not on the complete key.

This is Partial Dependency.


BAD DESIGN:

Student_ID | Course_ID | Student_Name | Course_Name | Grade
------------------------------------------------------------
1          | 101       | Samir        | DBMS        | A
1          | 102       | Samir        | OS          | B


Better design:


Students
-------------------------
Student_ID | Student_Name


Courses
-------------------------
Course_ID | Course_Name


Enrollments
-------------------------
Student_ID | Course_ID | Grade


REMEMBER:

2NF = Remove Partial Dependency


------------------------------------------------------------
6. THIRD NORMAL FORM (3NF)
------------------------------------------------------------

A table must:

1. Already be in 2NF.
2. Have no Transitive Dependency.


Example:

Student_ID → Department_ID

Department_ID → Department_Name


Therefore:

Student_ID → Department_Name

indirectly.

This is Transitive Dependency.


BAD:

Students
-------------------------------------------
Student_ID | Name | Department_ID | Department_Name


GOOD:

Students
--------------------------------
Student_ID | Name | Department_ID


Departments
--------------------------------
Department_ID | Department_Name


REMEMBER:

3NF = Remove Transitive Dependency


------------------------------------------------------------
7. EASY WAY TO REMEMBER NORMAL FORMS
------------------------------------------------------------

1NF
↓
Atomic values
↓
Remove multiple values from one cell


2NF
↓
No Partial Dependency
↓
Every non-key attribute depends on the
complete primary key


3NF
↓
No Transitive Dependency
↓
Non-key attributes should not depend on
other non-key attributes


SHORT VERSION:

1NF → Atomic
2NF → No Partial Dependency
3NF → No Transitive Dependency


------------------------------------------------------------
8. FUNCTIONAL DEPENDENCY
------------------------------------------------------------

Functional dependency means one attribute determines
another attribute.


Example:

Student_ID → Student_Name


Meaning:

If we know Student_ID,
we can determine Student_Name.


Another example:

Department_ID → Department_Name


Meaning:

If we know Department_ID,
we can determine Department_Name.


------------------------------------------------------------
9. PRIMARY KEY
------------------------------------------------------------

A Primary Key uniquely identifies each row.

Example:

CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100)
);


student_id:

1 → Samir
2 → Rahul
3 → Aman


Each student_id is unique.


------------------------------------------------------------
10. FOREIGN KEY
------------------------------------------------------------

A Foreign Key connects two tables.

Example:

CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);


CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES departments(department_id)
);


Relationship:

Students
    |
    | department_id
    ↓
Departments


------------------------------------------------------------
11. REAL DATABASE DESIGN EXAMPLE
------------------------------------------------------------

Instead of putting everything into one table:


Students
------------------------------------------------------------
Student_ID | Name | Course | Teacher | Phone
------------------------------------------------------------


Create separate tables:


Students
--------------------------------
Student_ID | Name | Course_ID


Courses
--------------------------------
Course_ID | Course_Name | Teacher_ID


Teachers
--------------------------------
Teacher_ID | Teacher_Name | Phone


Relationships:

Students
    |
    | Course_ID
    ↓
Courses
    |
    | Teacher_ID
    ↓
Teachers


This reduces duplication.


------------------------------------------------------------
12. NORMALIZATION VS DENORMALIZATION
------------------------------------------------------------

NORMALIZATION:

- Reduces duplicate data
- Improves data consistency
- Creates more tables
- Usually requires more JOINs
- Easier to maintain


DENORMALIZATION:

- Intentionally duplicates some data
- Can reduce JOINs
- Can improve read performance in some workloads
- Requires more storage
- Can make updates more complicated


Example:

Normalized:

Users
Orders
Products


Denormalized:

Orders table may also store some product information
to avoid repeatedly joining Products.


In real-world systems, both approaches can be used.


------------------------------------------------------------
13. IMPORTANT INTERVIEW QUESTIONS
------------------------------------------------------------

Q1. What is normalization?

Normalization is the process of organizing database tables
to reduce redundancy and avoid data anomalies.


Q2. What is 1NF?

1NF requires atomic values and no repeating groups.


Q3. What is 2NF?

2NF means:

1. Table is in 1NF.
2. No partial dependency exists.


Q4. What is 3NF?

3NF means:

1. Table is in 2NF.
2. No transitive dependency exists.


Q5. What is partial dependency?

When a non-key attribute depends only on part of a
composite primary key.


Q6. What is transitive dependency?

When a non-key attribute depends on another non-key
attribute.


Q7. Why is normalization useful?

It reduces data duplication and prevents update,
insert and delete anomalies.


Q8. What is denormalization?

Intentionally adding some redundancy to improve
performance or simplify reads.


------------------------------------------------------------
14. FINAL CHEAT SHEET
------------------------------------------------------------

NORMALIZATION
    ↓
Organize tables
    ↓
Reduce redundancy
    ↓
Avoid anomalies


1NF
    ↓
Atomic values


2NF
    ↓
1NF + No Partial Dependency


3NF
    ↓
2NF + No Transitive Dependency


FUNCTIONAL DEPENDENCY
    ↓
One attribute determines another


PRIMARY KEY
    ↓
Uniquely identifies a row


FOREIGN KEY
    ↓
Connects tables


NORMALIZATION
    ↓
Less duplication
More tables
More JOINs


DENORMALIZATION
    ↓
More duplication
Fewer JOINs
Potentially faster reads


============================================================
MODULE 15 COMPLETE
============================================================






































