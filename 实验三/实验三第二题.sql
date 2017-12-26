CREATE PROCEDURE class_avg_score2
@class_name nvarchar(20)=NULL,@average numeric(6,2) output
AS
SELECT @average=AVG(final)
FROM student s,course c,score sc
where s.studentno=sc.studentno and c.courseno=sc.courseno
and (c.cname=@class_name or @class_name IS NULL)
GO