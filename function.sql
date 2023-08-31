-- Bai 2:
-- Tao them mot cot vao trong 
After table clazz add column number_students
-- Viet ham update so sinh vien cho moi lop
create or replace function update_number_students() returns void as $$
Declare 
x char(8);
Begin
for x in select clazz_id from clazz loop
update clazz set number_student = number_of_students(x)
where clazz_id = x;
END LOOP;
END;
$$ LANGUAGE plpgsql;
--Bai 1:
CREATE FUNCTION number_of_students (IN clazzid character(8), OUT n INTEGER) AS $$
DECLARE
BEGIN
SELECT COUNT(*) INTO n
FROM student
WHERE clazz_id = clazzid;
END;
$$ LANGUAGE plpgsql;
-- Cấu trúc cơ bản của function
CREATE FUNCTION function name (kiểu biến IN:vào , OUT:ra,INOUNT:vừa vào vừa ra ) AS $$
DECLARE<khai bao bien>
<code>
END;
$$
$$ language plpsql 
GRANT USAGE ON SCHEMA (store)\d de kiem tra)
--define a trigger function
CREATE OR REPLACE FUNCTION 
insert_view_student_class_shortinfos()RETURNS 
triggerAS
$$
BEGIN
--insert student
insert into student (student_id,last_name,first_name ,gender,dob)values(NEW.student_id,NEW.last_name,NEW.first_name,NEW.gender,NEW.dob);
RETURN NEW;
END;
$$ LANGUAGEplpgsql ;
-- trigger
CREATE OR REPLACE FUNCTION tg_view() RETURNS TRIGGER AS
$$
BEGIN
--
insert into student(student_id,last_name,first_name,gender,dob) 
values (NEW.student, new.last_name,new.first_name,new.gender,new.dob);
RETURN NEW;
--

$$ LANGUAGE plpgsql;
create trigger tg_view
INSTEAD OF INSERT ON student_class_shortinfos
FOR EACH ROW
EXECUTE PROCEDURE tg_view();
//
CREATE OR REPLACE FUNCTION update_student_trigger()
RETURNS TRIGGER AS $$
BEGIN
  UPDATE student
  SET last_name = NEW.last_name,
      first_name = NEW.first_name,
      gender = NEW.gender,
      dob = NEW.dob
  WHERE student_id = old.student_id;
  
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
create trigger update_student_trigger
INSTEAD OF UPDATE ON student_class_shortinfos
FOR EACH ROW
EXECUTE PROCEDURE update_student_trigger();
--test
 update student set first_name ='Minh Hyen' where student_id ='20160004';
 -- Kiểm tra khác distinc

CREATE FUNCTION number_of_students(class_id INT) RETURNS INT
BEGIN
  DECLARE num_students INT;
  
  SELECT COUNT(*) INTO num_students
  FROM enrollment
  WHERE class_id = class_id;
  
  RETURN num_students;
END;

--------------------------------------------------------------------
CREATE FUNCTION number_of_students(IN classid char) RETURNS INT AS $$
DECLARE num_students INT;
BEGIN
  SELECT COUNT(*) INTO num_students
  FROM student
  WHERE clazz_id = classid;
  
  RETURN num_students;
END;
$$ LANGUAGE plpgsql
select number_of_students(20162102)

create or replace procedure 
--------
Với BEFORE 
trigger before delete: return old;
trigger before update or insert:return new;
inster of chỉ viết cho view
-- Với trigger after return gì không quan trọng sau khi lệnh insert into thì mới thực thi
-----------------------------------------------------------------------------------------------------------
-- trigger function for instead of trigger
create or replace function tf_insert_view() returns trigger
as 
$$
declare
v_clazz_id char(8);
begin
if New.name is NULL then
insert into student(student_id,last_name,first_name,gender,dob)
values(New.student_id,new.last_name,new.first_name,new.gender,new.dob);
return new;
else 
select clazz_id into v_clazz_id
from clazz where lower(name)=lower(new.name);
if v_clazz_id is null then
raise notice'ten lop(%) sinh vien chua ton tai',new.name;
return null;
else 
insert into student(student_id,last_name,first_name,gender,dob,clazz_id)
values (new.student_id,new.last_name,new.first_name,new.gender,new.dob,v_clazz_id);
end if;
return new;
end if;
end;
$$ 
language plpgsql;
create trigger tg_insteadof
instead of insert on v_student_class_shortinfos
for each row
execute procedure tf_insert_view();
-- check
insert into v_student_class_shortinfos(student_id,last_name,first_name,gender,dob,clazz_id) values ( '2015012','Nguyen','Oanh,'f','1990-01-01','null);
--------------------------------------------
CREATE OR REPLACE FUNCTION tf_after_number_student() RETURNS TRIGGER AS
$$
BEGIN
    update clazz set number_students = number_students + 1 
        where clazz_id = new.clazz_id;
END
$$
LANGUAGE plpgsql;

CREATE TRIGGER tg_after_number_student 
AFTER INSERT ON student
FOR EACH ROW
WHEN (new.clazz_id is not null)
EXECUTE PROCEDURE tf_after_number_student(); 
---------------------------------------------------------------------
CREATE or replace function delete_number_student() returns trigger as
$$
begin
update clazz set number_students = number_students -1
where clazz_id = old.clazz_id;
end
$$
language plpgsql;
create trigger delete_number_student
after delete on student
for each row
execute procedure delete_number_student();