1/
select name from subject where credit >= 5 ;
2/
dung phep ket noi bang student va clazz
-select * from student,clazz where student.clazz_id = clazz.clazz_id and name = 'CNTT 2 K58';
3/
-select * from student,clazz where student.clazz_id = clazz.clazz_id and name LIKE '%CNTT%';
5/
-select * from student s,subject sub ,enrollment e where s.student_id = e.student_id and sub.subject_id = e.subject_id and (subject.name = 'lap trinh java' or subject.name = 'lap trinh nhung');
4/
-select s.student_id,first_name,last_name from student s join enrollment e using(student_id) join subject sub using(subject_id) where sub.name='Co so du lieu' intersect 
select s.student_id,first_name,last_name from student s join enrollment e using(student_id) join subject sub using(subject_id) where sub.name = 'Tin hoc dai cuong';
6/
-select name from subject
except
select name from subject,enrollment where subject.subject_id = enrollment.subject_id;
-select *from subject where subject_id not in(select subject_id from enrollment);
-left join ... group by ... having count(e.subject_id) = 0;
7/
-select sub.name from student s join enrollment e using(student_id) join subject sub using(subject_id) where s.first_name = 'Ngoc An'
intersect
select distinct sub.name from subject sub join enrollment e using(subject_id) where e.semester = '20171';
8/
-select s.student_id,s.first_name,e.midterm_score,e.final_score,e.midterm_score*(1-sub.percentage_final_exam*1.0/100)+e.final_score*sub.percentage_final_exam*1.0/100 as subject_score from student s join enrollment e using(student_id) join subject sub using(subject_id) where sub.name='Co so du lieu'and e.semester='20171';
9/
-select s.student_id from student s join enrollment e using(student_id) join subject sub using(subject_id) where sub.subject_id='IT1110' and e.semester='20171' and (e.midterm_score < 3 or e.final_score<3 or (e.midterm_score*(1-sub.percentage_final_exam*1.0/100)+e.final_score*sub.percentage_final_exam*1.0/100)<4);
10/
-select s.last_name,s.first_name,c.name,l.last_name,l.first_name from student s join clazz c using(clazz_id) join lecturer l using(lecturer_id); 
11/
-select first_name,extract(year from age(current_date,dob)) as current_age from student where extract(year from age(current_date,dob))>=25;
12/
-select last_name,first_name from student where extract(month from dob)=6 and extract (year from dob)=1999;
-select first_name, last_name,dob from student where dob  between '1999/06/01' and '1999/06/30';
13/
-select clazz_id,count(*) from student group by clazz_id order by count DESC;
14/
-select min(e.midterm_score),max(e.midterm_score),avg(e.midterm_score) from enrollment e join subject sub using(subject_id) where sub.name='Mang may tinh' and e.semester='20171';
15/
-select lec.first_name,lec.lecturer_id,count(*) from teaching tea join lecturer lec using(lecturer_id) group by lec.lecturer_id;
16/
-select sub.name from subject sub join teaching tea using(subject_id) group by sub.subject_id having count(*)>=2;
-select subject_id, count(*) from teaching group by subject_id;
-select subject_id, having count(*) from teaching group by subject_id having count(*)>2;
17/
- select subject_id from subject
- except
- select subject_id, having count(*) from teaching group by subject_id having count(*)>2;



