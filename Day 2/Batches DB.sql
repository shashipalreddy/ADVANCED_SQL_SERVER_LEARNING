-- A batch is a block of code that contains business logic and variables which are used to store data temporarily.

-- E.g: Write a batch to calculate the total amount for a given product price and quantity to be purchased.
	-- 1. Start batch using the begin keyword.
	-- 2. In order to store data, we need variables. Variables are two types:
			-- I. Local Variables: Variables declared in a batch by developer
			-- II. Global Variables: System defined variabes. They cannot be declared or assigned values by developers. These variables are prefixed with '@@' and accesibel to all users.
					-- @@SERVERNAME  is a global variable which stores the name of the server 
					-- @@ERROR is a global variable which returns the error number for the last T-SQL statement executed. It returns 0 if the previous T-SQL statement encountered no errors.
	-- 3. Terminate the batch using End Keyword.

-- IMPLEMENTATION USING IF
BEGIN
	DECLARE @Price NUMERIC(8)=550, @QuantityPurchased TINYINT=2, @TotalAmount NUMERIC(8)
	SET @TotalAmount = @QuantityPurchased * @Price
	IF @TotalAmount > 0 AND @TotalAmount < 1000
		SET @TotalAmount = @TotalAmount * 0.95
	ELSE IF @TotalAmount >= 1000 AND @TotalAmount < 2000
		SET @TotalAmount = @TotalAmount *0.9
	ELSE
		SET @TotalAmount = @TotalAmount * 0.8
	PRINT @TotalAmount
END

-- IMPLEMENTATION USING CASE
BEGIN
   DECLARE @Price1 NUMERIC(8)=200, @QuantityPurchased1 TINYINT=2,
          @TotalAmount1 NUMERIC(8)
   SET @TotalAmount1=@Price1*@QuantityPurchased1
   SET @TotalAmount1=
      CASE
         WHEN @TotalAmount1>0 AND @TotalAmount1<1000
            THEN 0.95*@TotalAmount1
         WHEN @TotalAmount1>=1000 AND @TotalAmount1<2000
            THEN 0.9*@TotalAmount1
         ELSE 0.8*@TotalAmount1
      END
     PRINT @TotalAmount1
END

-- Exercise: Problem Description: Generate ProductId for 30 newly added products for QuickKart. The ProductId should start from 2000 and must be incremented by 2 for every subsequent product.
BEGIN
	DECLARE @Count TINYINT=0, @ProductId INT=2000
	WHILE(@Count < 30) 
		BEGIN
			SET @Count = @Count + 1
			SET @ProductId = @ProductId + 2
			PRINT @ProductId
		END
END
