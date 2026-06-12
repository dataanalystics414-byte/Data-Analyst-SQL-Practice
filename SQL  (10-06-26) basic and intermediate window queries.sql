CREATE TABLE employee_sales (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    sale_date DATE,
    sales_amount INT
);
drop table employee_sales;
INSERT INTO employee_sales VALUES
(1, 'Aman', 'Electronics', '2025-01-01', 5000),
(1, 'Aman', 'Electronics', '2025-01-05', 7000),
(1, 'Aman', 'Electronics', '2025-01-10', 6000),

(2, 'Rohit', 'Electronics', '2025-01-02', 8000),
(2, 'Rohit', 'Electronics', '2025-01-08', 9000),

(3, 'Priya', 'Clothing', '2025-01-01', 4000),
(3, 'Priya', 'Clothing', '2025-01-06', 5500),

(4, 'Neha', 'Clothing', '2025-01-03', 7000),
(4, 'Neha', 'Clothing', '2025-01-09', 8000),

(5, 'Karan', 'Furniture', '2025-01-04', 6500),
(5, 'Karan', 'Furniture', '2025-01-11', 7500);
select * from employee_sales;

-- 1. Assign row numbers based on sales date. 
select sale_date , row_number()  over( order by sale_date desc) from employee_sales;

-- 2. Rank employees by sales amount (highest first).
select emp_name , rank() over(order by sales_amount desc) from employee_sales;

-- 3. Give dense ranks for sales within each department.
select emp_name , department , 
dense_rank() over (PARTITION  by department
order by sales_amount desc) from employee_sales;

-- 4. Find the highest sale made in each department.
select * from 
(select emp_name , department , rank() over(partition by department order by sales_amount desc) as rnk from employee_sales ) t
where rnk =1; 
-- 5. Show total sales of each employee on every row.
select sales_amount, emp_id , sum(sales_amount) over(partition by emp_id ) as total_sales from employee_sales;
-- 6. Calculate running total of sales for each employee.
select emp_id,sales_amount, sale_date ,
sum(sales_amount) over(partition by emp_id order by emp_id ) as running_total from employee_sales;
-- 7. Find previous sale amount of each employee.
select emp_id,sales_amount ,lag(sales_amount) over(partition by emp_id ) from employee_sales;
-- 8. Find next sale amount of each employee.
select emp_id,sales_amount ,lead(sales_amount) over(partition by emp_id ) from employee_sales;
-- 9. Calculate difference between current sale and previous sale.
select sale_date , sales_amount - lag(sales_amount) over(partition  by emp_id  order by emp_id)
from employee_sales;
-- 10. Show percentage contribution of each sale to employee's total sales.
SELECT
    emp_id,
    sales_amount,
    sales_amount * 100.0 /
    SUM(sales_amount) OVER (PARTITION BY emp_id) AS percent_contribution
FROM employee_sales;

-- 11. Find the top 2 sales records from each department.
SELECT
	*
FROM
	(
		SELECT
			*,
			ROW_NUMBER() OVER (
				PARTITION BY
					DEPARTMENT
				ORDER BY
					SALES_AMOUNT DESC
			) AS RNK
		FROM
			EMPLOYEE_SALES
	) T
WHERE
	RNK <= 2;

-- 12. Find employees whose sale is greater than department average.
select * from (select * , avg(sales_amount) over(partition by department ) as dept_avg from employee_sales
)t where sales_amount > dept_avg;
-- 13. Find cumulative sales percentage within each department.
SELECT
	EMP_NAME,
	DEPARTMENT,
	SALES_AMOUNT,
	100.0 * SUM(SALES_AMOUNT) OVER (
		PARTITION BY
			DEPARTMENT
		ORDER BY
			SALES_AMOUNT
	) / SUM(SALES_AMOUNT) OVER (
		PARTITION BY
			DEPARTMENT
	) AS CUMU_PERSENTAGE
FROM
	EMPLOYEE_SALES;

-- 14. Find the second highest sale in each department.
SELECT
	EMP_NAME,
	DEPARTMENT,
	DENSE_RANK(SALES_AMOUNT) OVER (
		PARTITION BY
			DEPARTMENT ORDER
	) AS RANKING
FROM
	EMPLOYEE_SALES
WHERE
	RANKING = 2;

