# MODULE 12: SQL STRING, DATE & MATHEMATICAL FUNCTIONS

---

## 1. What are SQL Functions?

A SQL function takes some input and returns an output.

Basic idea:

Input → Function → Output

Example:

SELECT UPPER('samir');

Output:
SAMIR

SQL functions are mainly divided into:

1. String Functions
2. Date & Time Functions
3. Mathematical Functions

---

# PART 1: STRING FUNCTIONS

String functions are used to work with text.

Important String Functions:

UPPER()
LOWER()
LENGTH()
TRIM()
LTRIM()
RTRIM()
CONCAT()
CONCAT_WS()
SUBSTRING()
LEFT()
RIGHT()
REPLACE()

---

## 2. UPPER()

Converts text into uppercase.

Syntax:

UPPER(string)

Example:

SELECT UPPER('samir');

Output:

SAMIR

Example:

SELECT UPPER('hello world');

Output:

HELLO WORLD

Using with table:

SELECT
    name,
    UPPER(name) AS uppercase_name
FROM students;

Example result:

name    | uppercase_name
-----------------------
Samir   | SAMIR
Rahul   | RAHUL
Aman    | AMAN

---

## 3. LOWER()

Converts text into lowercase.

Example:

SELECT LOWER('SAMIR');

Output:

samir

Using with table:

SELECT
    name,
    LOWER(name) AS lowercase_name
FROM students;

---

## 4. UPPER() / LOWER() with WHERE

Functions can be used inside WHERE.

Example:

SELECT *
FROM students
WHERE LOWER(name) = 'samir';

This can match:

SAMIR
Samir
samir
SaMiR

because LOWER() converts the value into lowercase before comparison.

Another example:

SELECT *
FROM students
WHERE UPPER(course) = 'CSE';

---

# 5. LENGTH()

Returns the number of characters in a string.

Example:

SELECT LENGTH('Samir');

Output:

5

Example:

SELECT LENGTH('Hello World');

Output:

11

The space is also counted.

Using with table:

SELECT
    name,
    LENGTH(name) AS name_length
FROM students;

---

## LENGTH() with WHERE

Find students whose name has more than 4 characters:

SELECT *
FROM students
WHERE LENGTH(name) > 4;

Find students whose name has exactly 5 characters:

SELECT *
FROM students
WHERE LENGTH(name) = 5;

---

# 6. TRIM()

TRIM() removes spaces from the beginning and end of a string.

Example:

SELECT TRIM('   Samir   ');

Output:

Samir

Without TRIM:

"   Samir   "

With TRIM:

"Samir"

TRIM() is useful for cleaning user input.

---

# 7. LTRIM()

LTRIM() removes spaces from the left side.

Example:

SELECT LTRIM('   Samir');

Output:

Samir

Mental model:

LTRIM()
← removes spaces from left

---

# 8. RTRIM()

RTRIM() removes spaces from the right side.

Example:

SELECT RTRIM('Samir   ');

Output:

Samir

Mental model:

RTRIM()
removes spaces from right →

---

# 9. TRIM() vs LTRIM() vs RTRIM()

TRIM()
→ removes spaces from both sides

LTRIM()
→ removes spaces from left side

RTRIM()
→ removes spaces from right side

Example:

SELECT TRIM('   Samir   ');

SELECT LTRIM('   Samir   ');

SELECT RTRIM('   Samir   ');

---

# 10. CONCAT()

CONCAT() combines multiple strings.

Syntax:

CONCAT(value1, value2, value3, ...)

Example:

SELECT CONCAT('Samir', ' ', 'Alam');

Output:

Samir Alam

Another example:

SELECT CONCAT('Hello', ' ', 'World');

Output:

Hello World

Using with table:

SELECT
    CONCAT(name, ' - ', course) AS student_info
FROM students;

Example:

Samir - CSE
Rahul - CSE
Aman - ECE

---

# 11. CONCAT_WS()

CONCAT_WS() means:

CONCAT With Separator

Syntax:

CONCAT_WS(separator, value1, value2, value3, ...)

Example:

SELECT CONCAT_WS(' - ', 'Samir', 'CSE', '21');

Output:

Samir - CSE - 21

Another example:

SELECT CONCAT_WS(', ', 'Samir', 'Punjab', 'India');

Output:

Samir, Punjab, India

---

# 12. SUBSTRING()

SUBSTRING() extracts a part of a string.

Syntax:

SUBSTRING(string, start, length)

Example:

SELECT SUBSTRING('Samir', 1, 3);

Output:

Sam

Another:

SELECT SUBSTRING('Samir', 3, 2);

Output:

mi

Important:

