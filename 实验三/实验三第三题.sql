
create trigger max
on score
after insert 
as 
insert into course_superstar(courseno,studentno,grade,note)
select c.courseno,s.studentno,s.classno,s.phone
FROM student s,course c,score sc
WHERE s.studentno=sc.studentno and c.courseno =sc.courseno
and sc.final=MAX(final)
GO 