#Kronberg Robin Asssignment 8#


#1#
DROP DATABSE IF EXISTS Painters;
create database Painters;
use Painters;

#2#
drop view if exists job_empjob;
drop view if exists pay_per_employee;

#3#
drop table if exists empjob;
drop table if exists job;
drop table if exists employee;
drop table if exists customer;

#4#
create table customer
(
custid		smallint(4)		PRIMARY KEY				,
ctype		enum('C','R')							,
clname		varchar(35)		NOT NULL				,
cfname		varchar(15)		NOT NULL				,
addr		varchar(40)								,
city 		varchar(20)								,
state		char(2)						DEFAULT 'SC',
cphone		char(12)		NOT NULL	UNIQUE		

)

ENGINE = INNODB;

create table employee
(

ssn			char(9)			PRIMARY KEY				,
elname		varchar(35)		NOT NULL				,
efname		varchar(15)								,
ephone		char(12)								,
hrrate		decimal(5,2)				DEFAULT 5.15	)
ENGINE = INNODB;


create table job
(
jobnum		smallint unsigned	PRIMARY KEY			,
custid		smallint								,
jobdate		date									,
descr		varchar(2000)							,
amobilled	decimal(7,2)							,
amopaid		decimal(7,2)							,
constraint job_fk_empjob
	FOREIGN KEY(custid)
	REFERENCES customer(custid)

)
ENGINE = INNODB;




create table empjob
(

ssn			char(9)									,
jobnum		smallint unsigned						,
hrsperjob	decimal(5,2)							,
constraint empjob_pk
	PRIMARY KEY (ssn, jobnum),
constraint empjob_fk_1
	FOREIGN KEY (ssn)
	REFERENCES employee(ssn),
constraint empjob_fk_2
	FOREIGN KEY (jobnum)
	REFERENCES job(jobnum)
)
ENGINE = INNODB;

#5#
create index cust_name_index
	on customer(cfname, clname DESC);

#6#
create index job_custID_fk
	on job(custid);
	
create index empjob_ssn_fk
	on empjob(ssn);
	
create index empjob_jobnum_fk
	on empjob(jobnum);





#7#
insert into customer
(custid, ctype, clname, cfname, addr, city, state, cphone)
values
(1000, "C", "Majors", "Brad", "152 Denton Ln.", "Denton", "TX", "8001234567"),
(1010, "R", "Weiss", "Janet", "154 Denton Ln.", "Denton", "TX", "8887654321"),
(1020, "C", "Furter", "Frank", "21 Frankenstein Pl.", "Denton", "TX", "8012345667");

insert into employee
(ssn, elname, efname, ephone, hrrate)
values
("000000000", "Raff", "Riff", "8012345667", 6.00),
("111111111", "Raff", "Magenta", "8012345667", 6.00),
("222222222", "Scott", "Doctor", "9999999999", 8.00);

insert into job
(jobnum, custid, jobdate, descr, amobilled, amopaid)
values
(2000, 1000, '2017-10-29', "Paint church door", 100.00, 100.00),
(2010, 1010, '2017-10-30', "Paint 'just married' onto vehicle", 200.00, 50.00),
(2020, 1020, '2017-10-31', "Paint interior of walk-in freezer", 500.00, 0.00);

insert into empjob
(ssn, jobnum, hrsperjob)
values
("000000000", 2000, 5),
("111111111", 2010, 10 ),
("222222222", 2020, 20 );

#8#
create or replace view job_empjob AS
select job.jobnum, job.custid, job.jobdate, empjob.ssn
from job
join empjob on job.jobnum=empjob.jobnum;
	
#9#
Create or replace view pay_per_employee AS
	select sum(empjob.hrsperjob)*employee.hrrate AS 'employee pay',
		(employee.efname, " ", employee.elname) AS 'employee name'
	from employee
	join empjob on empjob.ssn=employee.ssn;
select * from pay_per_employee;

#10#
update customer
set clname = "Furter", cfname = "Rocky"
where custID=1020;

update employee
set elname = "Ologist" , efname ="Crimin"
where ssn = "222222222";


update job
set descr = "Paint motorcycle" 
where jobnum = 2020;

update empjob
set hrsperjob = 25
where jobnum= 2020;


#11#

delete from empjob
where ssn = "000000000";

delete from job 
where jobnum = 2000;

delete from employee
where ssn = "000000000";


delete from customer
where custID = 1000;





#12#
create user magenta@localhost
	IDENTIFIED by 'aliens';
	
create user eddie@localhost
	IDENTIFIED by 'meatloaf';
	
create user columbia@localhost
	IDENTIFIED by 'sequins';
	
#13#

grant all 
on Painters.* 
to magenta@localhost
IDENTIFIED by 'aliens';

grant select
on Painters.*
to eddie@localhost
IDENTIFIED by 'meatloaf';

grant select, insert, update, delete
on painters.customer
to columbia@localhost
identified by 'sequins';

grant select
on Painters.employee
to columbia@localhost
identified by 'sequins';


















	


