SQL string positions generally start from 1.

Samir

1 2 3 4 5
S a m i r

---

## SUBSTRING() with Table

SELECT
    name,
    SUBSTRING(name, 1, 2) AS first_two_letters
FROM students;

Example:

Samir → Sa
Rahul → Ra
Aman  → Am
Priya → Pr

---

# 13. LEFT()

LEFT() returns characters from the beginning of a string.

Syntax:

LEFT(string, number_of_characters)

Example:

SELECT LEFT('Samir', 2);

Output:

Sa

Example:

SELECT LEFT('Computer', 4);

Output:

Comp

Using with table:

SELECT
    name,
    LEFT(name, 2) AS first_two_letters
FROM students;

---

# 14. RIGHT()

RIGHT() returns characters from the end of a string.

Example:

SELECT RIGHT('Samir', 2);

Output:

ir

Example:

SELECT RIGHT('Computer', 4);

Output:

uter

Using with table:

SELECT
    name,
    RIGHT(name, 2) AS last_two_letters
FROM students;

---

# 15. LEFT() vs RIGHT()

LEFT()
→ takes characters from the beginning

RIGHT()
→ takes characters from the end

Example:

Samir

LEFT('Samir', 2)
→ Sa

RIGHT('Samir', 2)
→ ir

---

# 16. REPLACE()

REPLACE() replaces part of a string with another string.

Syntax:

REPLACE(string, old_value, new_value)

Example:

SELECT REPLACE('Hello World', 'World', 'Samir');

Output:

Hello Samir

Another example:

SELECT REPLACE('I like Java', 'Java', 'Python');

Output:

I like Python

---

## REPLACE() with table

SELECT
    name,
    REPLACE(course, 'CSE', 'Computer Science') AS course_name
FROM students;

IMPORTANT:

SELECT + REPLACE()
→ changes only the displayed result

UPDATE + REPLACE()
→ actually changes the stored data

Example:

UPDATE students
SET course = REPLACE(course, 'CSE', 'Computer Science')
WHERE course = 'CSE';

Be careful with UPDATE.

---

# 17. Combining String Functions

SQL functions can be nested.

Example:

SELECT UPPER(TRIM(name)) AS clean_name
FROM students;

Processing:

name
↓
TRIM()
↓
UPPER()
↓
final result

Example:

"   samir   "
↓
"samir"
↓
"SAMIR"

Final:

SAMIR

Another example:

SELECT
    LOWER(TRIM(name)) AS clean_name,
    LENGTH(TRIM(name)) AS name_length
FROM students;

---

# PART 2: DATE & TIME FUNCTIONS

---

# 18. SQL Date Format

A common SQL date format is:

YYYY-MM-DD

Example:

2026-09-27

Meaning:

YYYY = 2026
MM   = 09
DD   = 27

---

# 19. CURDATE()

Returns the current date.

Example:

SELECT CURDATE();

Example output:

2026-09-27

The actual result depends on the current date.

---

# 20. CURRENT_DATE()

Another way to get the current date.

SELECT CURRENT_DATE();

---

# 21. CURTIME()

Returns the current time.

SELECT CURTIME();

Example:

14:30:15

---

# 22. NOW()

Returns the current date and time.

SELECT NOW();

Example:

2026-09-27 14:30:15

Difference:

CURDATE()
→ current date only

CURTIME()
→ current time only

NOW()
→ current date + time

---

# 23. YEAR()

Extracts the year from a date.

SELECT YEAR('2026-09-27');

Output:

2026

---

# 24. MONTH()

Extracts the month from a date.

SELECT MONTH('2026-09-27');

Output:

9

---

# 25. DAY()

Extracts the day from a date.

SELECT DAY('2026-09-27');

Output:

27

---

# 26. HOUR()

Extracts the hour.

SELECT HOUR('2026-09-27 14:30:45');

Output:

14

---

# 27. MINUTE()

Extracts the minute.

SELECT MINUTE('2026-09-27 14:30:45');

Output:

30

---

# 28. SECOND()

Extracts the seconds.

SELECT SECOND('2026-09-27 14:30:45');

Output:

45

---

# 29. Create Employees Table

We can use this table to practice date functions.

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    joining_date DATE
);

Insert data:

INSERT INTO employees
VALUES
(1, 'Samir', 50000.00, '2023-07-10'),
(2, 'Rahul', 60000.00, '2022-03-15'),
(3, 'Aman', 45000.00, '2024-01-20'),
(4, 'Priya', 70000.00, '2021-11-05');

Check table:

SELECT *
FROM employees;

---

# 30. YEAR() with Table

