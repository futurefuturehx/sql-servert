CREATE TABLE 课程
(课程号 nchar(6) primary key,
课程名 varchar(30) not null,
学时 tinyint CHECK(学时>10),
学分 numeric(2,1) )