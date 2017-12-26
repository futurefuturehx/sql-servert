--7.1.查询每一位教授的教师号、姓名和讲授的课程名称
use teaching 
go  
select teacher.teacherno,tname ,cname
from teach_class join teacher
    on teach_class.teacherno=teacher.teacherno 
	join course on teach_class.courseno=course.courseno 
where prof='教授' 
go 
 

--7.2.利用现有的表生成新表，新表中包括学号、学生姓名、课程名称和总评成绩。其中：总评成绩=final*0.9+usually*0.1 

use teaching 
go  
select DISTINCT student.studentno,student.sname,course.cname,score.final*0.9+score.usually*0.1 as '总评成绩'
into stu_course  
from student,course,score  
where student.studentno=score.studentno and course.courseno=score.courseno 
go 

  
--7.3.统计每个学生的期末成绩高于75分的课程门数。

use teaching 
go  
select student.studentno,sname,count(*)  '课程门数'
from student,score   
where final > 75 and student.studentno=score.studentno
group by student.studentno,student.sname 
go      
        

--7.4.输出student表中年龄大于女生平均年龄的男生的所有信息。

use teaching 
go  
select * 
from student  
where sex= '男'and DATEDIFF(year,birthday,getdate()) >
 (select avg(DATEDIFF(year,birthday,getdate()))          
  from student 
  where sex= '女'
  )
go     
 

--7.5.计算每个学生获得的学分。

use teaching 
go  
select student.studentno,student.sname,sum(credit) '学分'
from student INNER JOIN score          
  ON student.studentno=score.studentno       
             INNER JOIN course         
  ON course.courseno=score.courseno 
where  score.final>60  
group by student.studentno,student.sname        
go     
  

--7.6.获取入学时间在2016年到2017年的所有学生中入学年龄小于19岁的学生学号、姓名及所修课程的课程名称。 

use teaching 
go  
select student.studentno,student.sname,stu_course.cname 
from student inner join stu_course               
  on student.studentno=stu_course.studentno         
where (substring(student.studentno,1,2)='16' and (datediff(year,birthday,'2016-01-01')<19))       
   or (substring(student.studentno,1,2)='17' and (datediff(year,birthday,'2017-01-01')<19)) 
go   
 

--7.7.查询16级学生的学号、姓名、课程名及学分。

use teaching 
go  
select student.studentno,student.sname,stu_course.cname,course.credit
from student inner join stu_course 
on student.studentno=stu_course.studentno    
             inner join course 
on stu_course.cname=course.cname     
where  substring(student.studentno,1,2)='16'           
go 
  
  
--7.8.查询选修课程的少于3门、或期末成绩含有60分以下课程的学生的学号、姓名、电话和Email。

use teaching 
go  
select student.studentno,sname,phone,Email 
from student
where studentno in (select studentno
					from score
					group by studentno
					having count(*)<3 or exists (select *
												from score
												where student.studentno=score.studentno and final<60))