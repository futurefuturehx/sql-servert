--6.1.查询course表中的所有记录
use teaching
select * 
from course

--6.2.查询student表中的女生的人数
use teaching
select count(*)
from student
where sex='女'

--6.3.查询teacher表中每一位教授的教师号，姓名和专业名称
use teaching
select teacherno as '教师号',tname as '姓名',major as '专业名称'
from teacher 
where prof = '教授'

--6.4.按性别分组，求出student表中每组学生的平均年龄
use teaching
select sex as '性别',avg(year(getdate())-year(birthday))as '平均年龄'--年龄也可用datediff(year,birthday,getdate())求得
from student
group by sex


--6.5.利用现有的表生成新表，新表中包括学号，学生姓名，课程号和总评成绩。其中，总评成绩=final*0.8+usually*0.2
use teaching
select student.studentno,student.sname,score.courseno,final*0.8+usually*0.2 as '总评'
into stu_score
from student,score
where student.studentno=score.studentno
go
select * from stu_score
go

--6.6.统计每个学生的期末成绩平均分
use teaching
select studentno,avg(final)
from score
group by studentno

--6.7.输出student表中年来最大的男生的所有信息
use teaching 
select * from student
where birthday=
(select min(birthday)
from student
)

--6.8.查询teacher表中没有职称的职工的教师号，姓名，专业和部门
use teaching
select teacherno,tname,major,department
from teacher
where prof is null