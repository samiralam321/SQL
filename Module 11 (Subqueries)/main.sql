/*
========================================================
                SQL COURSE - MODULE 11
                    SUBQUERIES
========================================================

Topic:
- What is a Subquery?
- Subquery with =
- Subquery with >, <, >=, <=
- Subquery with AVG(), MAX(), MIN()
- Subquery with IN
- Subquery with NOT IN
- Subquery with EXISTS
- Subquery with NOT EXISTS
- Subquery inside SELECT
- Subquery inside FROM
- Correlated Subquery
- Subquery vs JOIN
========================================================
*/


/*
========================================================
1. WHAT IS A SUBQUERY?
========================================================

A subquery is a SQL query written inside another SQL query.

Basic structure:

SELECT ...
FROM ...
WHERE column > (
    SELECT ...
    FROM ...
);


Think:

MAIN QUERY
    |
    | needs some information
    ↓
SUBQUERY
    |
    | gives result
    ↓
MAIN QUERY uses that result
========================================================
*/


/*
========================================================
2. USE DATABASE
========================================================
*/

USE college_db;


/*
========================================================
3. CHECK OUR TABLE
========================================================
*/

SELECT * FROM students;


/*
Example data:

id | name   | age | course
---------------------------
1  | Samir  | 21  | CSE
2  | Rahul  | 20  | CSE
3  | Aman   | 22  | ECE
4  | Priya  | 21  | IT
5  | Neha   | 20  | CSE
6  | Arjun  | 22  | ECE
*/


/*
========================================================
4. SIMPLE QUERY WITHOUT SUBQUERY
========================================================

Find students older than 21.
========================================================
*/

SELECT *
FROM students
WHERE age > 21;


/*
Output:

Aman
Arjun
*/


/*
========================================================
5. FIND AVERAGE AGE
========================================================
*/

SELECT AVG(age) AS average_age
FROM students;


/*
Suppose result:

average_age
-----------
21


Now we want:

Find students whose age is greater than average age.

Instead of manually writing:

WHERE age > 21

we can use a subquery.
*/


/*
========================================================
6. FIRST SUBQUERY
========================================================
*/

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


/*
The inner query:

SELECT AVG(age)
FROM students;

runs first.

It returns one value.

Then conceptually the outer query becomes:

SELECT *
FROM students
WHERE age > 21;


IMPORTANT:

The query inside (...) is called SUBQUERY.
The outside query is called MAIN QUERY.
*/


/*
========================================================
7. SUBQUERY WITH AVG()
========================================================

Find students whose age is less than average age.
========================================================
*/

SELECT *
FROM students
WHERE age < (
    SELECT AVG(age)
    FROM students
);


/*
========================================================
8. SUBQUERY WITH >=
========================================================

Find students whose age is greater than
or equal to average age.
========================================================
*/

SELECT *
FROM students
WHERE age >= (
    SELECT AVG(age)
    FROM students
);


/*
========================================================
9. SUBQUERY WITH <=
========================================================
*/

SELECT *
FROM students
WHERE age <= (
    SELECT AVG(age)
    FROM students
);


/*
========================================================
10. SUBQUERY WITH =
========================================================

Find students whose age is equal to
the maximum age.
========================================================
*/

SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);


/*
If maximum age = 22

The query becomes:

SELECT *
FROM students
WHERE age = 22;


It can return:

Aman
Arjun
*/


/*
========================================================
11. FIND YOUNGEST STUDENT
========================================================
*/

SELECT *
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);


/*
========================================================
12. FIND OLDEST STUDENT
========================================================
*/

SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);


/*
========================================================
13. FIND STUDENTS OLDER THAN YOUNGEST STUDENT
========================================================
*/

SELECT *
FROM students
WHERE age > (
    SELECT MIN(age)
    FROM students
);


/*
========================================================
14. FIND STUDENTS YOUNGER THAN OLDEST STUDENT
========================================================
*/

SELECT *
FROM students
WHERE age < (
    SELECT MAX(age)
    FROM students
);


/*
========================================================
15. SUBQUERY TO FIND SAMIR'S COURSE
========================================================

First:

SELECT course
FROM students
WHERE name = 'Samir';

Suppose result:

CSE


Now find all students in the same course.
========================================================
*/

