DECLARE @count INT,@SUM INT
SET @count=50
SET @SUM=0
WHILE @count<=100
BEGIN
if (@count%2=1 and @count%3=0)
SET @SUM=@SUM+@count
SET @count=@count+1
END
PRINT '50��100֮��������ܱ�3����������֮����'+CAST(@SUM AS VARCHAR(4))
GO