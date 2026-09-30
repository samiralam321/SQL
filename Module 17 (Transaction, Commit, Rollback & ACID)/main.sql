-- Transaction : A transaction is a group of database operations that should be trated as one unit.

-- why we need transaction ?
-- we need two operations :

-- imagine trnaderring 1000 Rs from Samir to Rahu;

-- we need 2 operations

UPDATE accounts
SET balance = balance - 10000
WHERE id = 1;

-- and

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

-- both operations should success together, or neither should happen
-- that is what transaction help us achieve. 


-- SO, Transaction is a group of SQL operations treated as one logical unit of work

--- START transaction ------------------

START TRANSACTION

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

-- at this point transaction is still not permanently committed. 


--------------- COMMIT : permanently saves the changes made during the transaction -------------------------

START TRANSACTION

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

COMMIT;

-- now the changes are committed.

----------------- ROLLBACK ----------------------
-- it cancel changes made during the current transaction 

START TRANSACTION 

UPDATE accounts
SET balance = balance - 1000
WHERE id = 1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;

ROLLBACK

-- NOW THE Updates are undone --------


-------------------- ACID PROPERTIES -------------------

-- transaction are commonly explained using ACID 
-- A → Atomicity
-- C → Consistency
-- I → Isolation
-- D → Durability

---------- Atomicity : Means A transaction happens completely or not at all

-- Example : Transfer 1000 Rs,
Transfer ₹1000

Withdraw     ✅
Deposit      ❌

-- Atomicity says : Don't keep only the withdrawal, Undo it
-- So,

ALL SUCCESS -> COMMIT
ANY FAILURE -> ROLLBACK

-- SO, Atomicity means : All or Nothing


----------------------- Consistency ------------------

-- It means the database should move from one valid state to another state

-- before transfer

Samir = ₹5000
Rahul = ₹3000

Total = ₹8000


-- after tranfwerring 1000;
Samir = ₹4000
Rahul = ₹4000

Total = ₹8000

--- that database rules remain valid
-- Consistency  : Database remains valid

------------------------- Isolation -----------------------------

-- suppose two transaction are running at the same time
-- Transaction A
-- Transaction B

-- they should not improperly interface with each other's intermediate work

-- A is transferring money
-- B is checking the account

-- Isolation means = Transaction should not improperly interface


--------------------------- Durability --------------------------

-- once we execute COMMIT;

-- the changes should persist even if something happens 
-- afterward, such as a database/server restart, subject to the database's durability guarantees.

-- Example : 

UPDATE
  ↓
COMMIT
  ↓
Server restart
  ↓
Data remains committed


-- Durability = Committed data stays saved

-------------------------- SAVEPOINT --------------------

-- sometime we don't want to rollback the entire transaction 

-- so we can create a checkpoint using :

SAVEPOINT savepoint_name;

---------

START TRANSACTION;

UPDATE accounts
SET balacne = balance - 1000
WHERE id = 1;

SAVEPOINT point1;

UPDATE accounts
SET balance = balance + 1000
WHERE id = 2;


-- now suppose we want to undo only the changes after point1

ROLLBACK TO point1;

-- the transaction itself is still active 
-- then we can continue working and eventually;

COMMIT;

-------------- Complete SAVEPOINT Example ---------------------

START TRANSACTION;

UPDATE accounts
SET BALANCE = balance - 1000
WHERE id = 1;

SAVEPOINT after_withdrawal;

UPDATE accounts
SET blance = balance + 1000
WHERE id = 2;

ROLLBACK TO after_withdraw;

COMMIT;


---------------- IF SOMETHING GOES WRONG -----------------

START TRANSACTION;
UPDATE accounts

SET balance = balance - 1000
WHERE id = 1;

-- something goes wrong
ROLLBACK;

-- the balance returns to its previus transaction state


-- transaction in Backedn Development ------------

FastAPI
   ↓
Service function
   ↓
START TRANSACTION
   ↓
INSERT order
   ↓
INSERT order_items
   ↓
UPDATE inventory
   ↓
COMMIT


-- if something fails : 

ERROR
  ↓
ROLLBACK


-- so this is useful when multiple database changes must stay consistent















































































































