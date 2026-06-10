CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    manager_id INT
);

INSERT INTO employees VALUES
(1,'Aman','IT',70000,NULL),
(2,'Rahul','IT',60000,1),
(3,'Priya','HR',50000,NULL),
(4,'Neha','HR',45000,3),
(5,'Karan','Finance',80000,NULL),
(6,'Riya','Finance',75000,5),
(7,'Vikas','IT',55000,1),
(8,'Anjali','Finance',65000,5);
drop table employees;
-- 1. Show employees earning more than the company average salary.
-- Use a CTE to calculate average salary first.
with avg_salary as (select avg(salary) as company_avg from employees)
select emp_id , emp_name from employees 
where salary > (select company_avg from avg_salary);
-- 2.Find departments whose average salary is greater than 60,000.
-- Use a CTE for department-wise average salary.
WITH dept_avg AS (
    SELECT department,
           AVG(salary) AS avg_dept_salary
    FROM employees
    GROUP BY department
)

SELECT department
FROM dept_avg
WHERE avg_dept_salary > 60000;

avg_dept_salary
-- 3. Display employees along with their department's average salary.
-- Output:
-- emp_name	salary	dept_avg_salary	
WITH dept_avg AS (
    SELECT department,
           AVG(salary) AS dept_avg_salary
    FROM employees
    GROUP BY department
)

select e.emp_name , e.salary , d.dept_avg_salary
from employees e 
inner join dept_avg d 
ON e.department = d.department;
-- 4. Find employees whose salary is above their department average.
-- Use a CTE for department averages.
WITH dept_avg AS (
    SELECT department,
           AVG(salary) AS dept_avg
    FROM employees
    GROUP BY department
)

SELECT e.emp_name,
       e.department,
       e.salary
FROM employees e
INNER JOIN dept_avg d
    ON e.department = d.department
WHERE e.salary > d.dept_avg;
-- 5. Show the highest-paid employee from each department.
-- Use a CTE to calculate max salary per department.
WITH high AS (
    SELECT department,
           MAX(salary) AS highest_salary
    FROM employees
    GROUP BY department
)

SELECT e.emp_name,
       e.department,
       e.salary
FROM employees e
INNER JOIN high h
    ON e.department = h.department
   AND e.salary = h.highest_salary;
