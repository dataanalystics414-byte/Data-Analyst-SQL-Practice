CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    manager_id INT
);

INSERT INTO employees VALUES
(1,'Aman','IT',60000,NULL),
(2,'Rohit','HR',45000,1),
(3,'Priya','IT',75000,1),
(4,'Neha','Finance',55000,1),
(5,'Karan','IT',80000,3),
(6,'Simran','HR',50000,2),
(7,'Raj','Finance',65000,4),
(8,'Anjali','IT',70000,3);

CREATE TABLE projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO projects VALUES
(101,'Dashboard',1),
(102,'Recruitment System',2),
(103,'Sales Analysis',3),
(104,'Budget Planning',4),
(105,'Inventory Report',5),
(106,'Employee Portal',3);
drop table projects;
SELECT * FROM EMPLOYEES;
SELECT * FROM projects;
-- Find employees who are assigned to at least one project.
SELECT * FROM EMPLOYEES 
where emp_id in (select emp_id from projects);
-- Find employees who are NOT assigned to any project.
SELECT * FROM EMPLOYEES 
where emp_id not in (select emp_id from projects);
-- Find departments that have employees earning more than 70,000.
select  distinct department 
from employees
where department in (select department from employees where salary > 70000);
-- Find employees whose emp_id appears in the Projects table.
SELECT DISTINCT manager_id
FROM employees
WHERE emp_id IN (
    SELECT emp_id
    FROM projects
)
AND manager_id IS NOT NULL;
-- Find employees earning more than ANY employee in the HR department.
select emp_name 
from employees 
where salary  > any(select salary from employees where department = 'HR')
-- Find employees earning less than ANY employee in the Finance department.
select emp_name 
from employees 
where salary  > any(select salary from employees where department = 'Finance');
-- Find employees earning more than ANY salary in the IT department.
select emp_name 
from employees 
where salary  > any(select salary from employees where department = 'IT');
-- Find employees whose salary is greater than ANY employee managed by manager 1.
select emp_name , salary from employees 
where salary >any(select salary from employees 
where manager_id = 1)


-- Find employees earning more than ANY employee working on a project.
select emp_name ,salary from employees 
where salary >any(select salary from employees 
where emp_id in( select emp_id from project));

-- Find employees earning more than ALL employees in the HR department.
select emp_name , salary 
from employees 
where salary >all(select salary from employees 
where department = 'HR')
-- Find employees earning less than ALL employees in the IT department.
select emp_name , salary 
from employees 
where salary <all(select salary from employees 
where department = 'IT')
-- Find employees earning more than ALL employees managed by manager 3.
select emp_name , salary from employees 
where salary > all(select salary from employees 
where manager_id = 3
)
-- Find employees earning more than ALL employees working on projects.
SELECT emp_name, salary
FROM employees
WHERE salary > ALL (
    SELECT salary
    FROM employees
    WHERE emp_id IN (
        SELECT emp_id
        FROM projects
    )
);
-- Find employees whose salary is higher than ALL Finance employees.
select emp_name , salary 
from employees 
where salary >all(select salary from employees 
where department = 'Finance')


-- Find employees whose salary is above the company average salary.
select emp_name , salary 
from employees 
where salary >(select avg(salary) from employees);
-- Find employees earning the highest salary.
select emp_name 
from employees 
where salary = (select max(salary)from employees);
-- Find employees earning the second-highest salary. (imp)
SELECT DISTINCT salary,emp_name  
FROM employees
ORDER BY salary DESC
OFFSET 2 LIMIT 1;
-- Find departments whose average salary is greater than the company average salary.
select  department  from employees
group by department 
having avg(salary) > (select avg(salary) from employees );
-- Find employees earning above their department's average salary.
select emp_name from employees  e
where salary > (select avg(salary) from employees 
where department = e.department
);
-- Find the department with the highest average salary.
SELECT department 
FROM employees
GROUP BY department
HAVING AVG(salary) > (
    SELECT AVG(salary)
    FROM employees
);
-- Find employees who earn the maximum salary in their department.
select  emp_name , salary from employees e
where salary = (select max(salary) from employees 
where department = e.department );
-- Find employees who earn more than their manager.
select emp_name from employees e
where salary > (select salary from employees m
where m.emp_id = e.manager_id );
-- Find departments where every employee earns more than 50,000.
SELECT department
FROM employees
GROUP BY department
HAVING MIN(salary) > 50000;
-- Find employees who work on more projects than the average employee.
SELECT e.emp_name
FROM employees e
JOIN projects p
ON e.emp_id = p.emp_id
GROUP BY e.emp_id, e.emp_name
HAVING COUNT(*) > (
    SELECT AVG(project_count)
    FROM (
        SELECT emp_id,
               COUNT(*) AS project_count
        FROM projects
        GROUP BY emp_id
    ) t
);