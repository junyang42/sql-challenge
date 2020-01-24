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

-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from employees as e
inner join salaries as s
on e.emp_no = s.emp_no
order by emp_no;

-- 2. List employees who were hired in 1986.

select * from employees
where (select extract(year from hire_date) = 1986);

-- 3. List the manager of each department with the following information: 
--    department number, department name, the manager's employee number, last name, first name, and start and end employment dates.

select ma.dept_no, d.dept_name, ma.emp_no, e.last_name, e.first_name, ma.from_date, ma.to_date
from dept_manager as ma
	inner join departments as d
	on ma.dept_no = d.dept_no
		inner join employees as e
		on e.emp_no = ma.emp_no

-- 4. List the department of each employee with the following information: employee number, last name, first name, and department name.

select e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d
	inner join dep_emp as de
	on d.dept_no = de.dept_no
		inner join employees as e
		on e.emp_no = de.emp_no
;
		
-- 5. List all employees whose first name is "Hercules" and last names begin with "B."

select * from employees
where first_name = 'Hercules' 
and last_name like '%B%';

-- 6. List all employees in the Sales department, including their employee number, last name, first name, and department name.

Select * from 
(select e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d
	inner join dep_emp as de
	on d.dept_no = de.dept_no
		inner join employees as e
		on e.emp_no = de.emp_no
) as combine_emp_dep
where dept_name = 'Sales'; 

-- 7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.

Select * from 
(select e.emp_no, e.last_name, e.first_name, d.dept_name
from departments as d
	inner join dep_emp as de
	on d.dept_no = de.dept_no
		inner join employees as e
		on e.emp_no = de.emp_no
) as combine_emp_dep
where dept_name = 'Sales'
or dept_name = 'Development'; 

-- 8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.		

select last_name, count(last_name) as "frequency count of employee last names"
from employees
group by last_name
order by count(last_name) desc;

