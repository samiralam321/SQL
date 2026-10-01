-- What does a backedn actually do ?

-- Suppose i have a website with a login page
-- the fronted sends this information to your backend

Frontend
   ↓
POST /login
   ↓
FastAPI
   ↓
MySQL


-- the backend might execute a query like  :

SELECT *
FROM users
WHERE email = 'samir@gmail.com'

-- then MySQL sends the result back : 

Frontend
   ↓
POST /login
   ↓
FastAPI
   ↓
MySQL

-- so SQL is the language your backedn uses to communicate with a database

---------- CRUD in Backend -------

-- Fronted sends POST /students

{
    "name" : "Samir",
    "age" : 21,
    "course" : "CSE"
}

-- Backend Executes something like : 

INSERT INTO students(name,age,course)
VALUES('Samir',21, 'CSE');


-- READ : SELECT

-- Request : GET /students

-- Backend

SELECT *
FROM student


--- For one student : 

GET /students/1

-- Backedn

SELECT *
FROM students
WHERE id = 1;

---- UPDATE

-- Request : PUT /students/1

-- Backend : 

UPDATE students
SET name = 'Samir Alam',
age = 22
WHERE id = 1;


--- DELETE 

-- DELETE /students/1

-- backend

DELETE FROM students
WHERE id = 1;

------------ Database Connection --------------

-- our fastapi application needs to connect with MySQL

FastAPI
   ↓
Database Driver
   ↓
MySQL


----------------------- WHAT IS ORM ----------------------

-- OBJECT RELATIONAL MAPPING

-- IT allows us to work with database using Python objects instead of writing every SQL query manually

-- without ORM

SELECT *
FROM students
WHERE id = 1;

-- with ORM we can write python code that represent the same operation

-- SQLAlchemy is a Python ORM

-------------- SQL vs ORM

-- SQL

Direct control
Easy to understand SQL
useful for complex queries

-- ORM

You work with Python objects.

Advantages:

Convenient
Integrates well with application code
Reduces repetitive SQL
Helps structure larger applications

--------------------  SQL Injection ------------------------------

## SQL Injection

**SQL Injection (SQLi)** is a security attack where an attacker puts **malicious SQL code into an input field** to manipulate the database.

### Simple example

Suppose a login system does this:


SELECT * FROM users
WHERE username = 'samir'
AND password = '1234';

If the application directly puts user input into the SQL query, an attacker may enter specially crafted input that **changes the meaning of the query**.

Instead of treating the input as normal data, the database may interpret it as **SQL code**.

### Why is it dangerous?

SQL Injection can potentially allow an attacker to:

* Bypass login
* Read private database data
* Modify or delete data
* Access information they shouldn't see
* In severe cases, gain broader control depending on the database/application setup

How to prevent it?

The most important method is:

**Use parameterized queries / prepared statements.**

Bad:


query = "SELECT * FROM users WHERE username = '" + username + "'"


Better:

query = "SELECT * FROM users WHERE username = %s"
cursor.execute(query, (username,))


Here, the database treats `username` as **data**, not as SQL code.

### Remember this for interviews

SQL Injection = Untrusted user input gets interpreted as part of an SQL query.**

Main protection:** Parameterized queries / Prepared Statements.

Think of it like this:


User Input
    ↓
SQL Query
    ↓
Database
    ↓
If input becomes SQL code → SQL Injection
    ↓
Use parameterized queries → Prevent it


---------------------- Transaction in Backend --------------------------

-- Backend Request Flow

-- Suppose user clicks : "Buy Now"
-- the complete flow can be : 

1. User clicks Buy
        ↓
2. Frontend sends POST request
        ↓
3. FastAPI receives request
        ↓
4. Backend validates data
        ↓
5. Backend starts transaction
        ↓
6. SQL queries execute
        ↓
7. Database changes
        ↓
8. COMMIT
        ↓
9. FastAPI sends response
        ↓
10. Frontend updates UI


---------------------- Connection Pool -------------------------------

