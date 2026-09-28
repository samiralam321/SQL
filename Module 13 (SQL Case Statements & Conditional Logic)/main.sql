CASE
    WHEN conditions THEN result
    ELSE result
END

---

SELECT
    name,
    age,
    CASE
    WHEN age >= 21 THEN 'Adult'
    ELSE 'Young'

    END AS age_group
FROM students;

name   | age | age_group
-------------------------
Samir  | 21  | Adult
Rahul  | 20  | Young
Aman   | 22  | Adult
Priya  | 21  | Adult
Neha   | 20  | Young
Arjun  | 22  | Adult


SELECT 
    name,
    CASE
       WHEN age >= 21 THEN 'Adult'
       ELSE 'Young'
    END AS category
FROM students



-- CASE with Multiple Conditions 

SELECT
    name,
    age,
    CASE
       WHEN age < 20 THEN 'Teen'
       WHEN age <= 21 THEN 'Young Adult'
       WHEN age <= 25 THEN 'Adult'
       ELSE 'Older Adult'
    END as age_group
FROM students;

-- SQL checks the conditions from top to buttom

if - WHEN
condition - condition
result -> THEN
else -> ELSE

-- ELSE is optional 

SELECT
    name,
    CASE
       WHEN age >= 21 THEN 'Adult'
    END AS category
FROM students;


-- CASE with Numbers

SELECT
    name,
    age,
    CASE
        WHEN age >= 21 THEN 1
        ELSE 0
    END AS is_adult
FROM students


-- CASE with Courses

SELECT
    name,
    course,
    CASE
        WHEN course = 'CSE' THEN 'Computer Science'
        WHEN course = 'ECE' THEN 'Electronics'
        WHEN course = 'IT' THEN 'Information Technology'
        ELSE 'Other'
    END AS course_name
FROM students;

SELECT
    name,
    age,
    CASE
        WHEN age > 21 THEN 'Above 21'
        WHEN age = 21 THEN 'Exactly 21'
        ELSE 'Below 21'
    END AS age_status
FROM students;


-- CASE with AND

SELECT
    name,
    age,
    course,
    CASE
        WHEN age >= 21 AND course = 'CSE'
            THEN 'CSE Adult'
        ELSE 'Other'
    END AS category
FROM students;


-- CASE with OR

SELECT
    name,
    course,
    CASE
        WHEN course = 'CSE' OR course = 'ECE'
            THEN 'Engineering'
        ELSE 'Other'
    END AS category
FROM students;

--- CASE with IN

SELECT
    name,
    course,
    CASE
        WHEN course IN ('CSE', 'ECE', 'IT')
            THEN 'Engineering'
        ELSE 'Other'
    END AS category
FROM students;


--- CASE with Between

SELECT
    name,
    age,
    CASE
        WHEN age BETWEEN 18 AND 20 THEN 'Young'
        WHEN age BETWEEN 21 AND 25 THEN 'Adult'
        ELSE 'Other'
    END AS age_group
FROM students;


--- CASE in ORDER By

SELECT *
FROM students
ORDER BY
    CASE
        WHEN course = 'CSE' THEN 1
        WHEN course = 'ECE' THEN 2
        WHEN course = 'IT' THEN 3
        ELSE 4
    END;


--- COUNT() with CASE

SELECT
    COUNT(
        CASE
            WHEN course = 'CSE' THEN 1
        END
    ) AS cse_students
FROM students;

--- COUNT Multiple Conditions ------------

SELECT
    COUNT(
        CASE
            WHEN course = 'CSE' THEN 1
        END
    ) AS cse_students,

    COUNT(
        CASE
            WHEN course = 'ECE' THEN 1
        END
    ) AS ece_students,

    COUNT(
        CASE
            WHEN course = 'IT' THEN 1
        END
    ) AS it_students

FROM students;

cse_students | ece_students | it_students
-------------------------------------------
3            | 2            | 1


-- SUM() with CASE ------------------

SELECT
    SUM(
        CASE
           WHEN course = 'CSE' THEN 1
           ELSE 0
        END
    ) AS cse_students

FROM student;

---------- CASE with SUM() ---------------

SELECT
    SUM(
        CASE
            WHEN salary > 50000 THEN slary
            ELSE 0
        END
    ) AS high_salary_total

FROM employee;


---- CASE with AVG()

SELECT
    AVG(
        CASE
            WHEN course = 'CSE' THEN age
        END
    ) AS cse_average_age
   
FROM students;


------------- CASE with NULL ---------------

SELECT
    name,
    CASE
        WHEN email IS NULL THEN 'No Email'
        ELSE 'Email Available'
    END AS email_status

FROM users;

------------ Simple CASE Expression ---------------

SELECT 
    name,
    course,
    CASE course
         WHEN 'CSE' THEN 'Computer Science'
         WHEN 'ECE' THEN 'ELectronics'
         WHEN 'IT' THEN 'Information Technology'
         ELSE 'Other'
    END AS course_name
FROM students;


--- CASE does not remove the row 
-- It creates a value

SELECT
    name,
    age,
    CASE
        WHEN age >= 21 THEN 'Adult'
        ELSE 'Young'
    END AS category
FROM students;



--- Real Backedn Example : Order Status -------------

orders

id | status
------------
1  | shipped
2  | pending
3  | delivered
4  | cancelled


SELECT
    id,
    CASE status
        WHEN 'shipped' THEN 'Your order has been shipped'
        WHEN 'pending' THEN 'Your order is being processed'
        WHEN 'delivered' THEN 'Your order has been delivered'
        WHEN 'cancelled' THEN 'Your order was cancelled'
        ELSE 'Unknown status'
    END AS message
FROM orders;


----------------- Salary Category ----------------------

SELECT
    name,
    salary,
    CASE
        WHEN salary < 40000 THEN 'LOW'
        WHEN salary <= 60000 THEN 'Medium'
        ELSE 'High'
    END AS salary_category

FROM employees;
    
Samir  | 50000 | Medium
Rahul  | 60000 | Medium
Aman   | 45000 | Medium
Priya  | 70000 | High

--------------- Student Performance ----------------

name   | marks
--------------
Samir  | 85
Rahul  | 72
Aman   | 55
Priya  | 38


SELECT
    name,
    marks,

    CASE
       WHEN marks >= 80 THEN 'Excellent'
       WHEN marks >=60 THEN 'Good'
       WHEN marks >= 40 THEN 'Average'
       ELSE 'Fail'
    END AS performance

FROM students_marks;

-- Result ---
Samir  | 85 | Excellent
Rahul  | 72 | Good
Aman   | 55 | Average
Priya  | 38 | Fail


-------------- Conditional Counting -----------

COUNT (
    CASE
       WHEN course = 'CSE' THEN 1
    END
)

------------ Conditional Sum ----------------

SUM (
    CASE
       WHEN salary > 50000 THEN salary
       ELSE 0
    END
)


------------- One line you should Remember ------------------

CASE
   WHEN condition THEN result
   ELSE result
END




























