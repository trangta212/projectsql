select n.TenNCC
from NCC nc, Mathang m, Cung cap c
where nc.msncc = c.msncc and m.msmh = c.msmh
and m.mausac ='red';

select n.TenNCC
from NCC nc, Mathang m, Cung cap c
where nc.msncc = c.msncc and m.msmh = c.msmh
and m.mausac ='red' or m.mausac ='green';
select n.TenNCC
from NCC nc, Mathang m, Cung cap c
where nc.msncc = c.msncc and m.msmh = c.msmh
and m.mausac ='red'
intersect
select n.TenNCC
from NCC nc, Mathang m, Cung cap c
where nc.msncc = c.msncc and m.msmh = c.msmh
and m.mausac ='green';
 
 select m.msmh 
 from NCC nc, Mathang m, Cung cap c
where nc.msncc = c.msncc and m.msmh = c.msmh
group by m.msmh
having count(*)>2;


