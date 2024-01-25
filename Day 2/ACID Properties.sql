-- ACID Properties
-----------------------
-- Transaction exhibits Atomicity, Consistency, Isolation, Durability(ACID) properties
-- 1. Atomicity: To Execute all the queries succesfully and COMMIT it or ROLLBACK completely in case of any failure.
-- 2. Consistency: To ensure the state of the database is consistent before and after execution of the query.
-- 3. Isolation: ensures that data is exclusively available for every user by over coming various concurrency problems like:
	-- * Dirty Read
	-- * Lost Update
	-- * Nonrepeatable Read
	-- * Phantom Read
-- 4. Durability: ensures data is permanently stored.

-- Isolation Levels
---------------------
-- Case 1 :
------------------------------------------------------
-- Isolation helps to lock the selected product for a transaction duration.
-- In order to maintain the consistency of the data in the tables, we will copy the data from table Products to a table TempProducts using SELECT * INTO as shown below. 
-- Example:

	SELECT * INTO TempProducts
	FROM Products
	SELECT * FROM TempProducts

-- Begin a transaction as Customer1 and update the quantity available for the product id P102. 
-- Set the QuantityAvailable from existing value to existing value minus 10. This can be done as follows:-

	BEGIN TRAN
		UPDATE TempProducts SET QuantityAvailable = QuantityAvailable-10 WHERE ProductId = 'P102'

-- Open another connection of SQL Server management studio by clicking on New Query as Customer2.
-- Try to view the details of the product P102 by executing the following query.
	
	SELECT * FROM TempProducts WHERE ProductId = 'P102'

-- You notice that the query execution does not complete on its own. To stop the execution, click on the Stop Executing button as shown below.
-- Now set the isolation level to READ UNCOMMITTED as follows:

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

-- Now try to execute the same SELECT query again as Customer2.

	SELECT * FROM TempProducts WHERE ProductId = 'P102'

-- Now the first update is rolled back using ROLLBACK by Customer1

	BEGIN TRAN
		 UPDATE TempProducts SET QuantityAvailable = QuantityAvailable - 10 
 		 WHERE ProductId='P102'
	ROLLBACK

-- The Customer2 tries to execute the same SELECT query again.

	SELECT * FROM TempProducts WHERE ProductId = 'P102'

-- The isolation level READ UNCOMMITTED allows user to read uncommitted data which maybe changed anytime. This is called as Dirty Read problem.
-- This problem of Dirty Read can be solved using the isolation level READ COMMITTED.

-- Now start a transaction as Customer1 by using BEGIN TRAN.
-- And update the QuantityAvailable using the Update query as before.

	BEGIN TRAN 
     UPDATE TempProducts SET QuantityAvailable = QuantityAvailable + 10 
     WHERE ProductId='P102'

-- As Customer2, in the second connection, change the Isolation level to READ COMMITTED and execute the SELECT query for Customer2 as follows:
	
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SELECT * FROM TempProducts WHERE ProductId = 'P102'

-- By default the isolation level of SQL Server is READ COMMITTED.
-- This isolation level allows a user to read only the committed data. But the same SELECT query fetches different results when executed twice. This problem is called as non-repeatable read.
-- This problem of Non-Repeatable Read can be solved by using the isolation level REPEATABLE READ.

-- Case 2 :
-------------------------------------------------
-- Start a transaction as Customer1 using BEGIN TRAN. Execute the following SELECT query to see the QuantityAvailable for the product P102.
	
	BEGIN TRAN
    SELECT ProductId, QuantityAvailable FROM TempProducts WHERE ProductId = 'P102'

-- Open another SQL connection as Customer2 and Update the QuantityAvailable for the product id P101 as follows:

	UPDATE TempProducts SET QuantityAvailable = QuantityAvailable - 10 WHERE ProductId = 'P102'

-- Now if the Customer1 tries to view the details again by executing the same SELECT query, the output is different.

	BEGIN TRAN
    SELECT ProductId, QuantityAvailable FROM TempProducts WHERE ProductId = 'P102'

-- Such a problem is called as Non-repeatable read. It can be solved by using the isolation level REPEATABLE READ.

-- Now, the Customer1 rolls back the active transaction and updates the QuantityAvailable to 10 again. Also, the isolation level is set to REPEATABLE READ.

	BEGIN TRAN
    SELECT ProductId, QuantityAvailable FROM TempProducts WHERE ProductId = 'P102'
	ROLLBACK
	UPDATE TempProducts SET QuantityAvailable = 10 WHERE ProductId = 'P102' 
	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ

-- Now, Customer1 starts a transaction again and executes the same SELECT query as before.

	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ 
	
	BEGIN TRAN
   		SELECT ProductId, QuantityAvailable FROM TempProducts WHERE ProductId = 'P102'

-- Next, the Customer2 again updates the QuantityAvailable as shown below:

	UPDATE TempProducts SET QuantityAvailable = QuantityAvailable - 10 WHERE ProductId = 'P102'

-- But as it can be seen, that this update query is in executing status. This query execution will be complete only when Customer1 commits the active transaction.
-- Once the transaction is committed by Customer1, the UPDATE query fired by Customer2 gets executed automatically.
-- Thus the problem of non-repeatable read is solved by the isolation level REPEATABLE READ.
-- Once again if the Customer1 executes the SELECT query as before, a different result is fetched. Such problem is called as Phantom Read.
-- This concurrency problem of Phantom Read can be solved by isolation level SERIALIZABLE, which doesn't allow any INSERT or DELETE when data is being read by a transaction.

	SET TRANSACTION ISOLATION LEVEL REPEATABLE READ
	
	BEGIN TRAN
   		SELECT ProductId, QuantityAvailable FROM TempProducts WHERE ProductId = 'P102' 
	COMMIT

-- The isolation level can be set to SERIALIZABLE by a Customer and the following SELECT query is executed to view the products whose name starts with B.

	SET TRANSACTION ISOLATION LEVEL SERIALIZABLE
	BEGIN TRAN
   		SELECT ProductId, ProductName FROM TempProducts WHERE ProductName LIKE 'B%'

-- Now Admin adds a new product to the TempProducts table as follows:

	INSERT INTO TempProducts VALUES('P158','Barbie set',7,1280,32)

-- Once the Customer commits the transaction, the INSERT query fired by Admin is completed automatically as shown below.

	COMMIT

-- Now, if the Customer executes the SELECT query again, it gives the extra product which is added newly by the Admin.

	SELECT ProductId, ProductName FROM TempProducts WHERE ProductName LIKE 'B%'

