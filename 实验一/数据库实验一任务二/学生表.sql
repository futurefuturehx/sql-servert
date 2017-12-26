create table 学生(
序号 int not null,
学号 nchar(10 ) primary key,
姓名 varchar(10) not null,
住址 nchar(20), 
性别 char(2) check(性别='男'or 性别='女'),
专业名 nchar(2) not null default '软件工程')
