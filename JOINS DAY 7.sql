CREATE TABLE departmentss (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);

INSERT INTO departmentss VALUES
(1,'IT'),
(2,'HR'),
(3,'Finance'),
(4,'Marketing'),
(5,'Sales'),
(6,'Operations');
drop table if exists department;
CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    manager_id INT,
    salary INT
);

INSERT INTO employee VALUES
(101,'John',1,NULL,90000),
(102,'Aman',1,101,60000),
(103,'Rohit',1,101,65000),
(104,'Priya',2,NULL,85000),
(105,'Neha',2,104,50000),
(106,'Vikas',3,NULL,95000),
(107,'Ankit',3,106,70000),
(108,'Pooja',4,NULL,80000),
(109,'Rahul',5,NULL,88000),
(110,'Simran',5,109,55000),
(111,'Karan',5,109,58000),
(112,'Meera',1,101,62000),
(113,'Deepak',1,101,61000),
(114,'Nidhi',2,104,52000),
(115,'Arjun',NULL,NULL,45000);
CREATE TABLE projectss (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO projectss VALUES
(1,'E-Commerce Dashboard',102),
(2,'HR Analytics',105),
(3,'Finance Report',107),
(4,'Marketing Campaign',108),
(5,'Sales Dashboard',110),
(6,'Inventory System',NULL),
(7,'Customer Segmentation',112),
(8,'Forecasting Model',113),
(9,'Payroll Automation',NULL),
(10,'CRM Upgrade',111);
CREATE TABLE customerss (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

INSERT INTO customerss VALUES
(1,'Ramesh'),
(2,'Suresh'),
(3,'Geeta'),
(4,'Anjali'),
(5,'Mohan'),
(6,'Kiran');
CREATE TABLE orderss (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_amount DECIMAL(10,2)
);

INSERT INTO orderss VALUES
(101,1,2500),
(102,1,1800),
(103,2,3200),
(104,3,4500),
(105,3,2200),
(106,3,3100),
(107,5,5000),
(108,NULL,1500);
select * from departmentss;
select * from employee;
select * from projectss;
select * from customerss;
select * from orderss;

-- Customers with no orders
-- Expected:

-- Anjali
-- Kiran
select customer_name from customerss c
left   join orderss o 
on c.customer_id = o.customer_id
where o.customer_id is null;

-- Employees with no projects
-- Expected:
-- John
-- Rohit
-- Priya
-- Vikas
-- Rahul
-- Meera? -> No (has project)
-- Deepak? -> Yes (no project)
-- Nidhi
-- Arjun
select e.emp_id, e.emp_name from employees e
left join projectss p 
on e.emp_id = p.emp_id
where p.emp_id is null;

-- Departments with no employees
-- Expected:
-- Operations

select * from departmentss d
left join employee e
on d.department_id = e.department_id 
where e.department_id is null;




-- Projects with no employee assigned
-- Expected:
-- Inventory System
-- Payroll Automation
select * from projectss p 
left join employee e
on e.emp_id = p.emp_id ;
where e.emp_id is null;

-- Manager with more than 3 employees
-- Expected:
-- John (4 employees)
------------------------------------------------------------------------------
--(           wrong query have to solve again        !!)
select e.emp_id  from employee e 
 inner join employee m
on e.manager_id = m.manager_id 
 group by e.emp_id 
 having count(*) > 4;
------------------------------------------------------------------------------

-- Employee earning more than manager
-- Expected:
-- None in current dataset

SELECT e.emp_name,
       e.salary,
       m.emp_name AS manager_name,
       m.salary AS manager_salary
FROM employee e
JOIN employee m
ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;
-- Customers with more than 2 orders
-- Expected:
-- Geeta (3 orders)
	
select c.customer_name
from customers c 
left join orderss o
on c.customer_id = o.customer_id
group by c.customer_name 
having  count(c.customer_id) > 2 ;

















