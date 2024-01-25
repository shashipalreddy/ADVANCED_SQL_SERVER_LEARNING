-- STORED PROCEDURES
--------------------------
-- Stored Procedure helps to persist the business logic and cache the execution plan.
-- Stored Procedures are of 2 types:
	-- * Built-in
	-- * User defined

-- Create a stored procedure called usp_FirstProcedure using the CREATE PROCEDURE statement.
CREATE PROCEDURE usp_FirstProcedure
AS
BEGIN
      PRINT 'Welcome to Stored Procedure'
END

-- Execute the stored procedure using the EXEC statement.
EXEC usp_FirstProcedure

-- Include an input parameter and an output parameter into the procedure. This can be achieved by altering the stored procedure using ALTER PROCEDURE statement as follows:
-- In the stored procedure body, set the output parameter to the value of the input parameter.
ALTER PROCEDURE usp_FirstProcedure 
(
       @InParam VARCHAR(15),
       @OutParam VARCHAR(15) OUT
) 
AS
BEGIN
  SET @OutParam = 'Message is ' + @InParam
END

-- Execute the stored procedure as shown below by declaring a variable for output parameter and specifying the parameter type as OUT.
DECLARE @OutParamValue VARCHAR(15), 
              @InParamValue VARCHAR(15) = 'Hi'
EXEC usp_FirstProcedure @InParamValue , @OutParamvalue OUT
SELECT @OutParamValue AS Result

-- The stored procedure can be altered in such a way that a new execution plan is created every time the stored procedure is executed. It can be done as shown below:
ALTER PROCEDURE usp_FirstProcedure
(
      @InParam VARCHAR(25),
      @OutParam VARCHAR(25) OUT
)
WITH RECOMPILE
AS
BEGIN
     SET @OutParam = 'Message is ' + @InParam
END

-- Encryption converts the code into an encrypted format so that the users will not be able to get the actual content written inside the stored procedure.
-- SP_HELPTEXT: It is a built-in stored procedure that can be used to retrieve the details of a stored procedure.
EXEC SP_HELPTEXT 'usp_FirstProcedure'

-- In order to create a stored procedure with Encryption, alter it as follows:
ALTER PROCEDURE usp_FirstProcedure 
(
       @InParam VARCHAR(25),
       @OutParam VARCHAR(25) OUT 
) 
WITH ENCRYPTION
AS 
BEGIN
      SET @OutParam = 'Message is ' + @InParam 
END

-- Drop a stored procedure as below:
DROP PROCEDURE usp_FirstProcedure

-- A maximum of 2100 parameters are allowed in a stored procedure
-- They can be nested upto a maximum of 32 levels