--7.1.��ѯÿһλ���ڵĽ�ʦ�š������ͽ��ڵĿγ�����
use teaching 
go  
select teacher.teacherno,tname ,cname
from teach_class join teacher
    on teach_class.teacherno=teacher.teacherno 
	join course on teach_class.courseno=course.courseno 
where prof='����' 
go 
 

--7.2.�������еı������±��±��а���ѧ�š�ѧ���������γ����ƺ������ɼ������У������ɼ�=final*0.9+usually*0.1 

use teaching 
go  
select DISTINCT student.studentno,student.sname,course.cname,score.final*0.9+score.usually*0.1 as '�����ɼ�'
into stu_course  
from student,course,score  
where student.studentno=score.studentno and course.courseno=score.courseno 
go 

  
--7.3.ͳ��ÿ��ѧ������ĩ�ɼ�����75�ֵĿγ�������

use teaching 
go  
select student.studentno,sname,count(*)  '�γ�����'
from student,score   
where final > 75 and student.studentno=score.studentno
group by student.studentno,student.sname 
go      
        

--7.4.���student�����������Ů��ƽ�������������������Ϣ��

use teaching 
go  
select * 
from student  
where sex= '��'and DATEDIFF(year,birthday,getdate()) >
 (select avg(DATEDIFF(year,birthday,getdate()))          
  from student 
  where sex= 'Ů'
  )
go     
 

--7.5.����ÿ��ѧ����õ�ѧ�֡�

use teaching 
go  
select student.studentno,student.sname,sum(credit) 'ѧ��'
from student INNER JOIN score          
  ON student.studentno=score.studentno       
             INNER JOIN course         
  ON course.courseno=score.courseno 
where  score.final>60  
group by student.studentno,student.sname        
go     
  

--7.6.��ȡ��ѧʱ����2016�굽2017�������ѧ������ѧ����С��19���ѧ��ѧ�š����������޿γ̵Ŀγ����ơ� 

use teaching 
go  
select student.studentno,student.sname,stu_course.cname 
from student inner join stu_course               
  on student.studentno=stu_course.studentno         
where (substring(student.studentno,1,2)='16' and (datediff(year,birthday,'2016-01-01')<19))       
   or (substring(student.studentno,1,2)='17' and (datediff(year,birthday,'2017-01-01')<19)) 
go   
 

--7.7.��ѯ16��ѧ����ѧ�š��������γ�����ѧ�֡�

use teaching 
go  
select student.studentno,student.sname,stu_course.cname,course.credit
from student inner join stu_course 
on student.studentno=stu_course.studentno    
             inner join course 
on stu_course.cname=course.cname     
where  substring(student.studentno,1,2)='16'           
go 
  
  
--7.8.��ѯѡ�޿γ̵�����3�š�����ĩ�ɼ�����60�����¿γ̵�ѧ����ѧ�š��������绰��Email��

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