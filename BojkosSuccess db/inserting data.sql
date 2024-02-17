-- inserting students
insert into Students (id, no, name) 
values(1, 1, 'Alexandra'),
(2, 2, 'Alehandroo'),
(3, 3, 'Bobi'),
(4, 4, 'ViktAr'),
(5, 5, 'DIAN'),
(6, 6, 'Dani'),
(7, 7, 'Ivancho'),
(8, 8, 'Kikcho'),
(9, 9, 'Tsveti')

--inserting subjects
insert into Subjects (id, name)
values(1, 'Bel'),
(2, 'Mathematics'),
(3, 'PE'),
(4, 'Deutch'),
(5, 'It'),
(6, 'Programming'),
(7, 'Music'),
(8, 'Art')

--inserting marks for each subject and for all students
insert into Scores(student_id, subject_id, score, hours, excempt) values
--(1,1,5,12,'true'),
(1,2,6,8,'false'),
(1,3,4,2,'true'),
(1,4,3,4,'true'),
(1,5,2,10,'false'),
(1,6,6,12,'true'),
(1,7,4,3,'false'),
(1,8,5,3,'true'),
(2,1,4,10,'false'),
(2,2,3,7,'true'),
(2,3,4,7,'false'),
(2,4,6,6,'false'),
(2,5,5,8,'true'),
(2,6,2,11,'false'),
(2,7,2,12,'false'),
(2,8,2,10,'true'),
(3,1,5,9,'true'),
(3,2,4,12,'false'),
(3,3,2,5,'true'),
(3,4,2,7,'true'),
(3,5,4,18,'false'),
(3,6,3,9,'false'),
(3,7,5,5,'true'),
(3,8,6,2,'false'),
(4,1,5,12,'false'),
(4,2,5,5,'true'),
(4,3,4,6,'false'),
(4,4,2,7,'true'),
(4,5,6,8,'true'),
(4,6,5,3,'false'),
(4,7,5,4,'true'),
(4,8,2,11,'false'),
(5,1,6,10,'true'),
(5,2,6,9,'true'),
(5,3,6,2,'true'),
(5,4,2,8,'true'),
(5,5,2,4,'false'),
(5,6,5,5,'true'),
(5,7,3,12,'true'),
(5,8,3,2,'true')

--inserting columns for grade, class and year of graduation
alter table Students
add Grade int, Class varchar(1), YearGraduation int

--specifying the grade, class and grad. year for all studnets
update Students
set Grade = 12, Class = 'a', YearGraduation = 2024
where no between 1 and 9

--deleting the marks for those which are exempt (exempt = true)
update Scores
set score = null
where excempt = 'true'

--seting the Grade + 1 for the ones which are under 12 grade only if they don't have any bad marks (2)
update Students
set Class = Class + 1
where Grade < 12 and not exists(select * from Scores where student_id = score and score = 2)
