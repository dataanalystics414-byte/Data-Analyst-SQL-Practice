CREATE TABLE employee1 (
    emp_id INT,
    emp_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50),
    salary INT,
    join_date DATE
);


INSERT INTO employee1 VALUES
(1,'aman sharma','aman@gmail.com','sales',50000,'2022-01-15'),
(2,'Riya Singh','riya@gmail.com','hr',45000,'2023-03-10'),
(3,'  Rohit Verma  ','rohit@gmail.com','it',60000,'2021-07-20'),
(4,'Neha Gupta','neha@gmail.com','finance',55000,'2024-02-01'),
(5,'Karan Patel','karan@gmail.com','sales',52000,'2020-11-25');
select * from employee1;

-- 1. Convert all employee names to uppercase.
select upper(emp_name ) from employee1;
-- 2. Convert all department names to lowercase.
select lower(department ) from employee1;
-- 3. Display employee name and department together.
select CONCAT(upper(emp_name) ,' - ' ,upper(department)) from employee1;
-- 4. Show first 3 characters of each employee's name.

-- Example
-- Ama
-- Riy
-- Roh
select substring(emp_name , 1, 3) as prefix from employee1;

-- 5. Extract the domain from email addresses.
-- Example
-- gmail.com
select substring(email,6,12) as domain from employee1;
-- 6. Remove extra spaces from employee names.
-- Notice:
-- '  Rohit Verma  '
select trim(emp_name) as trimed_name from employee1;
-- 7. Create company email IDs.

-- Example

-- aman sharma@company.com
-- riya singh@company.com

select concat(emp_name, ' ', email )   from employee1;

-- 8. Display first letter of each employee name.
-- Expected
-- A
-- R
-- R
-- N
-- K
select substring(upper(trim(emp_name)) , 1,1) as first_letter from employee1;
-- 9. Find employees whose name starts with 'R'.

-- (Hint: SUBSTRING())
select emp_name from employee1
where substring(upper(emp_name) , 1,1)= 'R'  ;
-- 10. Display employee names in lowercase and departments in uppercase.
select trim(lower(emp_name))  , trim(upper(department)) from employee1;






