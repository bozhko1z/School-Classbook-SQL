--01.shows all students ordered by their no
select name as StudentName, no as StudentNo from Students
order by no

--02.shows all subjects ordered by a-z
select name as SubjectName from Subjects
order by name

--03.shows all students who are exempt
select s.name as StudentName, s.no as StudentNo, Sb.name as SubjectName from Students as s 
join Scores on student_id = s.id
join Subjects as Sb on Sb.id = Scores.subject_id
where excempt = 'true'
order by StudentNo

--04.shows student's grades (only those who aren't exempt)
select St.name as StudentName, Sb.name as SubjectName, s.score as SubjectScore from Scores as s
join Subjects as Sb on Sb.id = s.subject_id
join Students as St on St.id = s.student_id
where no between 1 and 9
group by s.excempt, St.name, Sb.name, s.score
having s.excempt = 'false'
order by Sb.name

--05.now shows their grades with words
select St.name as StudentName, Sb.name as SubjectName, 
case 
when score = 2 then 'Poor 2'
when score = 3 then 'Average 3'
when score = 4 then 'Good 4'
when score = 5 then 'Very Good 5'
when score = 6 then 'Excellent 6'
end as Ocenka
from Scores as s
join Subjects as Sb on Sb.id = s.subject_id
join Students as St on St.id = s.student_id
where no between 1 and 5
group by s.excempt, Sb.name, s.score, St.name
having s.excempt = 'false'
order by Sb.name

--06.shows subject info for every student
select s.name as StudentName, Sb.name as SubjectName, Sc.subject_type as SubjectType, Sc.hours as HoursStudied, Sc.excempt, Sc.score from Subjects as Sb
join Students as s on s.id = Sb.id
join Scores as Sc on Sc.subject_id = Sb.id
where no between 1 and 9
order by s.name

--07.shows the average mark for each student
select s.name as StudentName, avg(Sc.score) as AverageMark from Scores as Sc
join Students as s on s.id = Sc.student_id
where no between 1 and 9
group by s.name

--08.shows info about all marks - subject name and its count of marks, average, max and min 
--(if there's no mark its replaced with '-')
select Sb.name, 
coalesce(reverse(count(Sc.score), 0), '-') as all_marks,
coalesce(reverse(avg(Sc.score), 0), '-') as avg_marks,
coalesce(reverse(max(Sc.score), 0), '-') as max_marks,
coalesce(reverse(min(Sc.score), 0), '-') as min_marks
from Subjects as Sb
full join Scores as Sc on Sc.subject_id = Sb.id
group by Sb.name
order by Sb.name

--09.shows how much marks each student has (those with no marks have '-')
select s.name, s.no, replace(count(Sc.score), 0, '-') as all_marks from Students as s
left join Scores as Sc on Sc.student_id = s.id
group by s.name, s.no
order by s.no

--10.shows those who doesn't have enough marks (2)
select s.no as StudentNo, s.name as StudentName, count(Sc.score) as AllMarks from Students as s
join Scores as Sc on Sc.student_id = s.id
group by s.no, s.name
having count(Sc.score) < 2
order by AllMarks desc, StudentNo

--11.shows only students with no grades
select s.no as StudentNo, s.name as StudentName from Students as s
join Scores as Sc on Sc.student_id = s.id
group by s.no, s.name
having count(Sc.score) = 0
order by StudentNo

--12.shows only students with poor marks and the subject for which they have it
select s.no as StudentNo, s.name as StudentName, Sb.name as SubjectName 
from Students as s
join Scores as Sc on Sc.student_id = s.id
join Subjects as Sb on Sb.id = Sc.subject_id
group by s.no, s.name, Sc.score, Sb.name
having Sc.score = 2
order by StudentNo

--13.shows the hours of every student
select St.name as StudentName, St.no as StudentNo, replace(count(Sc.hours), 0, '-') as Hours from Students as St
left join Scores as Sc on Sc.student_id = St.id
group by St.name, St.no, Sc.hours
order by St.no

--14.shows the students and all their marks on each subject
select s.name as StudentName, s.no as StudentNo, coalesce(Sb.name, '-') as SubjectName, replace(coalesce(Sc.score, '-'), 0, '-') as SubjectScore 
from Students as s
full join Scores as Sc on Sc.student_id = s.id
left join Subjects as Sb on Sb.id = Sc.subject_id
group by s.name, s.no, Sb.name, Sc.score
order by s.no

--15.shows only those who have marks(those who don't won't be shown)
select s.name as StudentName, s.no as StudentNo, Sb.name as SubjectName, Sc.score as SubjectScore
from Subjects as Sb
join Scores as Sc on Sc.subject_id = Sb.id
join Students as s on s.id = Sc.student_id
where Sc.score is not null
group by s.name, s.no, Sb.name, Sc.score
order by Sc.score desc, s.name
