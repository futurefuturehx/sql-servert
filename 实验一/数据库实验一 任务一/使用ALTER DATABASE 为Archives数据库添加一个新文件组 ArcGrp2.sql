alter database Archieves
add filegroup ArcGrp2
go
alter database Archieves
add file
(NAME=Arc_dat3,
FILENAME='C:\Archievesdata\Arcdat3.ndf',
SIZE=10,
MAXSIZE=50,
FILEGROWTH=5),
(NAME=Arc_dat4,
FILENAME='C:\Archievesdata\Arcdat4.ndf',
SIZE=10,
MAXSIZE=50,
FILEGROWTH=5)
to filegroup ArcGrp2;
go