SELECT
    name,
    joining_date,
    YEAR(joining_date) AS joining_year
FROM employees;

Example result:

Samir | 2023-07-10 | 2023
Rahul | 2022-03-15 | 2022
Aman  | 2024-01-20 | 2024
Priya | 2021-11-05 | 2021

---

# 31. MONTH() with Table

SELECT
    name,
    MONTH(joining_date) AS joining_month
FROM employees;

---

# 32. DAY() with Table

SELECT
    name,
    DAY(joining_date) AS joining_day
FROM employees;

---

# 33. Find Employees Who Joined in 2023

SELECT *
FROM employees
WHERE YEAR(joining_date) = 2023;

---

# 34. Find Employees Who Joined After 2022

SELECT *
FROM employees
WHERE YEAR(joining_date) > 2022;

---

# 35. DATE_ADD()

DATE_ADD() adds a specific amount of time to a date.

Syntax:

DATE_ADD(date, INTERVAL value unit)

Add days:

SELECT DATE_ADD('2026-09-27', INTERVAL 10 DAY);

Output:

2026-10-07

Add months:

SELECT DATE_ADD('2026-09-27', INTERVAL 2 MONTH);

Add years:

SELECT DATE_ADD('2026-09-27', INTERVAL 1 YEAR);

---

# 36. DATE_SUB()

DATE_SUB() subtracts a specific amount of time from a date.

Subtract days:

SELECT DATE_SUB('2026-09-27', INTERVAL 10 DAY);

Output:

2026-09-17

Subtract months:

SELECT DATE_SUB('2026-09-27', INTERVAL 2 MONTH);

Subtract years:

SELECT DATE_SUB('2026-09-27', INTERVAL 1 YEAR);

---

# 37. DATEDIFF()

DATEDIFF() returns the difference between two dates in days.

Syntax:

DATEDIFF(date1, date2)

Example:

SELECT DATEDIFF('2026-09-27', '2026-09-20');

Output:

7

Because:

27 September - 20 September = 7 days

---

# 38. DATEDIFF() with Employees

Find how many days each employee has worked.

SELECT
    name,
    joining_date,
    DATEDIFF(CURDATE(), joining_date) AS days_worked
FROM employees;

Logic:

Current Date
     -
Joining Date
     ↓
Days Worked

---

# PART 3: MATHEMATICAL FUNCTIONS

Important mathematical functions:

ROUND()
CEIL()
FLOOR()
ABS()
MOD()
POWER()
SQRT()

---

# 39. ROUND()

ROUND() rounds a number.

Example:

SELECT ROUND(10.5678);

Output:

11

Specify decimal places:

SELECT ROUND(10.5678, 2);

Output:

10.57

One decimal place:

SELECT ROUND(10.5678, 1);

Output:

10.6

---

# 40. ROUND() with AVG()

Without ROUND():

SELECT AVG(age)
FROM students;

Example result:

21.333333

With ROUND():

SELECT ROUND(AVG(age), 2) AS average_age
FROM students;

Output:

21.33

This is very useful with aggregate functions.

---

# 41. CEIL()

CEIL() rounds a number upward.

SELECT CEIL(10.2);

Output:

11

SELECT CEIL(10.9);

Output:

11

Mental model:

CEIL()
↑
Rounds upward

---

# 42. FLOOR()

FLOOR() rounds a number downward.

SELECT FLOOR(10.2);

Output:

10

SELECT FLOOR(10.9);

Output:

10

Mental model:

FLOOR()
↓
Rounds downward

---

# 43. ABS()

ABS() returns the absolute value.

SELECT ABS(-10);

Output:

10

SELECT ABS(10);

Output:

10

Another:

SELECT ABS(-25.5);

Output:

25.5

---

# 44. MOD()

MOD() returns the remainder after division.

Example:

SELECT MOD(10, 3);

Output:

1

Because:

10 ÷ 3

3 × 3 = 9

10 - 9 = 1

Another:

SELECT MOD(20, 5);

Output:

0

---

# 45. MOD() for Even and Odd

Even number:

MOD(number, 2) = 0

Odd number:

MOD(number, 2) = 1

Find students with even IDs:

SELECT *
FROM students
WHERE MOD(id, 2) = 0;

Find students with odd IDs:

SELECT *
FROM students
WHERE MOD(id, 2) = 1;

---

# 46. POWER()

POWER() raises a number to a power.

Example:

SELECT POWER(2, 3);

Output:

8

Because:

2³ = 8

Another:

SELECT POWER(5, 2);

Output:

25

---

# 47. SQRT()

SQRT() returns the square root.

SELECT SQRT(25);

Output:

5

Another:

