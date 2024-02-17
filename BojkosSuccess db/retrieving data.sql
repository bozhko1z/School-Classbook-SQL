--shows all students ordered by their no
select name as StudentName, no as StudentNo from Students
order by no

--shows all subjects ordered by a-z
select name as SubjectName from Subjects
order by name

--shows all students who are exempt
select s.name as StudentName, s.no as StudentNo, Sb.name as SubjectName from Students as s 
join Scores on student_id = s.id
join Subjects as Sb on Sb.id = Scores.subject_id
where excempt = 'true'
order by StudentNo

--shows student's grades (only those who aren't exempt)
select St.name as StudentName, Sb.name as SubjectName, s.score as SubjectScore from Scores as s
join Subjects as Sb on Sb.id = s.subject_id
join Students as St on St.id = s.student_id
where no between 1 and 9
group by s.excempt, St.name, Sb.name, s.score
having s.excempt = 'false'
order by Sb.name

-- now shows their grades with words
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

--shows subject info for every student
select s.name as StudentName, Sb.name as SubjectName, Sc.subject_type as SubjectType, Sc.hours as HoursStudied, Sc.excempt, Sc.score from Subjects as Sb
join Students as s on s.id = Sb.id
join Scores as Sc on Sc.subject_id = Sb.id
where no between 1 and 9
order by s.name

--shows the average mark for each student
select s.name as StudentName, avg(Sc.score) as AverageMark from Scores as Sc
join Students as s on s.id = Sc.student_id
where no between 1 and 9
group by s.name

--shows info about all marks - subject name and its count of marks, average, max and min 
--(if there's no mark its replaced with '-')
select Sb.name, 
coalesce(count(Sc.score), '-') as all_marks,
coalesce(avg(Sc.score), '-') as avg_marks,
coalesce(max(Sc.score), '-') as max_marks,
coalesce(min(Sc.score), '-') as min_marks
from Subjects as Sb
full join Scores as Sc on Sc.subject_id = Sb.id
group by Sb.name
order by Sb.name

--shows how much marks each student has (those with no marks have '-')
select s.name, s.no, replace(count(Sc.score), 0, '-') as all_marks from Students as s
left join Scores as Sc on Sc.student_id = s.id
group by s.name, s.no
order by s.no

--shows those who doesn't have enough marks (2)
select s.no as StudentNo, s.name as StudentName, count(Sc.score) as AllMarks from Students as s
join Scores as Sc on Sc.student_id = s.id
group by s.no, s.name
having count(Sc.score) < 2
order by AllMarks desc, StudentNo

--shows only students with no grades
select s.no as StudentNo, s.name as StudentName from Students as s
join Scores as Sc on Sc.student_id = s.id
group by s.no, s.name
having count(Sc.score) = 0
order by StudentNo

--shows only students with poor marks and the subject for which they have it
select s.no as StudentNo, s.name as StudentName, Sb.name as SubjectName 
from Students as s
join Scores as Sc on Sc.student_id = s.id
join Subjects as Sb on Sb.id = Sc.subject_id
group by s.no, s.name, Sc.score, Sb.name
having Sc.score = 2
order by StudentNo

