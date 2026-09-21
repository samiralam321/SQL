-------- Filtering Data With WHERE, AND, OR, NOT  ------------

SELECT * FROM students;

-- This gives every studnets, but suppose if we have 10 million records so u don't want 10M records

--- Syntax of WHERE

SELECT columns
FROM table
WHERE condition;

---

SELECT * FROM students
WHERE course='CSE';

-- The result is : 

| id | name  | age | course |
| -: | ----- | --: | ------ |
|  1 | Samir |  21 | CSE    |
|  2 | Rahul |  20 | CSE    |
|  5 | Neha  |  20 | CSE    |


----- Comparison Operator -----

=       Equal to
>       Greater than
<       Less than
>=      Greater than or equal to
<=      Less than or equal to
<>      Not equal to


SELECT *
FROM students
WHERE age = 20;

SELECT *
FROM students
WHERE age > 20;

SELECT *
FROM students
WHERE age >= 21;

-- <> Not Equal

SELECT *
FROM students
WHERE course <> 'CSE';


SELECT *
FROM students
WHERE name='Samir';

-- Where with multiple conditions 

SELECT *
FROM students
WHERE course = 'CSE'
AND age = 20;     -- AND : Both conditions must be true


SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'ECE';

-- OR means : At least one condition must be true

------------------ Operator Precedence -------------------

-- AND has higher precedence than OR

SELECT *
FROM students
WHERE course = 'CSE'
OR course = 'ECE'
AND age = 20;

--- USe Parentheses when combining  conditions

SELECT *
FROM students
WHERE (course = 'CSE' OR course = 'ECE')
AND age = 20;


SELECT *
FROM students
WHERE age >= 21
AND course <> 'ECE';



