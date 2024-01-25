-- Functions
--------------
-- The development team wants to generate P102 as first value of ProductId and then increment it by 1 for every new product.
-- We can achieve this using Stored Procedure or Functions
-- As the requirement is to generate ProductId which will not change in the database state.
-- There are 2 types of functions:
	-- 1. Built-in: system defined functions.
		-- * Aggregate --> performs a calculation on a set of values and returns a single value.
		-- * Ranking --> Ranking funtion returns a ranking value for each row in a partition.
		-- * Scalar --> scalar functions are the function that returns single data value.
	-- 2. User defined: function that are defined by user like auto generation of ProductId.

-- Usage of Ranking Functions
--------------------------------
-- Execute the query given below and observe the output of ROW_NUMBER() as shown below.
	SELECT ProductId, ProductName, Price, CategoryId, 
       ROW_NUMBER() OVER (ORDER BY Price DESC) AS RowNo FROM Products

-- Execute the query given below and observe the output of RANK() as shown below.
	SELECT ProductId, ProductName, Price, CategoryId, 
       RANK() OVER (ORDER BY Price DESC)AS Rank FROM Products 
-- If product have same price than it will have same rank so suppose if two product have same rank 3 the next rank starts from 5 for RANK().

-- Execute the query given below and observe the output of DENSE_RANK() as shown below.
SELECT ProductId, ProductName, Price, CategoryId, 
       DENSE_RANK() OVER (ORDER BY Price DESC) AS DENSERANK FROM Products
-- If product have same price than it will have same rank so suppose if two product have same rank 3 the next rank starts from 4 DENSE_RANK().

-- Modify the query given as below, execute it and observe the output as shown below. 
SELECT ProductId, ProductName, Price,CategoryId, 
       RANK() OVER (PARTITION BY CategoryId ORDER BY Price DESC) 
AS Rank FROM Products

-- PARTITION BY clause divides the result into partitions based on the column(s) on which the partition is applied.

-- Scalar Functions
-----------------------
-- 1. Usage of Conversion Function
-------------------------------------
-- Execute the batch given below and observe the output of CAST() as shown below.
BEGIN 
     DECLARE @NumOne VARCHAR(2)   
     DECLARE @NumTwo VARCHAR(2)      
     SET @NumOne=20 
     SET @NumTwo=15  
     SELECT CAST(@NumOne AS INT) + CAST(@NumTwo AS INT) AS Total
END

-- Execute the query given below and observe the output of CONVERT() as shown below.
SELECT CONVERT(FLOAT, '17.85') AS ResultOne, 
       CONVERT(INT, 17.85) AS ResultTwo

-- 2. Usage of few Mathematical functions
-------------------------------------------
-- Execute the query given below and observe the output of ROUND(), CEILING(), FLOOR() as shown below.

	SELECT ROUND(49.5,0) AS ResultOne, ROUND(49.49,0) AS ResultTwo

	SELECT CEILING(49.1) AS Result

	SELECT FLOOR(49.9) AS Result

-- 3. String Functions
------------------------------
-- String functions perform an operation on a string input value and return a string or numeric value.
-- Execute the query given below and observe the output:
	SELECT SUBSTRING('Microsoft SQL Server',11,10) AS Result

	SELECT REVERSE('Microsoft SQL Server') AS Result

	SELECT CONCAT('Microsoft',' SQL',' Server') AS Result

	SELECT LOWER('Microsoft SQL Server') AS Result

	SELECT UPPER('Microsoft SQL Server')AS Result

-- 4. Date and Time
-------------------------
-- Date and Time functions perform an operation on a date and time input value and returns either a string, numeric, or date and time value.
-- Execute the query given below and observe the output:
	
	SELECT GETDATE() AS 'Current Date and Time'

	SELECT DAY(GETDATE()) AS 'Day'

	SELECT MONTH(GETDATE()) AS 'Month'

	SELECT YEAR(GETDATE()) AS 'Year'

	SELECT DATEFROMPARTS ( 2016, 12, 31 ) AS Result
