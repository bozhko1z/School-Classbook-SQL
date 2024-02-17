--creating the database
create database BojkosSuccess

use BojkosSuccess
--creating the tables
	create table Students(id int primary key, no int, name varchar(30))
	create table Subjects(id int primary key, name varchar(50))

	create table Scores(student_id int, subject_id int, score int, subject_type varchar(3) default 'ÇÓ×', hours int, excempt bit default 'false',
	constraint FK_Scores_Students
	foreign key(student_id) references Students(id),
	constraint FK_Scores_Subjects
	foreign key(subject_id) references Subjects(id))
