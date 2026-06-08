CREATE TABLE employeess (
    emp_id INT,
    emp_name VARCHAR(50),
    join_date DATE,
    salary INT
);
INSERT INTO employeess VALUES
(1, 'Aman',  '2022-01-15', 40000),
(2, 'Rohit', '2023-03-10', 45000),
(3, 'Priya', '2021-11-20', 50000),
(4, 'Karan', '2024-02-05', 35000),
(5, 'Neha',  '2020-07-12', 60000);


-- 8. Add 30 days to each employee's joining date.
select join_date , join_date + interval '30 days' from employeess;
-- 10. Find employees who joined within the last 3 years.
select emp_name from employeess 
where   extract(year from age(now(),join_date)  ) < 3 ;
-- 11. Find the oldest joining employee.
select emp_name , join_date from employeess
order by join_date 
limit 1;
-- 12. Find the most recently joined employee.
select emp_name , join_date from employeess
order by join_date desc
limit 1;
-- 13. Count employees joined in each year.
select  extract(year from join_date )  as years , count(emp_id) as emp_count from employeess
group by years;
-- 14. Count employees joined in each month.
select  extract(month from join_date )  as month , count(emp_id) as emp_count from employeess
group by extract(month from join_date )
order by month;
-- 15. Find employees whose work anniversary month is the current month.
select emp_name from employeess
where extract(month from join_date) = extract(month from current_date );
