CREATE TABLE 选课
(学号 nchar(10) not null,
课程号 nchar(6) not null,
成绩 int check(成绩>=0 and 成绩<=100) not null,
constraint pk1 primary key(学号,课程号),
constraint fk1 foreign key(学号)
	references 学生(学号),
constraint fk2 foreign key(课程号)
	references 课程(课程号))