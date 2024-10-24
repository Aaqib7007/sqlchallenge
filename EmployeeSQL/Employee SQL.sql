-- Create departments table
CREATE TABLE departments (
    dept_no VARCHAR(255) NOT NULL,
    dept_name VARCHAR(255) NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (dept_no),
    CONSTRAINT uc_departments_dept_name UNIQUE (dept_name)
);

-- Create titles table
CREATE TABLE titles (
    title_id VARCHAR(255) NOT NULL,
    title VARCHAR(255) NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (title_id),
    CONSTRAINT uc_titles_title UNIQUE (title)
);

-- Create employees table
CREATE TABLE employees (
    emp_no INT NOT NULL,
    emp_title_id VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (emp_no),
    CONSTRAINT fk_employees_emp_title_id FOREIGN KEY (emp_title_id) REFERENCES titles (title_id)
);

-- Create salaries table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary INT NOT NULL,
    CONSTRAINT pk_salaries PRIMARY KEY (emp_no),
    CONSTRAINT fk_salaries_emp_no FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Create dept_emp table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(255) NOT NULL,
    CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- Create dept_manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(255) NOT NULL,
    emp_no INT NOT NULL,
    CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Dropping the tables to create compostie primary keys 
DROP TABLE dept_emp CASCADE;
DROP TABLE dept_manager CASCADE;

-- Recreating dept_emp table
CREATE TABLE dept_emp (
    emp_no INT NOT NULL,
    dept_no VARCHAR(255) NOT NULL,
	CONSTRAINT pk_dept_emp PRIMARY KEY (emp_no, dept_no),  -- Composite primary key
    CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY (emp_no) REFERENCES employees (emp_no),
    CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY (dept_no) REFERENCES departments (dept_no)
);

-- Recreating dept_manager table
CREATE TABLE dept_manager (
    dept_no VARCHAR(255) NOT NULL,
    emp_no INT NOT NULL,
	CONSTRAINT pk_dept_manager PRIMARY KEY (dept_no, emp_no),  -- Composite primary key
    CONSTRAINT fk_dept_manager_dept_no FOREIGN KEY (dept_no) REFERENCES departments (dept_no),
    CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

select * from dept_emp
select * from dept_manager

--Data Analysis

--1. List the employee number, last name, first name, sex, and salary of each employee.
Select e.emp_no,
    first_name,
    last_name,
    sex,
	salary
from employees e
join salaries s
on e.emp_no = s.emp_no

--2. List the first name, last name, 
--and hire date for the employees who were hired in 1986.
Select first_name,
    last_name,
    hire_date
from employees e
join salaries s
on e.emp_no = s.emp_no
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

--3. List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.

Select
    d.dept_no,
	d.dept_name,
    e.emp_no,
	e.first_name,
    e.last_name
from dept_manager dm
join departments d
on d.dept_no = dm.dept_no
join employees e
on dm.emp_no = e.emp_no

--4. List the department number for each employee along with that employee’s 
-- employee number, last name, first name, and department name.

Select
    d.dept_no,
	d.dept_name,
    e.emp_no,
	e.first_name,
    e.last_name
from dept_emp de
join departments d
on d.dept_no = de.dept_no
join employees e
on de.emp_no = e.emp_no

--5. List first name, last name, and sex of each employee whose first name is 
-- Hercules and whose last name begins with the letter B.
Select first_name,
    last_name,
    sex
from employees e
where first_name = 'Hercules'
and last_name like 'B%'

--6. List each employee in the Sales department, including their employee number, last name, and first name.
Select
	d.dept_name,
    e.emp_no,
	e.first_name,
    e.last_name
from dept_emp de
join departments d
on d.dept_no = de.dept_no
join employees e
on de.emp_no = e.emp_no
where dept_name = 'Sales'

--7. List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name.
Select
	d.dept_name,
    e.emp_no,
	e.first_name,
    e.last_name
from dept_emp de
join departments d
on d.dept_no = de.dept_no
join employees e
on de.emp_no = e.emp_no
where dept_name IN ('Sales','Development')

--8. List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name).
Select last_name,
    count(last_name)
from employees
group by last_name
order by count(last_name) Desc




