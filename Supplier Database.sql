create database supplier;
use supplier;

create table supplier(
sid int,
sname varchar(20),
city varchar(20),
primary key(sid));
create table parts(
pid int,
pname varchar(20),
color varchar(20),
primary key(pid));
create table catalog(
sid int,
pid int,
cost int,
primary key(sid,pid),
foreign key(sid) references supplier(sid),
foreign key(pid) references parts(pid));

insert into supplier values(10001,'Acme Widget','Bangalore');
insert into supplier values(10002,'Johns','Kolkata');
insert into supplier values(10003,'Vimal','Mumbai');
insert into supplier values(10004,'Reliance','Delhi');

insert into parts values(20001,'Book','Red');
insert into parts values(20002,'Pen','Red');
insert into parts values(20003,'Pencil','Green');
insert into parts values(20004,'Mobile','Green');
insert into parts values(20005,'Charger','Black');

insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);

select * from supplier;
select * from parts;
select * from catalog;
select distinct p.pname from parts p,
catalog c where p.pid = c.pid;

select distinct s.sname from catalog c,
supplier s where c.sid = s.sid and
NOT EXISTS(select p.pid from parts p
where NOT EXISTS(select c1.sid from
catalog c1 where c1.sid = c.sid and c1.pid = c.pid));

select distinct s.sname from catalog c,
supplier s where c.sid = s.sid and
NOT EXISTS(select p.pid from parts p
where p.color = 'Red' and NOT EXISTS
(select c1.sid from catalog c1 where
c1.sid and c1.pid = p.pid and p.color = 'Red'));

select p.pname from parts p, catalog c, supplier s
where p.pid = c.pid and c.sid = s.sid and
s.sname = 'Acme Widget' and NOT EXISTS
(select * from catalog c1, supplier s1
where p.pid = c1.pid and c1.sid = s1.sid
and s1.sname != 'Acme Widget');


select p.pid, s.sname from parts p,
supplier s, catalog c where c.pid = p.pid
and c.sid = s.sid and c.cost = (select max(c1.cost)
from catalog c1 where c1.pid = p.pid);