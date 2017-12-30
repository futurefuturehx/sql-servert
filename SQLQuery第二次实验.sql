--***************第五章***********************
--1.利用Transact-SQL语句声明一个长度为16的nchar型变量bookname，并赋初值为“SQL Server 数据库编程”
DECLARE @bookname nchar(16)
SET @bookname = 'SQL Server 数据库编程'
SELECT @bookname
GO
--2.编程计算输入两个任意日期的时间差
DECLARE @date1 datetime,@date2 datetime
SET @date1 = '2017-12-20'
SET @date2 = '2017-12-21'
PRINT '两天相差'+ CONVERT(VARCHAR(12),DATEDIFF(DAy,@date1,@date2))+'天'

GO
--3.编程求50-100之间所有能被3整除的奇数之和
DECLARE @count INT,@SUM INT 
SET @count=50
SET @SUM=0 
WHILE @count<=100 
BEGIN     
if ( @count%2=1 and  @count%3=0)    
SET @SUM=@SUM+@count    
SET @count=@count+1    
END     
PRINT '50到100之间所有能被3整除的奇数之和='+ CAST(@SUM AS VARCHAR(4))
GO
--4.计算一个数内的所有质数，并输出，要求每行10个质数，中间空格隔开
--================求0 ~ @num之内的质数个数(用@count统计)=============
--====== @num较小时(比如最多10000以内)使用@primeStr存放质数并最终输出
DECLARE
  @count INT, --质数个数
  @num INT, --当前的数
  @divisor INT, --除因子
  @primeFlag INT, --质数标志
  @refSqrt INT, --从2除到@num的平方根
  @primeStr varchar(8000) --质数放到该串中，最后输出(@num小于10000之内可以)
SET @count = 0
SET @num = 2
SET @primeStr = ' '
WHILE @num <= 10000
BEGIN
  SET @primeFlag = 0; --0代表不是质数  1--代表是质数
  BEGIN
    IF(@num % 2 = 0)
    BEGIN
    IF(@num = 2)
       SET @primeFlag = 1
    END
    ELSE IF(@num % 3 = 0)
    BEGIN
      IF(@num = 3)
         SET @primeFlag = 1
    END
    ELSE
    BEGIN
      SET @divisor = 3
      SET @refSqrt = CONVERT(int, SQRT(@num))
      WHILE(@num % @divisor != 0 AND @divisor < @refSqrt)
         SET @divisor = @divisor + 2
      IF(@num % @divisor != 0)
         SET @primeFlag = 1
    END
  END
  IF(@primeFlag = 1)
  BEGIN
    SET @primeStr = @primeStr + CONVERT(char(6), @num)
    SET @count = @count + 1
	IF(@count % 10 = 0) 
	  SET @primeStr = @primeStr + char(0x0a) 
	  --char(0x0a) 或 char(10)：换行符,【注意不能用'\n'】
  END
  SET @num = @num + 1
END
PRINT '0 ~ ' + CONVERT(char(8), @num-1)
  + ' 范围内一共有 ' + CONVERT(char(7), @count) + ' 个质数.'
PRINT @primeStr
GO

-- SQL Server里的控制字符列表：
--Tab 　　char(9)
--换行　　char(10)
--回车　　char(13)
--单引号　char(39)
--双引号　char(34)




--******************第六章**************
--1.查询course表中的所有记录
use teaching
select * 
from course

--2.查询student表中的女生的人数
use teaching
select count(*)
from student
where sex='女'

--3.查询teacher表中每一位教授的教师号，姓名和专业名称
use teaching
select teacherno as '教师号',tname as '姓名',major as '专业名称'
from teacher 
where prof = '教授'

--4.按性别分组，求出student表中每组学生的平均年龄
use teaching
select sex as '性别',avg(year(getdate())-year(birthday))as '平均年龄'--年龄也可用datediff(year,birthday,getdate())求得
from student
group by sex


--5.利用现有的表生成新表，新表中包括学号，学生姓名，课程号和总评成绩。其中，总评成绩=final*0.8+usually*0.2
use teaching
select student.studentno,student.sname,score.courseno,final*0.8+usually*0.2 as '总评'
into stu_score
from student,score
where student.studentno=score.studentno
go
select * from stu_score
go

--6.统计每个学生的期末成绩平均分
use teaching
select studentno,avg(final)
from score
group by studentno

--7.输出student表中年来最大的男生的所有信息
use teaching 
select * from student
where birthday=
(select min(birthday)
from student
)

--8.查询teacher表中没有职称的职工的教师号，姓名，专业和部门
use teaching
select teacherno,tname,major,department
from teacher
where prof is null

--********************第七章********************
--1.查询每一位教授的教师号、姓名和讲授的课程名称。
 
use teaching 
go  
select teacher.teacherno,tname ,cname
from teach_class join teacher
    on teach_class.teacherno=teacher.teacherno 
	join course on teach_class.courseno=course.courseno 
where prof='教授' 
go 
 

--2.利用现有的表生成新表，新表中包括学号、学生姓名、课程名称和总评成绩。其中：总评成绩=final*0.9+usually*0.1 

use teaching 
go  
select DISTINCT student.studentno,student.sname,course.cname,score.final*0.9+score.usually*0.1 as '总评成绩'
into stu_course  
from student,course,score  
where student.studentno=score.studentno and course.courseno=score.courseno 
go 

  
--3.统计每个学生的期末成绩高于75分的课程门数。

use teaching 
go  
select student.studentno,sname,count(*)  '课程门数'
from student,score   
where final > 75 and student.studentno=score.studentno
group by student.studentno,student.sname 
go      
        

--4.输出student表中年龄大于女生平均年龄的男生的所有信息。

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
 

--5.计算每个学生获得的学分。

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
  

--6.获取入学时间在2016年到2017年的所有学生中入学年龄小于19岁的学生学号、姓名及所修课程的课程名称。 

use teaching 
go  
select student.studentno,student.sname,stu_course.cname 
from student inner join stu_course               
  on student.studentno=stu_course.studentno         
where (substring(student.studentno,1,2)='16' and (datediff(year,birthday,'2016-01-01')<19))       
   or (substring(student.studentno,1,2)='17' and (datediff(year,birthday,'2017-01-01')<19)) 
go   
 

--7.查询16级学生的学号、姓名、课程名及学分。

use teaching 
go  
select student.studentno,student.sname,stu_course.cname,course.credit
from student inner join stu_course 
on student.studentno=stu_course.studentno    
             inner join course 
on stu_course.cname=course.cname     
where  substring(student.studentno,1,2)='16'           
go 
  
  
--8.查询选修课程的少于3门、或期末成绩含有60分以下课程的学生的学号、姓名、电话和Email。

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