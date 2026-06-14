CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT
);

INSERT INTO employees VALUES
(1,'Aman','IT',75000),
(2,'Rohit','HR',45000),
(3,'Priya','Finance',90000),
(4,'Neha','IT',55000),
(5,'Karan','Marketing',40000),
(6,'Sneha','HR',65000),
(7,'Vikas','Finance',85000),
(8,'Pooja','IT',30000),
(9,'Ankit','Marketing',70000),
(10,'Riya','HR',95000);
CREATE TABLE managers (
    emp_id INT,
    emp_name VARCHAR(50)
);

INSERT INTO managers VALUES
(1,'Aman'),
(3,'Priya'),
(6,'Sneha'),
(10,'Riya'),
(11,'Arjun');
CREATE TABLE contractors (
    emp_id INT,
    emp_name VARCHAR(50)
);

INSERT INTO contractors VALUES
(8,'Pooja'),
(9,'Ankit'),
(11,'Arjun'),
(12,'Meera'),
(13,'Raj');
-- Show employee name, department, salary and bonus amount:

-- Salary > 80000 → 20% bonus
-- Salary between 60000 and 80000 → 10% bonus
-- -- Otherwise → 5% bonus
select * from employees;
select * from managers;
select * from contractors;


select emp_name , department , salary ,
case when salary > 80000 then salary + salary*.20
when	 salary between 60000 and 80000 then salary + salary*.10
else salary+salary*.05 	end as salary_after_bonus from employees;

-- Display employee name and salary status:

-- Above Department Average
-- Below Department Average
SELECT
	EMP_NAME,
	DEPARTMENT CASE
		WHEN SALARY > AVG(SALARY) OVER (
			PARTITION BY
				DEPARTMENT
		) THEN 'AboveDepartmentAverage'
		ELSE 'belowDepartmentAverage'
	END AS SALARY_STATUS
FROM
	EMPLOYEES;
-- Create a report showing:
-- Department
-- Total Employees
-- High Salary Employees (salary > 70000)
-- Use CASE inside aggregate functions.

select department , count(emp_id) over(partition by department) as total_employees,
case 
	when salary > 70000 then 'high_salary'
	else 'low' end as status from employees;



                             -- UNION, UNION ALL, INTERSECT, EXCEPT Questions 
-- Combine Employees and Contractors with a column.
SELECT
    emp_name,
    'Employee' AS source
FROM employees

UNION ALL

SELECT
    emp_name,
    'Contractor' AS source
FROM contractors;
-- Create a master people directory from:
-- employees
-- managers
-- contractors
-- Remove duplicates
select emp_name,  'employeesss' as master  from employees
union 
select emp_name  ,'managerss' as master  from managers
union 
select emp_name,  'contractorss' as master from contractors;

-- Count total unique people across all three tables.
select count(distinct emp_id) from
(select emp_id  from employees
union
select emp_id from managers
union
select emp_id  from contractors
);
-- Find people appearing in more than one table.
select emp_name , count(*) as occurance
from
(select emp_name, emp_id  from employees
union all
select emp_name,emp_id from managers
union all 
select emp_name,emp_id  from contractors
) t 

group by emp_name 
having  count(*)>=2;
-- Create one report containing:
-- Employee
-- Manager
-- Contractor
SELECT
	EMP_ID,
	EMP_NAME,
	ROLL
FROM
	(
		SELECT
			EMP_ID,
			EMP_NAME,
			  'employees '  as ROLL from employees 
			union  all 
		SELECT
			EMP_ID,
			EMP_NAME,
			  'managers ' as ROLL  from managers   
			union all 
			SELECT
			EMP_ID,
			EMP_NAME,
			  'contractor ' as ROLL  from contractors 
	) t;

-- Find employees who are also managers.
select emp_name  from employees
intersect 
select emp_name from managers;

-- Find employees who are also contractors.
select emp_id , emp_name from employees
intersect 
select emp_id , emp_name from contractors;
-- Find people present in all three tables.
select  emp_id , emp_name  from employees
intersect  
select  emp_id , emp_name from managers
intersect 
select emp_id , emp_name from contractors;
-- Find names common between managers and contractors.
select  emp_id , emp_name , 'managers' as role from managers
intersect 
select emp_id , emp_name, 'contractors' as role from contractors; 
-- Find employees who are managers but not contractors.
-- (Hint: INTERSECT + EXCEPT)
select emp_name from employees 
intersect 
select emp_name from managers
except 
select emp_name from contractors;
-- Find employees who are not managers.
select emp_id, emp_name from employees 
except 
select emp_id , emp_name from managers;
-- Find contractors who are not employees.
select emp_id, emp_name from contractors 
except 
select emp_id , emp_name from employees;
-- Find managers who are not employees.
select emp_id, emp_name from managers 
except 
select emp_id , emp_name from employees;
-- Find employees who are neither managers nor contractors.
select emp_id, emp_name from employees 
except 
select emp_id , emp_name from managers
except 
select emp_id, emp_name from contractors ;
-- Find IDs existing in employees but not in either managers or contractors.
select emp_id from employees 
except 
select emp_id   from managers
except
select emp_id from contractors;


 
















