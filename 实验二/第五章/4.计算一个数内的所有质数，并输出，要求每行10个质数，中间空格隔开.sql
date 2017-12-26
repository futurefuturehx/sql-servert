DECLARE
	@count INT,
	@num INT,
	@divisor INT,
	@primeflag INT,
	@refSqrt INT,
	@primeStr varchar(8000)
SET @count = 0
SET @num = 2
SET @primeStr = ' '
WHILE @num <= 500
BEGIN 
	SET @primeflag = 0;
	BEGIN 
		IF(@num % 2 = 0)
		BEGIN
		IF(@num = 2)
			SET @primeFlag = 1
		END
		ELSE IF(@num % 3 = 0)
		BEGIN
			IF(@num = 3)
				SET @primeflag = 1
		END
		ELSE
		BEGIN
			SET @divisor = 3
			SET @refSqrt = CONVERT(int,SQRT(@num))
			WHILE(@num % @divisor ! =0 AND @divisor < @refSqrt)
				SET @divisor = @divisor + 2
			IF(@num % @divisor != 0)
				SET @primeflag = 1
		END
	END
	IF(@primeflag = 1)
	BEGIN
		SET @primeStr = @primeStr + CONVERT(char(6),@num)
		SET @count = @count + 1
	IF(@count % 10 =0)
		SET @primeStr = @primeStr +char(0x0a)
	END
	SET @num = @num + 1
END
PRINT '0到' + CONVERT(char(8),@num-1)
+'范围中共有'+CONVERT(char(7),@count)+'个质数'
PRINT @primeStr
GO
