CREATE TABLE employ (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT
);

INSERT INTO employ VALUES
(1,'Aman','IT',50000),
(2,'Riya','HR',45000),
(3,'Mohit','IT',70000),
(4,'Neha','Finance',60000),
(5,'Karan','IT',80000),
(6,'Pooja','HR',55000),
(7,'Rahul','Finance',65000),
(8,'Simran','Marketing',40000),
(9,'Vikas','Marketing',42000),
(10,'Anjali','Finance',75000);

CREATE TABLE deptt (
    department VARCHAR(30)
);

INSERT INTO deptt VALUES
('IT'),
('HR'),
('Finance'),
('Marketing'),
('Sales');
select * from employ ;
select * from deptt;
CREATE TABLE sale (
    sale_id INT,
    emp_id INT,
    sales_amount INT,
    sale_month VARCHAR(20)
);

INSERT INTO sale VALUES
(1,1,15000,'Jan'),
(2,1,18000,'Feb'),
(3,2,12000,'Jan'),
(4,3,25000,'Jan'),
(5,3,30000,'Feb'),
(6,4,22000,'Jan'),
(7,5,35000,'Feb'),
(8,6,14000,'Jan'),
(9,7,28000,'Feb'),
(10,8,10000,'Jan'),
(11,9,11000,'Feb'),
(12,10,32000,'Feb');

CREATE TABLE manager (
    department VARCHAR(30),
    manager_name VARCHAR(50),
    manager_salary INT
);

INSERT INTO manager VALUES
('IT','Rajesh',90000),
('HR','Sunita',65000),
('Finance','Amit',85000),
('Marketing','Priya',50000);
select * from employ ;
select * from deptt;
select * from sale ;
select * from manager;
-- Find employees who work in departments listed in the departments table.
select emp_name from employ
where department in (select department from deptt);

-- Find employees working in either IT or Finance using a subquery.
select emp_name from employ
where department in ( select department from empl);

-- Find employees belonging to departments where at least one employee earns more than 70000.
SELECT
	EMP_NAME
FROM
	EMPLOY
WHERE
	DEPARTMENT IN (
		SELECT
			DEPARTMENT
		FROM employ
	where 
			SALARY > 70000
	);
-- Find departments that have at least one employee.
SELECT department
FROM deptt d
WHERE EXISTS (
    SELECT 1
    FROM employ e
    WHERE e.department = d.department
);

-- Find employees whose department exists in departments table.
select emp_name from employ e
where  EXISTS  (select department  from deptt d
where  e.department = d.department
);

-- Find departments that do not have any employees.
-- (Expected: Sales)
SELECT department
FROM deptt d
WHERE NOT EXISTS (
    SELECT 1
    FROM employ e
    WHERE e.department = d.department
);

-- Find employees earning more than ANY Finance employee.
select emp_name from employ
where salary >  any(select salary from  employ
where department = 'Finance');
-- Find employees earning more than ANY HR employee.
select emp_name, department from  employ
where salary > any(select salary from employ
where department  = 'HR');
	
-- Find employees earning less than ANY IT employee.
select emp_name from employ 
where salary < any(select salary from employ
where department = 'IT');



	-- Find employees earning more than ALL HR employees.
	select emp_name from employ 
	where salary >  all( select salary from employ
	where department = 'HR' );

-- Find employees earning more than ALL Marketing employees.
	select emp_name from employ 
	where salary >  all( select salary from employ
	where department = 'Marketing' );

	-- Find employees earning less than ALL Finance employees.
select emp_name from employ 
	where salary >  all( select salary from employ
	where department = 'Finance' );
	
-- Correlated Subqueries
-- Find employees earning more than the average salary of their own department.
select emp_name from employ e
where salary > (select avg(salary) from employ d
where e.department = d.department);

-- Find employees earning the highest salary in their department.
select emp_name from employ e
where salary = (select max(salary) from employ d 
where e.department = d.department);

-- Find employees earning the lowest salary in their department.
select emp_name from employ e
where salary = (select min(salary) from employ d 
where e.department = d.department);

-- Find employees whose salary equals the department average salary.
select emp_name from employ e
where salary = (select avg(salary) from employ d
where e.department = d.department);

-- Find departments whose average salary is greater than company average salary.
select 	department from employ e
group by department 
having avg(salary) > (select avg(salary) from employ);
                                    -- CTE Questions


-- Create a CTE showing employees earning above ₹50,000.
with  above_salary as (select emp_name from employ  where  salary > 50000)
select emp_name from above_salary;


-- Create a CTE showing department-wise average salary.
with deptwiseavg as (select department ,round(avg(salary),3) as avg_salary from employ 
group by department 
 )
select department ,avg_salary from deptwiseavg;

-- Using a CTE, find employees earning above their department average.
with abovedept as  ( select emp_name from employ e
where salary > ( select avg(salary) from  employ d
where e.department = d.department)
 )
 (select emp_name from abovedept )

-- Create a CTE showing total sales by employee.
with total_sales_by_emp as (select e.emp_name , sum(s.sales_amount) as total_sales from employ e
join sale s

on e.emp_id = s.emp_id
group by e.emp_id, e.emp_name
 )
select  emp_name , total_sales from total_sales_by_emp ;

-- Using the sales CTE, find employees whose total sales exceed ₹40,000.
with high_saler as  (select e.emp_name , sum(s.sales_amount) as total_sales   from employ e
join sale s
on e.emp_id = s.emp_id
group by e.emp_id , e.emp_name 
having sum(s.sales_amount) > 40000 )
select emp_name from high_saler;

-- Create a CTE showing department-wise employee count.
with emp_count as ( select count(e.*) as total_emp  , d.department from employ e 
join deptt d
on e.department = d.department
group by d.department)
select department , total_emp from emp_count;

-- Display departments having more than 2 employees.
with emp_count as ( select count(e.*) as total_emp  , d.department from employ e 
join deptt d
on e.department = d.department
group by d.department
having  count(e.*)>2)
select department , total_emp from emp_count; 

-- Create a CTE showing highest salary in each department.
-- Then display employees matching that salary.
WITH max_salary_dept_wise AS (
    SELECT
        department,
        MAX(salary) AS max_salary
    FROM employ
    GROUP BY department
)

SELECT
    e.emp_name,
    e.department,
    e.salary
FROM employ e
JOIN max_salary_dept_wise m
    ON e.department = m.department
   AND e.salary = m.max_salary;

-- Create a CTE showing monthly sales totals.
-- Display months whose sales exceed average monthly sales.   
WITH monthly_sales_total AS (
    SELECT
        sale_month,
        SUM(sales_amount) AS sum_sales_month
    FROM sale
    GROUP BY sale_month
)

SELECT
    sale_month,
    sum_sales_month
FROM monthly_sales_total
WHERE sum_sales_month > (
    SELECT AVG(sum_sales_month)
    FROM monthly_sales_total
);
