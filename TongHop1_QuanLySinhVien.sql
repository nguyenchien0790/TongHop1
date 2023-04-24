create database quanlysinhvien2;
use quanlysinhvien2;

create table Students(
StudentID int primary key auto_increment,
StudentName varchar(45),
Age int,
Email varchar(45)
);
insert into students(StudentName, Age, Email) values
("Nguyen Quang An", 18, "an@yahoo.com"),
("Nguyen Cong Vinh", 20, "vinh@gmail.com"),
("Nguyen Van Quyen", 19, "quyen@gmail.com"),
("Pham Thanh Binh", 25, "binh@gmail.com"),
("Nguyen Van Tai Em", 30, "taiem@sport.com");

create table Classes(
ClassID int primary key auto_increment,
ClassName varchar(20)
);
insert into classes(ClassName) values
("C0706L"),
("C0708G");
select * from classes;

create table Subjects(
SubjectID int primary key auto_increment,
SubjectName varchar(45)
);
insert into subjects(SubjectName) values
("SQL"),
("Java"),
("C"),
("Visual Basic");

create table ClassStudent(
StudentID int,
ClassID int,
foreign key(StudentID) references Students (StudentID),
foreign key(ClassID) references Classes (ClassID)
);
insert into classstudent(StudentID, ClassID) values
(1, 1),
(2, 1),
(3, 2),
(4, 2),
(5, 2);
select * from classstudent;



create table Marks(
Mark int,
SubjectID int,
StudentID int,
foreign key (SubjectID) references Subjects (SubjectID),
foreign key (StudentID) references Students (StudentID)
);
insert into marks(Mark, SubjectID, StudentID) values
(8, 1, 1),
(4, 2, 1),
(9, 1, 1),
(7, 1, 3),
(3, 1, 4),
(5, 2, 5),
(8, 3, 3),
(1, 3, 5),
(3, 2, 4);
select * from marks;

-- cau 1: Hien thi danh sach tat ca cac hoc vien co tuoi >= 25.
select * from students where Age >= 25;

-- cau 2: Hien thi danh sach tat ca cac mon hoc.
select * from subjects;

-- Hien thi danh sach ten hoc vien va lop hoc.
select Students.StudentName, Classes.ClassName
from Students join ClassStudent on Students.StudentID = ClassStudent.StudentID
join Classes on ClassStudent.ClassID = Classes.ClassID;

--  CAU 3 Tinh diem trung binh 
select m.StudentID, s.StudentName, avg(m.Mark) as DiemTBSV
from Marks as m
join Students as s on s.StudentID = m.StudentID
group by m.StudentID;
-- CAU 4 Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
select SubjectName, max(Mark) as maxMark from Subjects
 inner join marks on subjects.SubjectId=marks.SubjectId;
-- CAU 5 Danh so thu tu cua diem theo chieu giam
select row_number() over (order by mark desc) as 'Số Thứ Tự', students.studentId, students.studentName, mark, subjectName, className from students
inner join marks on students.studentId = marks.studentId
inner join subjects on marks.subjectId = subjects.subjectId
inner join classStudent on students.studentId = classStudent.StudentId
inner join classes on  classes.classId = classStudent.classId;
-- CAU 6 Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
alter table subjects
modify column subjectName varchar(255);

-- CAU 7 Cap nhat them dong chu « Day la mon hoc «  vao truoc cac ban ghi tren cot SubjectName trong bang Subjects
update subjects set subjectName = concat('Đây là môn học ',subjectName);
-- CAU 8 Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
alter table Students add constraint age check(age between 15 and 55);

-- CAU 9 Loai bo tat ca quan he giua cac bang
-- tắt khóa ngoại 
set foreign_key_checks = 0;
-- bật kn
set foreign_key_checks = 1;
-- CAU 10 Xoa hoc vien co StudentID la 1
delete from Students where StudentID = 1;
-- CAU 11 Trong bang Student them mot column Status co kieu du lieu la Bit va co gia tri Default la 1
alter table students
add status bit default 1;
-- CAU 12 Cap nhap gia tri Status trong bang Student thanh 0
 update students set status = 0;


