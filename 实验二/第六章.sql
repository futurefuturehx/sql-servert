--6.1.��ѯcourse���е����м�¼
use teaching
select * 
from course

--6.2.��ѯstudent���е�Ů��������
use teaching
select count(*)
from student
where sex='Ů'

--6.3.��ѯteacher����ÿһλ���ڵĽ�ʦ�ţ�������רҵ����
use teaching
select teacherno as '��ʦ��',tname as '����',major as 'רҵ����'
from teacher 
where prof = '����'

--6.4.���Ա���飬���student����ÿ��ѧ����ƽ������
use teaching
select sex as '�Ա�',avg(year(getdate())-year(birthday))as 'ƽ������'--����Ҳ����datediff(year,birthday,getdate())���
from student
group by sex


--6.5.�������еı������±��±��а���ѧ�ţ�ѧ���������γ̺ź������ɼ������У������ɼ�=final*0.8+usually*0.2
use teaching
select student.studentno,student.sname,score.courseno,final*0.8+usually*0.2 as '����'
into stu_score
from student,score
where student.studentno=score.studentno
go
select * from stu_score
go

--6.6.ͳ��ÿ��ѧ������ĩ�ɼ�ƽ����
use teaching
select studentno,avg(final)
from score
group by studentno

--6.7.���student������������������������Ϣ
use teaching 
select * from student
where birthday=
(select min(birthday)
from student
)

--6.8.��ѯteacher����û��ְ�Ƶ�ְ���Ľ�ʦ�ţ�������רҵ�Ͳ���
use teaching
select teacherno,tname,major,department
from teacher
where prof is null