SELECT SQRT(100);

Output:

10

---

# 48. Mathematical Functions with Table Data

Suppose salary is yearly salary.

Calculate monthly salary:

SELECT
    name,
    salary,
    ROUND(salary / 12, 2) AS monthly_salary
FROM employees;

Logic:

Yearly Salary
     ↓
   / 12
     ↓
Monthly Salary

---

# 49. Average Salary

SELECT
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;

---

# 50. Minimum, Maximum and Average Salary

SELECT
    ROUND(MIN(salary), 2) AS minimum_salary,
    ROUND(MAX(salary), 2) AS maximum_salary,
    ROUND(AVG(salary), 2) AS average_salary
FROM employees;

---

# 51. Functions + WHERE

Functions can be used inside WHERE.

Example:

SELECT *
FROM employees
WHERE YEAR(joining_date) = 2023;

Another:

SELECT *
FROM students
WHERE LENGTH(name) > 4;

Another:

SELECT *
FROM students
WHERE MOD(id, 2) = 0;

---

# 52. Functions + ORDER BY

Functions can also be used in ORDER BY.

Example:

SELECT
    name,
    LENGTH(name) AS name_length
FROM students
ORDER BY LENGTH(name) DESC;

This sorts students by name length.

---

# 53. Functions + GROUP BY

Functions can be used with GROUP BY.

Example:

SELECT
    UPPER(course) AS course_name,
    COUNT(*) AS total_students
FROM students
GROUP BY UPPER(course);

---

# 54. Functions + Aggregate Functions

Functions and aggregate functions can be combined.

Example:

SELECT
    ROUND(AVG(age), 2) AS average_age,
    MAX(age) AS maximum_age,
    MIN(age) AS minimum_age
FROM students;

Another:

SELECT
    ROUND(AVG(salary), 2) AS average_salary,
    ROUND(SUM(salary), 2) AS total_salary
FROM employees;

---

# 55. Real Backend Use Cases

## Use Case 1: Clean User Input

SELECT LOWER(TRIM(name))
FROM students;

Useful for:

- Usernames
- Emails
- Search
- Form data

---

## Use Case 2: Case-Insensitive Search

SELECT *
FROM students
WHERE LOWER(name) = 'samir';

---

## Use Case 3: Display Formatted Information

SELECT
    CONCAT(name, ' - ', course) AS student_info
FROM students;

Example:

Samir - CSE
Rahul - CSE
Aman - ECE

---

## Use Case 4: Calculate Monthly Salary

SELECT
    name,
    ROUND(salary / 12, 2) AS monthly_salary
FROM employees;

---

## Use Case 5: Find Recently Joined Employees

Employees who joined within the last year:

SELECT *
FROM employees
WHERE joining_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

---

## Use Case 6: Calculate Experience in Days

SELECT
    name,
    DATEDIFF(CURDATE(), joining_date) AS days_worked
FROM employees;

---

# 56. Important Cheat Sheet

## STRING FUNCTIONS

UPPER()
→ Convert text to uppercase

LOWER()
→ Convert text to lowercase

LENGTH()
→ Count characters

TRIM()
→ Remove spaces from both sides

LTRIM()
→ Remove left spaces

RTRIM()
→ Remove right spaces

CONCAT()
→ Combine strings

CONCAT_WS()
→ Combine strings using separator

SUBSTRING()
→ Extract part of string

LEFT()
→ Extract characters from left

RIGHT()
→ Extract characters from right

REPLACE()
→ Replace text

---

## DATE & TIME FUNCTIONS

CURDATE()
→ Current date

CURRENT_DATE()
→ Current date

CURTIME()
→ Current time

NOW()
→ Current date + time

YEAR()
→ Extract year

MONTH()
→ Extract month

DAY()
→ Extract day

HOUR()
→ Extract hour

MINUTE()
→ Extract minute

SECOND()
→ Extract second

DATE_ADD()
→ Add time to date

DATE_SUB()
→ Subtract time from date

DATEDIFF()
→ Difference between two dates

---

## MATHEMATICAL FUNCTIONS

ROUND()
→ Round a number

CEIL()
→ Round upward

FLOOR()
→ Round downward

ABS()
→ Absolute value

MOD()
→ Remainder

POWER()
→ Raise number to a power

SQRT()
→ Square root

---

# 57. Most Important Code Examples

-- UPPERCASE

SELECT UPPER(name)
FROM students;


-- LOWERCASE

SELECT LOWER(name)
FROM students;


-- LENGTH

SELECT LENGTH(name)
FROM students;


-- TRIM

SELECT TRIM(name)
FROM students;


-- CONCAT

