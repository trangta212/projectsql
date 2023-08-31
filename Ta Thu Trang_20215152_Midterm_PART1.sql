1/
select orl.orderlineid,quantity, pr.prod_id,price, ord.totalamount
from orders ord, orderlines orl, products pr
where ord.orderid = orl.orderid and orl.prod_id = pr.prod_id
and ord.orderid = '942';
2/
select max(totalamount),min(totalamount),avg(totalamount)
from orders
3/
select country,count(*)
from customers
group by country
4/
select *
from products
where title = 'Apollo';
5/
7/
select c.customerid,firstname,lastname
from customers c,orders ord,products pr, orderlines orl
where c.customerid = ord.customerid and  
ord.orderid = orl.orderid and orl.prod_id = pr.prod_id
and title ='AIRPORT ROBBERS'
intersect
select c.customerid,firstname,lastname
from customers c,orders ord,products pr, orderlines orl
where c.customerid = ord.customerid and  
ord.orderid = orl.orderid and orl.prod_id = pr.prod_id
and title ='AGENT ORDER'
9/
select pr.*
from products pr, categories c
where pr.category =c.category and categoryname = 'Documentary';
10/
select * 
from customers
where country = 'Germany'
