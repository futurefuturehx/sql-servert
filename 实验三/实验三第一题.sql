CREATE PROCEDURE class_avg_score
@cname nvarchar(20),@average numeric(6,2) output
AS
SELECT @average = AVG(final)
FROM student s,course c,score sc
WHERE s.studentno=sc.studentno and c.courseno =sc.courseno
and c.cname=@cname
GO 