SELECT CONCAT(name, ' - ', course)
FROM students;


-- CONCAT_WS

SELECT CONCAT_WS(' - ', name, course)
FROM students;


-- SUBSTRING

SELECT SUBSTRING(name, 1, 2)
FROM students;


-- LEFT

SELECT LEFT(name, 2)
FROM students;


-- RIGHT

SELECT RIGHT(name, 2)
FROM students;


-- REPLACE

SELECT REPLACE(course, 'CSE', 'Computer Science')
FROM students;


-- CURRENT DATE

SELECT CURDATE();


-- CURRENT TIME

SELECT CURTIME();


-- CURRENT DATE + TIME

SELECT NOW();


-- YEAR

SELECT YEAR(joining_date)
FROM employees;


-- MONTH

SELECT MONTH(joining_date)
FROM employees;


-- DAY

SELECT DAY(joining_date)
FROM employees;


-- ADD 10 DAYS

SELECT DATE_ADD(CURDATE(), INTERVAL 10 DAY);


-- SUBTRACT 10 DAYS

SELECT DATE_SUB(CURDATE(), INTERVAL 10 DAY);


-- DATE DIFFERENCE

SELECT DATEDIFF(CURDATE(), joining_date)
FROM employees;


-- ROUND

SELECT ROUND(10.5678, 2);


-- EVEN IDs

SELECT *
FROM students
WHERE MOD(id, 2) = 0;


-- ODD IDs

SELECT *
FROM students
WHERE MOD(id, 2) = 1;


-- AVERAGE AGE

SELECT ROUND(AVG(age), 2)
FROM students;


-- MONTHLY SALARY

SELECT
    name,
    ROUND(salary / 12, 2) AS monthly_salary
FROM employees;


# 58. Practice Questions

1. Convert all student names to uppercase.

2. Convert all student names to lowercase.

3. Display each student's name and name length.

4. Find students whose name length is greater than 4.

5. Display student information in this format:

Samir - CSE

6. Display the first 2 characters of every student name.

7. Display the last 2 characters of every student name.

8. Find the average age rounded to 2 decimal places.

9. Find students having even IDs.

10. Find students having odd IDs.

11. Display the current date.

12. Display the current date and time.

13. Display employee name and joining year.

14. Find employees who joined in 2023.

15. Find employees who joined after 2022.

16. Calculate how many days each employee has worked.

17. Calculate monthly salary from yearly salary.

18. Find the average employee salary rounded to 2 decimal places.

19. Find employees who joined within the last 2 years.

20. Display:

Employee Name
Joining Year
Monthly Salary

using SQL functions.


# 59. Final Mental Model

SQL FUNCTIONS

        |
        |-------------------------------|
        |               |               |
      STRING          DATE             MATH
        |               |               |
        ↓               ↓               ↓

     UPPER()         CURDATE()       ROUND()
     LOWER()         NOW()           CEIL()
     LENGTH()        YEAR()          FLOOR()
     TRIM()          MONTH()         ABS()
     CONCAT()        DAY()           MOD()
     SUBSTRING()     DATE_ADD()      POWER()
     REPLACE()       DATE_SUB()      SQRT()


Main idea:

SQL Function
     ↓
Takes existing data
     ↓
Processes / transforms it
     ↓
Returns a result


Example:

SELECT UPPER(name)
FROM students;

Database:

Samir

        ↓
    UPPER()

        ↓

SAMIR


IMPORTANT:

Most functions used with SELECT only transform
the value shown in the result.

They do NOT automatically change the
original data stored in the database.


# 60. Module 12 Summary

After completing this module, you should understand:

✓ What SQL functions are

✓ String functions

✓ UPPER()

✓ LOWER()

✓ LENGTH()

✓ TRIM()

✓ LTRIM()

✓ RTRIM()

✓ CONCAT()

✓ CONCAT_WS()

✓ SUBSTRING()

✓ LEFT()

✓ RIGHT()

✓ REPLACE()

✓ Date functions

✓ CURDATE()

✓ CURTIME()

✓ NOW()

✓ YEAR()

✓ MONTH()

✓ DAY()

✓ HOUR()

✓ MINUTE()

✓ SECOND()

✓ DATE_ADD()

✓ DATE_SUB()

✓ DATEDIFF()

✓ Mathematical functions

✓ ROUND()

✓ CEIL()

✓ FLOOR()

✓ ABS()

✓ MOD()

✓ POWER()

✓ SQRT()

✓ Combining functions

✓ Functions with WHERE

✓ Functions with ORDER BY

✓ Functions with GROUP BY

✓ Functions with aggregate functions

✓ Real-world backend use cases