SELECT *
FROM students
WHERE course = (
    SELECT course
    FROM students
    WHERE name = 'Samir'
);


/*
Result:

Samir
Rahul
Neha
*/


/*
========================================================
16. FIND STUDENTS IN SAME COURSE AS RAHUL
========================================================
*/

SELECT *
FROM students
WHERE course = (
    SELECT course
    FROM students
    WHERE name = 'Rahul'
);


/*
========================================================
17. FIND STUDENTS IN SAME COURSE AS AMAN
========================================================
*/

SELECT *
FROM students
WHERE course = (
    SELECT course
    FROM students
    WHERE name = 'Aman'
);


/*
Aman's course = ECE

So conceptually:

SELECT *
FROM students
WHERE course = 'ECE';
*/


/*
========================================================
18. IMPORTANT PROBLEM WITH =
========================================================

Suppose subquery returns MULTIPLE values.

Example:

SELECT course
FROM students
WHERE age >= 20;


This can return:

CSE
CSE
ECE
IT
CSE
ECE

Now this is NOT suitable:

WHERE course = (
    SELECT course
    FROM students
    WHERE age >= 20
);

Why?

Because '=' expects ONE value.

For multiple values, use IN.
*/


/*
========================================================
19. IN OPERATOR
========================================================

IN checks whether a value exists
inside a list of values.

Example:
========================================================
*/

SELECT *
FROM students
WHERE course IN ('CSE', 'ECE');


/*
This means:

course = 'CSE'
OR
course = 'ECE'
*/


/*
Same query using OR:

SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'ECE';
*/


/*
========================================================
20. IN WITH SUBQUERY
========================================================

Find courses of students whose age is greater than 21.
========================================================
*/

SELECT course
FROM students
WHERE age > 21;


/*
Suppose result:

ECE
ECE

Now find all students whose course
is present in this result.
========================================================
*/

SELECT *
FROM students
WHERE course IN (
    SELECT course
    FROM students
    WHERE age > 21
);


/*
Conceptually:

SUBQUERY:

SELECT course
FROM students
WHERE age > 21;


returns:

ECE
ECE


Then main query becomes approximately:

SELECT *
FROM students
WHERE course IN ('ECE', 'ECE');
*/


/*
========================================================
21. ANOTHER IN EXAMPLE
========================================================

Find students whose course belongs to
students older than 20.
========================================================
*/

SELECT *
FROM students
WHERE course IN (
    SELECT course
    FROM students
    WHERE age > 20
);


/*
========================================================
22. NOT IN
========================================================

NOT IN means:

The value should NOT exist
in the result of the subquery.
========================================================
*/

SELECT *
FROM students
WHERE course NOT IN (
    SELECT course
    FROM students
    WHERE age > 21
);


/*
========================================================
23. SUBQUERY WITH COUNT()
========================================================

Find students if the total number of students
is greater than 5.

First:

SELECT COUNT(*)
FROM students;

Suppose result = 6.

Then:
========================================================
*/

SELECT *
FROM students
WHERE 6 > (
    SELECT COUNT(*)
    FROM students
);


/*
The above query is not very useful,
but it demonstrates that aggregate
functions can be used inside subqueries.
*/


/*
========================================================
24. SUBQUERY WITH MAX()
========================================================

Find all students having maximum age.
========================================================
*/

SELECT name, age
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);


/*
========================================================
25. SUBQUERY WITH MIN()
========================================================

Find all students having minimum age.
========================================================
*/

SELECT name, age
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);


/*
========================================================
26. SUBQUERY WITH AVG()
========================================================

Find students above average age.
========================================================
*/

SELECT name, age
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


/*
========================================================
27. SELECT ONLY NEEDED COLUMNS
========================================================
*/

SELECT
    name,
    age
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


/*
========================================================
28. SUBQUERY INSIDE SELECT
========================================================

A subquery can also be written inside SELECT.
========================================================
*/

SELECT
    name,
    age,
    (
        SELECT AVG(age)
        FROM students
    ) AS average_age
FROM students;


/*
Result conceptually:

name   age   average_age
------------------------
Samir  21    21
Rahul  20    21
Aman   22    21
Priya  21    21
Neha   20    21
Arjun  22    21
*/


