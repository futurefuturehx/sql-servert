CREATE TABLE ѡ��
(ѧ�� nchar(10) not null,
�γ̺� nchar(6) not null,
�ɼ� int check(�ɼ�>=0 and �ɼ�<=100) not null,
constraint pk1 primary key(ѧ��,�γ̺�),
constraint fk1 foreign key(ѧ��)
	references ѧ��(ѧ��),
constraint fk2 foreign key(�γ̺�)
	references �γ�(�γ̺�))