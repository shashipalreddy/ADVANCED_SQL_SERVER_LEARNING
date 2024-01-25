-- Transaction
--------------------
-- 1. Transaction is a set of statements that executes, either successfully or not at all.
-- 2. Start the transaction by the keyword BEGIN TRAN/BEGIN TRANSACTION.
-- 3. To see the number of active transactions, use the global variable @@TRANCOUNT.
-- 4. In order to commit the transaction we do COMMIT TRANS/COMMIT TRANSACTION statement.
-- 5. A ROLLBACK TRANSACTION is used to discard all the data modifications made from start of the transaction.
-- 6. ROLLBACK at any level of transaction will roll back all the transactions(inner, intermediates and outer transactions).
-- 7. Transactions can be given a name, for the purpose of creating a savepoint. So whenever we want to rollback only a part of transaction, ROLLBACK can be used along with the transaction name. This will rollback upto savepoint.
-- 8. In case of any exception, all database operations must be discarded, that is a ROLLBACK is performed.

-- Example 1:
BEGIN TRAN
   SELECT @@TRANCOUNT AS TRANCOUNT  -- Value is 1

-- Example 2:
BEGIN TRAN
   SELECT @@TRANCOUNT AS TRANCOUNT  -- Value is 1 
   COMMIT TRAN         -- decrements the @@TRANCOUNT
                       -- and commits the transaction 
   SELECT @@TRANCOUNT AS TRANCOUNT  -- Value is 0

-- When a COMMIT is executed in the inner transaction, it only decrements the @@TRANCOUNT by 1. But the database changes are saved only when the outer transaction is committed.
-- Example 3:
BEGIN TRAN            -- Begin first transaction
   BEGIN TRAN         -- Begin second transaction
      SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 2
   COMMIT TRAN        -- Decrements the value of @@TRANCOUNT by 1
   SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 1 
COMMIT TRAN        -- Commits the transaction and decrements the value of @@TRANCOUNT by 1 
SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 0

-- Example 4: 
BEGIN TRAN         -- Begin first transaction
   BEGIN TRAN         -- Begin second transaction
      SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 2
   ROLLBACK TRAN        -- Rolls back all the transactions
   SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 0

-- Example 5: 
BEGIN TRAN         -- Begin first transaction
   BEGIN TRAN         -- Begin second transaction
      SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 2
   COMMIT TRAN        -- Decrements the @@TRANCOUNT  
                      -- but does not commit the transaction
   SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 1 
ROLLBACK TRAN      -- Rolls back all the transactions and  
                   -- no changes are saved in the database.
SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 0

-- Example 6:
BEGIN TRAN          -- Begin first transaction
   BEGIN TRAN          -- Begin second transaction
      SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 2
      SAVE TRAN S1        -- Creates a savepoint named S1
   COMMIT TRAN         -- Decrements the @@TRANCOUNT
                       -- but does not save the database changes
   SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 1
ROLLBACK TRAN S1    -- Rolls back to savepoint S1
SELECT @@TRANCOUNT AS TRANCOUNT -- Value is 1



