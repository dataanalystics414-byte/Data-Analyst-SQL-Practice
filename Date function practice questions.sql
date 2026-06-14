CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);

INSERT INTO employees VALUES
(1,'aman sharma','aman@gmail.com','sales',50000,'2022-01-15'),
(2,'Riya Singh','riya@gmail.com','hr',45000,'2023-03-10'),
(3,'  Rohit Verma  ','rohit@gmail.com','it',60000,'2021-07-20'),
(4,'Neha Gupta','neha@gmail.com','finance',55000,'2024-02-01'),
(5,'Karan Patel','karan@gmail.com','sales',52000,'2020-11-25');
select * from employee1;
-- 11. Show today's date and time.
-- Use NOW()
 select now(); 
-- 12. Display employee names and joining year.
-- Expected
-- Aman Sharma | 2022
-- Riya Singh  | 202
-- Use YEAR().
select emp_name , date_part('year', join_date) as join_year from employee1;

-- 13. Display employee names and joining month.
-- Use MONTH().	
select emp_name , date_part('month',join_date ) as  joining_month from employee1;

-- 14. Find employees who joined in 2023.
select emp_name , date_part('year', join_date) as join_year from employee1
where date_part('year', join_date) = 2023;
-- 15. Find employees who joined in January.
SELECT emp_name,
       DATE_PART('month', join_date) AS joining_month
FROM employee1
WHERE DATE_PART('month', join_date) = 1;
-- 16. Calculate how many days each employee has worked in the company.
SELECT emp_name,
       CURRENT_DATE - join_date AS days_worked
FROM employee1;
-- find emp with their probation date 
-- Probation = 90 days after joining.
select emp_name , join_date, join_date + interval ' 90 days ' as probation
from employee1;
-- 19. Find employees who joined within the last 2 years.
-- Use DATE_SUB().
select emp_name , age(now(),join_date ) as difference from employee1
 where age(now(),join_date ) < interval '2 years';
-- 20. Find employees whose work anniversary is coming within the next 30 days.
select emp_name , join










-- 21. Display employee name in uppercase and joining year.
select upper(emp_name) , join_date from employee1;
-- 22. Create an employee code.
-- Example
-- AMA2022
-- RIY2023
-- (First 3 letters + joining year)
select trim(concat(substring(upper(emp_name),1,3),date_part('year',join_date)))  as emp_code from employee1;
-- 3. Generate a username.

-- Example

-- aman_2022
-- riya_2023

-- Use LOWER(), SUBSTRING(), YEAR()
select emp_name , concat(lower(substring(trim(emp_name),1,4)),'_',date_part('year',join_date )) from employee1;
-- 24. Find employees who have been in the company for more than 1000 days.
select emp_name  , age(now(), join_date ) as experience  from  employee1
where age(now(), join_date ) > interval ' 1000 days' ;

-- 25. Display:
-- Aman Sharma joined in 2022
-- Riya Singh joined in 2023

-- Use CONCAT() and YEAR().
select trim(concat(upper(emp_name),' joined in  ', date_part('year' , join_date))) from employee1;



