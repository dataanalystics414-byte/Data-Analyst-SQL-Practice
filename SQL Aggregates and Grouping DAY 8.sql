CREATE TABLE employee3 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    join_date DATE
);
INSERT INTO employees3 VALUES
(101,'Aman','IT',55000,'Delhi','2022-01-15'),
(102,'Riya','HR',45000,'Mumbai','2023-03-12'),
(103,'Karan','Finance',70000,'Delhi','2021-06-20'),
(104,'Sneha','IT',62000,'Pune','2022-09-10'),
(105,'Rahul','HR',48000,'Mumbai','2023-02-25'),
(106,'Priya','Finance',75000,'Delhi','2021-08-14'),
(107,'Arjun','IT',58000,'Pune','2022-04-05'),
(108,'Neha','Marketing',52000,'Bangalore','2023-01-11'),
(109,'Vikas','Marketing',60000,'Bangalore','2022-11-18'),
(110,'Pooja','HR',47000,'Mumbai','2023-07-09'),
(111,'Rohit','Finance',80000,'Delhi','2020-05-30'),
(112,'Anjali','IT',65000,'Pune','2021-12-22'),
(113,'Mohit','Marketing',55000,'Bangalore','2022-06-14'),
(114,'Simran','HR',51000,'Mumbai','2021-10-08'),
(115,'Deepak','Finance',90000,'Delhi','2020-09-17');
select * from employee3;
-- Q4
-- Find the highest salary.

select max(salary) from employee3;

-- Find the lowest salary.
select min(salary) from employee3;

-- Department-wise Aggregation
-- Q6 Find the number of employees in each department.
select department , count(emp_id)  as no_of_employees from employee3
group by  department ;

-- Find the total salary in each department.
select department , sum(salary) as total_salary from employee3
group by department ;

-- Find the average salary in each department.
select department , avg(salary) as avg_salary from employee3
group by department ;

-- Find the highest salary in each department.
select   department  , max(salary) as highest_salary from employee3
group by department ;

-- Find the lowest salary in each department.
select  department, min(salary)  as lowest_salary from employee3
group  by department;


                           -- City-wise Aggregation

-- Find the number of employees in each city.	
select city , count(emp_id) no_of_employees from employee3
group by city ;

-- Find the total salary paid in each city.
select city , sum(salary) salary_paid from employee3
group by city ;

-- Find the average salary in each city.
select city , round(avg(salary),3) avg_salary_paid from employee3
group by city ; 

-- Find the city with the highest average salary.
select city , round(avg(salary),3) avg_salary_paid from employee3 
group by city
order by round(avg(salary),3) desc 
limit 1;

-- Find the city with the lowest average salary.
select city , avg(salary) as avg_salary from employee3
group by city 
order by avg_salary asc 
limit 1;

                                   -- Date-Based Aggregation

-- Find the number of employees who joined in each year.
select date_part('year',join_date) as years , count(emp_id) from employee3
	group by years
	order by years desc;
	
-- Find the number of employees who joined in each month.
SELECT TO_CHAR(join_date, 'YYYY-MM') AS month_year,
       COUNT(*) AS employee_count
FROM employee3
GROUP BY TO_CHAR(join_date, 'YYYY-MM')
ORDER BY month_year;

-- Find the earliest joining date in each department.
select department , min(join_date) from employee3
group by department
;
-- Find the earliest joining date in each department.
select department , max(join_date) from employee3
group by department
;
-- Find departments where employees joined before 2021.
select department  from employee3
group by department 
having min(join_date) < '2021-01-01';

                                     -- HAVING Clause Practice

-- Find departments having more than 3 employees.
select department from employee3
group by department 
having count(emp_id) > 3;

-- Find cities having more than 2 employees.
select city from employee3
group by city 
having count(city) > 2;

-- Find departments whose average salary is greater than 60,000.
select department from employee3 
group by department 
having avg(salary) > 60000;

-- Find departments whose total salary exceeds 2,50,000.
select department from employee3
group by department 
having sum(salary) > 250000;

-- Find cities where average salary exceeds 55,000.
select city from employee3
group by city 
having avg(salary) > 55000;

-- Find departments where all employees earn more than 45,000.
-- Hint: Use MIN(salary).
select department from employee3
group by department 
having min(salary) > 45000;

-- Find departments where at least one employee earns more than 85,000.
-- Hint: Use MAX(salary).
select department from employee3
group by department 
having max(salary) > 85000;

-- Find department-wise salary range.
-- Expected Output:
-- | department | max_salary | min_salary | difference |
select department ,max(salary) as max_salary ,min(salary) as min_salary, max(salary)-min(salary) as difference from employee3
group  by department ;

-- Q29
-- Find departments having exactly 4 employees.
select department from employee3 
group by department 
having count(emp_id) = 4;

-- Q30
-- Find cities having at least 3 employees and average salary above 50,000.
select city from employee3
group by city 
having count(emp_id) >= 3 and avg(salary) > 50000;


                    -- Extra Interview Challenge (Optional)

 
-- Find the department with the highest total salary.
select department , sum(salary) from employee3
group by department
order by sum(salary) desc 
limit 1;


-- Find the department with the highest employee count.
select department , count(emp_id) from employee3
group by department
order by count(emp_id) desc 
limit 1;

 




-- Q33

-- Find the city contributing the maximum salary.
select city , sum(salary) from employee3
group by city
order by sum(salary) desc 
limit 1;



-- Q34

-- Find departments whose total salary is greater than the company's average salary.
select department from employee3
group by department
having sum(salary) > (select avg(salary) from employee3);


-- Q35 ( tough agg. on agg. type quetions  )
-- Find departments whose employee count is greater than the average department size 
SELECT department
FROM employee3
GROUP BY department
HAVING COUNT(*) >
(
    SELECT AVG(dept_size)
    FROM (
        SELECT COUNT(*) AS dept_size
        FROM employee3
        GROUP BY department
    ) t
);
































									 