/*
========================================================
29. ANOTHER SELECT SUBQUERY
========================================================
*/

SELECT
    name,
    age,
    (
        SELECT MAX(age)
        FROM students
    ) AS maximum_age
FROM students;


/*
========================================================
30. SHOW MINIMUM AND MAXIMUM AGE
========================================================
*/

SELECT
    name,
    age,
    (
        SELECT MIN(age)
        FROM students
    ) AS minimum_age,
    (
        SELECT MAX(age)
        FROM students
    ) AS maximum_age
FROM students;


/*
========================================================
31. SUBQUERY INSIDE FROM
========================================================

A subquery can behave like a temporary table.

Example:
========================================================
*/

SELECT *
FROM (
    SELECT
        name,
        age
    FROM students
    WHERE age > 20
) AS older_students;


/*
IMPORTANT:

When a subquery is used inside FROM,
we usually give it an alias.

Here:

older_students

is the alias.
*/


/*
========================================================
32. SUBQUERY INSIDE FROM WITH WHERE
========================================================
*/

SELECT *
FROM (
    SELECT
        name,
        age,
        course
    FROM students
    WHERE age > 20
) AS older_students
WHERE course = 'CSE';


/*
Think:

Step 1:

SELECT name, age, course
FROM students
WHERE age > 20;


↓

Temporary result


Step 2:

SELECT *
FROM temporary_result
WHERE course = 'CSE';
*/


/*
========================================================
33. EXISTS
========================================================

EXISTS checks whether the subquery
returns at least one row.

Syntax:

WHERE EXISTS (
    SELECT ...
);

If subquery returns at least one row:

EXISTS = TRUE

If subquery returns zero rows:

EXISTS = FALSE
========================================================
*/


/*
========================================================
34. PREPARE JOIN TABLES
========================================================

These tables were created in Module 10.

students_join

id | name
---------
1  | Samir
2  | Rahul
3  | Aman
4  | Priya
5  | Neha
6  | Arjun


enrollments

id | student_id | course_id
---------------------------
1  | 1          | 101
2  | 2          | 101
3  | 3          | 102
4  | 4          | 103
5  | 5          | 101


Arjun has no enrollment.
*/


/*
========================================================
35. EXISTS EXAMPLE
========================================================

Find students who have an enrollment.
========================================================
*/

SELECT s.name
FROM students_join s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


/*
Result:

Samir
Rahul
Aman
Priya
Neha


Arjun is NOT included.
*/


/*
========================================================
36. HOW EXISTS WORKS
========================================================

For Samir:

s.id = 1

Subquery:

SELECT 1
FROM enrollments e
WHERE e.student_id = 1;


There is a row.

Therefore:

EXISTS = TRUE


For Arjun:

s.id = 6

Subquery:

SELECT 1
FROM enrollments e
WHERE e.student_id = 6;


No row.

Therefore:

EXISTS = FALSE.
*/


/*
========================================================
37. WHY SELECT 1?
========================================================

Inside EXISTS:

SELECT 1

is commonly used.

We don't actually care
what value the subquery returns.

We only care:

Does a row exist?

Therefore:

SELECT 1

is enough.
*/


/*
========================================================
38. NOT EXISTS
========================================================

Find students who DO NOT have an enrollment.
========================================================
*/

SELECT s.name
FROM students_join s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


/*
Result:

Arjun
*/


/*
========================================================
39. EXISTS WITH DIFFERENT CONDITION
========================================================

Find students who have at least one enrollment
for course 101.
========================================================
*/

SELECT s.name
FROM students_join s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
    AND e.course_id = 101
);


/*
Result:

Samir
Rahul
Neha
*/


/*
========================================================
40. NOT EXISTS WITH COURSE
========================================================

Find students who are NOT enrolled in course 101.
========================================================
*/

SELECT s.name
FROM students_join s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
    AND e.course_id = 101
);


/*
========================================================
41. SUBQUERY VS JOIN
========================================================

Question:

Find students who have an enrollment.
========================================================
*/


/*
Using JOIN:
*/

SELECT DISTINCT s.name
FROM students_join s
INNER JOIN enrollments e
ON s.id = e.student_id;


/*
Using EXISTS:
*/

SELECT s.name
FROM students_join s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


