-- 1. List the following details of each employee: employee number, last name, first name, gender, and salary.

select e.emp_no, e.last_name, e.first_name, e.gender, s.salary
from salaries as s
inner join employees as e
on e.emp_no = s.emp_no;

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