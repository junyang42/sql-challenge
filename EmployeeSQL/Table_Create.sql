drop table departments;
create table departments (
	dept_no varchar primary key not null,
	dept_name varchar(30)
);

drop table employees;
create table employees (
	emp_no int primary key not null,
	birth_date date,
	first_name varchar,
	last_name varchar,
	gender varchar,
	hire_date date
);

drop table dep_emp;
create table dep_emp (
	emp_no int not null,
	dept_no varchar,
	foreign key(emp_no) references employees(emp_no),
	foreign key(dept_no) references departments(dept_no),
	from_date date,
	to_date date,
	primary key(emp_no, dept_no, from_date)
);

drop table dept_manager;
create table dept_manager (	
	dept_no varchar,
	emp_no int not null,
	foreign key(emp_no) references employees(emp_no),
	foreign key(dept_no) references departments(dept_no),
	from_date date,
	to_date date,
	primary key(emp_no, dept_no, from_date)	
);

drop table salaries;
create table salaries (
	emp_no int not null,
	foreign key(emp_no) references employees(emp_no),
	salary int not null,
	from_date date,
	to_date date,
	primary key(emp_no, from_date)
);

drop table titles;
create table titles (
	emp_no int not null,
	foreign key(emp_no) references employees(emp_no),
	title varchar(30),
	from_date date,
	to_date date,
	primary key(emp_no, title, from_date)
);

select * from departments;
select * from employees;
select * from salaries;
select * from titles;
select * from dep_emp;
select * from dept_manager;