DECLARE @date1 datetime,@date2 datetime
SET @date1 = '2017-12-25'
SET @date2 = '2017-12-26'
PRINT '����֮���ǣ�'+CONVERT(VARCHAR(12),DATEDIFF(DAY,@date1,@date2))+'��'
GO