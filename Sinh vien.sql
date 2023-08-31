1/
SELECT*FROM subject WHERE credit >= 5;
2/
 select student.*
from student join clazz on (clazz.clazz_id = student.clazz_id)
 where name ='CNTT 2 K61';
de tim kiem in hoa cac chu
 select student.*
 from student join clazz on (clazz.clazz_id = student.clazz_id)
 where upper(name) ='CNTT 2 K61';
3/
-select * from student,clazz where student.clazz_id = clazz.clazz_id and name LIKE '%CNTT%';
4/
-select s.first_name,last_name
from student s, subject sub, enrollment e
where s.student_id = e.student_id and sub.subject_id = e. subject_id
and sub.name = 'Co so du lieu'
intersect
select s.first_name,last_name
from student s, subject sub, enrollment e
where s.student_id = e.student_id and sub.subject_id = e. subject_id
and sub.name = 'Mang may tinh'
5/
-select s.first_name,last_name
from student s, subject sub, enrollment e
where s.student_id = e.student_id and sub.subject_id = e. subject_id
and sub.name = 'Co so du lieu' or sub.name = 'Mang may tinh';
6/
-select * from subject
where subject_id not in (select subject_id from enrollment);
-select * from subject
except
select sj.* from subject sj, enrollment e
where sj.subject_id = e.subject_id;
7/
select sub.name,credit
from subject sub, student s,enrollment e
where sub.subject_id = e.subject_id 
and s.student_id = e.student_id
and s.first_name = 'Minh Đức' and s.last_name = 'Bùi' and e.semester ='20172';
8/
select s.student_id,first_name,last_name,e.midterm_score,e.final_score,e.midterm_score*(1- sub.percentage_final_exam*1.0/100) + e.final_score 
*sub.percentage_final_exam*1.0/100 as dtk
from subject sub, student s, enrollment e
where sub.subject_id = e.subject_id 
and s.student_id = e.student_id
and sub.name = 'Cơ sở dữ liệu' and e.semester = '20172';
9/
select s.student_id 
from subject sub, student s,enrollment e
where sub.subject_id = e.subject_id 
and e.midterm_score < 3 or e.final_score <3 
or e.midterm_score*(1- sub.percentage_final_exam*1.0/100) + e.final_score 
*sub.percentage_final_exam*1.0/100 < 4;
10/

11/ Liet ke nhung nguoi tren 25 tuoi
select first_name,extract(year from age(current_date,dob)) as current_age from student where extract(year from age(current_date,dob))>=25;
12/ hoc sinh sinh thang 6
select * from student where dob between '1999/06/01' and '1999/06/30';
13/ ten lop, tong sinh vien ma tong sinh vien giam dan
select c.name ,count(s.student_id)
from clazz c, student s
where s.clazz_id = c.clazz_id
group by c.name
order by count desc;
14/ In ra diem min max avg cua diem giua ki
select min(e.midterm_score),max(e.midterm_score), avg(e.midterm_score)
from subject sub, enrollment e
where sub.subject_id = e.subject_id 
and sub.name = 'Mạng máy tính' and e.semester = '20172';
15/ So mon ma cac giang vien co day
select lec.lecturer_id, first_name,last_name, count(sub.subject_id)
from lecturer lec, teaching tea,subject sub 
where lec.lecturer_id = tea.lecturer_id and tea.subject_id = sub.subject_id
group by lec.lecturer_id;
16/ Nhung mon hoc co it nhat hai giang vien phu trach
select sub.* 
from lecturer lec, teaching tea,subject sub 
where lec.lecturer_id = tea.lecturer_id and tea.subject_id = sub.subject_id
group by sub.subject_id
having count(*)>=2;
17/
select * from subject
except
select sub.* 
from lecturer lec, teaching tea,subject sub 
where lec.lecturer_id = tea.lecturer_id and tea.subject_id = sub.subject_id
group by sub.subject_id
having count(*)>=2;
18/