/*
Both can give similar results.

Simple mental model:

JOIN
→ I need information from another table.

EXISTS
→ I only need to know whether related data exists.
*/


/*
========================================================
42. SUBQUERY VS JOIN EXAMPLE
========================================================

Question:

Show student name and course name.

JOIN is more natural.
========================================================
*/

SELECT
    s.name,
    c.course_name
FROM students_join s
INNER JOIN enrollments e
ON s.id = e.student_id
INNER JOIN courses c
ON e.course_id = c.id;


/*
Because we need information
from multiple tables.
*/


/*
========================================================
43. CORRELATED SUBQUERY
========================================================

A correlated subquery depends on
the current row of the outer query.

Example:
========================================================
*/

SELECT s.name
FROM students_join s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


/*
Notice:

e.student_id = s.id

s.id comes from the OUTER query.

Therefore the inner query depends
on the current outer row.

This is called a CORRELATED SUBQUERY.
*/


/*
========================================================
44. SIMPLE NON-CORRELATED SUBQUERY
========================================================

The subquery does not depend on
the outer query.
========================================================
*/

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


/*
The AVG query can run independently.

Therefore it is a non-correlated subquery.
*/


/*
========================================================
45. CORRELATED VS NON-CORRELATED
========================================================

NON-CORRELATED:

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


The subquery doesn't use
the outer query.


CORRELATED:

SELECT s.name
FROM students_join s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


The subquery uses:

s.id

from the outer query.
========================================================
*/


/*
========================================================
46. COMMON ERROR
========================================================

WRONG:

SELECT *
FROM students
WHERE age = (
    SELECT age
    FROM students
);


Why?

The subquery can return multiple rows.

Example:

21
20
22
21
20
22


But '=' expects one value.
*/


/*
CORRECT:

Use IN:
*/

SELECT *
FROM students
WHERE age IN (
    SELECT age
    FROM students
);


/*
========================================================
47. ANOTHER COMMON ERROR
========================================================

Wrong:

WHERE course = (
    SELECT course
    FROM students
    WHERE age > 20
);


If multiple rows are returned,
'=' cannot handle them.
*/


/*
Correct:

Use IN:
*/

SELECT *
FROM students
WHERE course IN (
    SELECT course
    FROM students
    WHERE age > 20
);


/*
========================================================
48. SUBQUERY WITH DISTINCT
========================================================

We can use DISTINCT inside a subquery.
========================================================
*/

SELECT *
FROM students
WHERE course IN (
    SELECT DISTINCT course
    FROM students
    WHERE age > 21
);


/*
This gives unique courses from
students older than 21.
*/


/*
========================================================
49. SUBQUERY + DISTINCT
========================================================

Find students whose course is the same
as a course used by a student older than 21.
========================================================
*/

SELECT name, course
FROM students
WHERE course IN (
    SELECT DISTINCT course
    FROM students
    WHERE age > 21
);


/*
========================================================
50. SUBQUERY + GROUP BY
========================================================

Find courses having more than 1 student.

First understand:

SELECT course, COUNT(*)
FROM students
GROUP BY course;
========================================================
*/

SELECT
    course,
    COUNT(*) AS total_students
FROM students
GROUP BY course;


/*
Now we can use a subquery to get courses
having more than 1 student.
*/


SELECT course
FROM (
    SELECT
        course,
        COUNT(*) AS total_students
    FROM students
    GROUP BY course
) AS course_count
WHERE total_students > 1;


/*
========================================================
51. SUBQUERY WITH ORDER BY
========================================================
*/

SELECT *
FROM (
    SELECT
        name,
        age
    FROM students
    ORDER BY age DESC
) AS result;


/*
Note:

In real SQL, ORDER BY inside a derived table
may not be useful unless the outer query
also needs that ordering.
*/


/*
========================================================
52. IMPORTANT SUBQUERY PATTERNS
========================================================


PATTERN 1:

Single value

WHERE column = (
    SELECT ...
);


PATTERN 2:

Single value comparison

WHERE column > (
    SELECT ...
);


PATTERN 3:

Multiple values

WHERE column IN (
    SELECT ...
);


PATTERN 4:

Exclude multiple values

WHERE column NOT IN (
    SELECT ...
);


PATTERN 5:

Check existence

WHERE EXISTS (
    SELECT ...
);


PATTERN 6:

Check non-existence

WHERE NOT EXISTS (
    SELECT ...
);
*/


