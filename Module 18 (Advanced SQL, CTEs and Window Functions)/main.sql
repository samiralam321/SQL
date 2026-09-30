-- CTE : Common Table Expression
-- Window Functions 

-- A CTE is a temorarly named result that you create at the beginning of a 
-- query and then use inside that query

Complex Query
     ↓
Break into smaller query
     ↓
Give it a name
     ↓
Use that name


--- Syntax

WITH cte_name AS (
    SELECT ....
)

SELECT *
FROM cte_name;


------------- Simple CTE Example----------------------

students
-------------------------
id | name | age | course

-- we want students older thsn 20.

-- without CTE

SELECT *
FROM students
WHERE age > 20;


---- with CTE

WITH older_students AS (
    SELECT *
    FROM student
    WHERE age > 20
)

SELECT *
FROM older_students;

-- where older_students is the CTE name;


-- Why use CTEs?

-- CTEs are useful for:

-- Making complex queries easier to understand.
-- Breaking a large query into smaller parts.
-- Reusing a result within the same query.
-- Working with multiple query steps.
-- Recursive queries.

-- Instead of writing one huge query:

-- Huge Query
--     ↓
-- Hard to understand

-- we can write:

-- CTE 1
--   ↓
-- CTE 2
--   ↓
-- Final Query

----------------- CTE WITH AFGGREGATE FUNCTIONS ---------------------

WITH average_age AS (
    SELECT AVG(age) AS avg_age
    FROM students
)

SELECT *
FROM students
WHERE age > (
    SELECT avg_age
    FROM average_age
);

--------------- what is the difference between Subquery and CTE -------------------

-- Subquery

SELECT *
FROM students
WHERE age > (
    SELECT AVG(age)
    FROM students
);


---- CTE 

WITH average_age AS (
    SELECT AVG(age) AS avg_age
    FROM students
)

SELECT *
FROM students

WHERE age > (
    SELECT avg_age
    FROM average_age
);


Subquery
→ Query inside another query

CTE
→ Give a query result a name
→ Use that named result in the main query

--- CTE's are often easier to read when the query becomes complicated 


------------------------ Window Functions ------------------------------------

-- A window function peroforms a calculation across realted rows without 
-- collasping those rows into one per group

-- this is the ke difference from GROUP BY


-- Window function, tumhe kisi row ke saath - saath baki related rows ka data
-- bhi dekhne deta hai, bina rows ko merge kiye hue


-- syntax

FUNCTION(....)
OVER (
    PARTITION BY ...
    ORDER BY ...
)



--- IMAGINE U WANT TOP 3 PRODUCTS IN EACH CATEGORY 

WITH ranked_products AS (
    SELECT 
        product_name,
        category,
        sales,

        RANK() OVER(
            PARTITION BY category
            ORDER BY sales DESC
        ) AS products
    FROM products
)

SELECT *
FROM ranked_products
WHERE ranking <= 3

--- Main difference -----------------------

GROUP BY
   ↓
Rows ko combine karta hai

WINDOW FUNCTION
   ↓
Rows ko preserve karta hai
aur calculation ka result har row ke saath deta hai

-------------------- PARTITION BY ----------------

name    department    marks
---------------------------
Aman    CSE            80
Ravi    CSE            70
Neha    ECE            90
Rahul   ECE            60

-- WE NEED AVERAGE OF EACH DEPARTMENT 

SELECT name, department, marks,
        AVG(marks) OVER(PARTITION BY department) AS dept_age

FROM students

-- result 

name    dept    marks    dept_avg
---------------------------------
Aman    CSE      80        75
Ravi    CSE      70        75
Neha    ECE      90        75
Rahul   ECE      60        75

-------------- OVER() ------------------

-- OVER() define karta hai ki kis rows ke groups/window par calculation krni haii

AVG(makrs) OVER()


















































































