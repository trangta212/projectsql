//tao view
    CREATE OR REPLACE VIEW student_shortinfos as
select * from student
update ten moi
update student_shortinfos set first_name ='Minh Huyen'
 where student_id ='20160004;'
 Bai 2: 
 CREATE OR REPLACE VIEW student_class_shortinfos as
select s.student_id,first_name,last_name,gender, c.name
from student s, clazz c
 where s.clazz_id = c.clazz_id;
 \encoding 'UTF8'

-- xóa view
drop view student_class_shortinfos