-- Database Connection : is like a communication channel between your backend and database
-- Every time your backend needs the database, it needs a connection. 


# Connection Pool

First understand one thing:

A **database connection** is like a communication channel between your backend and database.

```text
Python Backend  ←──── connection ────→  MySQL Database
```

Every time your backend needs the database, it needs a connection.

## The problem

Imagine 100 users use your application at the same time.

Without a connection pool:

```text
User 1 → Create connection → DB → Close
User 2 → Create connection → DB → Close
User 3 → Create connection → DB → Close
...
User 100 → Create connection → DB → Close
```

Creating a database connection repeatedly is **slow and expensive**.

---

# So what is Connection Pool?

A **connection pool is a collection of already-created database connections that your application keeps ready for reuse.**

Think of it like a **parking lot of database connections**:

```text
              CONNECTION POOL
        ┌───────────────────────┐
        │ Connection 1  🟢      │
        │ Connection 2  🟢      │
        │ Connection 3  🟢      │
        │ Connection 4  🟢      │
        │ Connection 5  🟢      │
        └───────────────────────┘
                  ↑
                  │
             Backend
```

When your backend needs the database:

```text
Backend
   ↓
Take an available connection
   ↓
Run SQL query
   ↓
Finish
   ↓
Return connection to pool
```

**It usually does NOT destroy the connection after every query.**

It puts it back into the pool so another request can reuse it.

---

# Simple Real-Life Example

Imagine a restaurant.

### Without connection pooling

Every customer:

```text
Customer arrives
     ↓
Build a new table
     ↓
Customer eats
     ↓
Destroy table
```

Very inefficient.

### With connection pooling

Restaurant already has 10 tables:

```text
Table 1
Table 2
Table 3
...
Table 10
```

Customer comes:

```text
Customer
   ↓
Use available table
   ↓
Eat
   ↓
Leave
   ↓
Table becomes available again
```

That's basically what a connection pool does.

---

# Why do we need it?

### 1. Faster

Connections are already created.

```text
Without pool:
Create connection → Query → Close

With pool:
Take connection → Query → Return
```

### 2. Handles many users

Suppose your pool has:

```text
10 database connections
```

100 users can still make requests.

The application can reuse those 10 connections instead of creating 100 new connections.

### 3. Reduces database load

Creating connections repeatedly puts unnecessary load on the database.

Pooling reduces that overhead.

### 4. Controls the number of connections

You can set something like:

```text
Maximum connections = 10
```

So your application doesn't suddenly create thousands of database connections and overload MySQL.

---

# Very Important Concept

Suppose your pool has **3 connections**:

```text
Pool
┌───────────────┐
│ Connection 1  │
│ Connection 2  │
│ Connection 3  │
└───────────────┘
```

Three requests arrive:

```text
Request 1 → Connection 1
Request 2 → Connection 2
Request 3 → Connection 3
```

Now another request arrives:

```text
Request 4
   ↓
No connection available
   ↓
Waits
   ↓
Connection 2 finishes
   ↓
Connection 2 returned to pool
   ↓
Request 4 uses Connection 2
```

That's how pooling also **limits concurrency** against the database.

---

# In Backend Development

You'll commonly see something like:

```text
FastAPI
   ↓
Database connection pool
   ↓
MySQL
```

For example:

```text
FastAPI
   ↓
SQLAlchemy
   ↓
Connection Pool
   ↓
MySQL
```

The pool is usually managed by your database library/ORM, so you don't manually create a new connection for every request.

---

## Interview Definition

> **Connection Pooling is the technique of maintaining a set of reusable database connections so that applications can reuse them instead of creating and closing a new connection for every database request.**

### Remember this flow:

```text
Request
   ↓
Get connection from pool
   ↓
Execute SQL
   ↓
Finish
   ↓
Return connection to pool
   ↓
Ready for next request
```

**In one line:**

> **Connection Pool = Keep database connections ready, reuse them, and avoid creating a new connection every time.**











