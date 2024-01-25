-- EXCEPTION HANDLING
----------------------------------
-- 1. Exception Handling helps to handle the technical error and provide user friendly message.
-- 2. An Exception can be handled using TRY-CATCH block.
-- 3. In order to raise an exception explicitly, the THROW keyword can be used.

-- Example
DECLARE @Var5 INT = 100, @Var6 INT = 0
SELECT @Var5/@Var6 AS RESULT

-- Divide by zero throws an error
-- 1. Line Number - Gives the line number of error --> ERROR_LINE()
-- 2. State - Gives the state --> ERROR_STATE()
-- 3. Severity - Gives the severity --> ERROR_SEVERITY()
-- 4. Error Number - Gives the error number --> ERROR_NUMBER()
-- 5. Error Message - Gives the message --> ERROR_MESSAGE()

-- Example Try Catch Block:
BEGIN TRY
	DECLARE @Var3 INT = 100, @Var4 INT = 0
	SELECT @Var3/@Var4 AS RESULT
END TRY
BEGIN CATCH
    SELECT ERROR_LINE() AS LineNumber,        
            ERROR_MESSAGE() AS ErrorMessage,           
            ERROR_NUMBER() AS ErrorNumber,    
            ERROR_SEVERITY() AS Severity,         
            ERROR_STATE() AS ErrorState 
END CATCH

-- Example THROW 
BEGIN TRY
    DECLARE @Var1 INT = 100, @Var2 INT = 0
    IF @Var2 = 0
         THROW 62000,'The Divisor cannot be zero.',1
    ELSE 
         SELECT @Var1/@Var2 AS RESULT 
END TRY
BEGIN CATCH
   SELECT ERROR_LINE() AS LineNumber,
          ERROR_MESSAGE() AS ErrorMessage,
          ERROR_NUMBER() AS ErrorNumber,
          ERROR_SEVERITY() AS Severity,      
          ERROR_STATE() AS ErrorState
END CATCH

-- Problem Description: There should be a provision in the online shopping application to add new products in Products table as and when the products are released to the market. 
-- Create a batch with pre-defined values to validate against the following conditions.
BEGIN TRY
	DECLARE @ProductId CHAR(4)='101' , @ProductName Varchar(20) = 'BMW X1',
			@CategoryId TINYINT = 4, @Price NUMERIC(8,0) = 20, @QuantityAvailable INT = 3
	IF @ProductId IS NULL  
		THROW -1,'ProductID is null',1
	IF LEN(@ProductId) < 4
		THROW -6,'ProductID does not start with P or length is less than 4 characters', 1
	ELSE
		PRINT @ProductId
END TRY
BEGIN CATCH
   SELECT ERROR_LINE() AS LineNumber,
          ERROR_MESSAGE() AS ErrorMessage,
          ERROR_NUMBER() AS ErrorNumber,
          ERROR_SEVERITY() AS Severity,      
          ERROR_STATE() AS ErrorState
END CATCH
-- @ProductName IS NULL || @CategoryId IS NULL || @Price IS NULL || @QuantityAvailable IS NULL