/*
========================================================
53. QUICK EXAMPLES
========================================================
*/


/* Above average */

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


/* Below average */

SELECT *
FROM students
WHERE age < (
    SELECT AVG(age)
    FROM students
);


/* Maximum age */

SELECT *
FROM students
WHERE age = (
    SELECT MAX(age)
    FROM students
);


/* Minimum age */

SELECT *
FROM students
WHERE age = (
    SELECT MIN(age)
    FROM students
);


/* Same course as Samir */

SELECT *
FROM students
WHERE course = (
    SELECT course
    FROM students
    WHERE name = 'Samir'
);


/* Courses of students older than 21 */

SELECT *
FROM students
WHERE course IN (
    SELECT course
    FROM students
    WHERE age > 21
);


/* Students with enrollment */

SELECT s.name
FROM students_join s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


/* Students without enrollment */

SELECT s.name
FROM students_join s
WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.id
);


/*
========================================================
54. IMPORTANT DIFFERENCE
========================================================

WHERE:

Filters rows of the current query.

Example:

SELECT *
FROM students
WHERE age > 20;


SUBQUERY:

Gets information that the main query needs.

Example:

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


JOIN:

Combines rows/information from multiple tables.

Example:

SELECT s.name, c.course_name
FROM students_join s
JOIN enrollments e
ON s.id = e.student_id
JOIN courses c
ON e.course_id = c.id;
*/


/*
========================================================
55. EXAM IMPORTANT QUESTIONS
========================================================

1. What is a subquery?

Answer:

A subquery is a query written inside another SQL query.


2. What is the difference between main query
   and subquery?

Main query:
The outer query that produces the final result.

Subquery:
The inner query that provides data to the main query.


3. What is IN used for?

IN is used when a subquery can return
multiple values.


4. What is EXISTS used for?

EXISTS checks whether the subquery
returns at least one row.


5. What is NOT EXISTS?

It checks whether the subquery
returns zero rows.


6. What is a correlated subquery?

A correlated subquery depends on
the current row of the outer query.


7. What is a non-correlated subquery?

A non-correlated subquery can execute
independently of the outer query.
*/


/*
========================================================
56. PRACTICE QUESTIONS
========================================================

Q1.
Find students whose age is greater than
the average age.


Q2.
Find students whose age is less than
the average age.


Q3.
Find all students having the maximum age.


Q4.
Find all students having the minimum age.


Q5.
Find students who are in the same course as Samir.


Q6.
Find students whose course belongs to
a student older than 21.


Q7.
Find students whose course does NOT belong to
a student older than 21.


Q8.
Find students who have at least one enrollment.


Q9.
Find students who don't have any enrollment.


Q10.
Find students who are enrolled in course 101.


Q11.
Find students who are NOT enrolled in course 101.


Q12.
Display every student along with the average age.


Q13.
Find students older than the average age
of CSE students.


Q14.
Find courses that have more than 1 student.


Q15.
Find students whose age is equal to
the maximum age.
*/


/*
========================================================
57. FINAL CHEAT SHEET
========================================================

SUBQUERY:

Query inside another query.


ONE VALUE:

WHERE age > (
    SELECT AVG(age)
    FROM students
);


ONE VALUE:

WHERE age = (
    SELECT MAX(age)
    FROM students
);


MULTIPLE VALUES:

WHERE course IN (
    SELECT course
    FROM students
);


EXCLUDE MULTIPLE VALUES:

WHERE course NOT IN (
    SELECT course
    FROM students
);


EXISTS:

WHERE EXISTS (
    SELECT 1
    FROM enrollments
    WHERE ...
);


NOT EXISTS:

WHERE NOT EXISTS (
    SELECT 1
    FROM enrollments
    WHERE ...
);


FROM SUBQUERY:

FROM (
    SELECT ...
    FROM ...
) AS temporary_table;


========================================================

MOST IMPORTANT:

=     → usually one value
IN    → multiple values
EXISTS → check if rows exist
NOT EXISTS → check if rows don't exist

========================================================
*/