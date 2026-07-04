CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


INSERT INTO Customers VALUES
(1,'Aman','Delhi'),
(2,'Rahul','Mumbai'),
(3,'Sneha','Delhi'),
(4,'Priya','Pune'),
(5,'Rohit','Jaipur'),
(6,'Anjali','Mumbai'),
(7,'Vikas','Delhi'),
(8,'Karan','Pune');

INSERT INTO Products VALUES
(101,'Laptop','Electronics',70000),
(102,'Phone','Electronics',40000),
(103,'Headphones','Electronics',3000),
(104,'Chair','Furniture',6000),
(105,'Table','Furniture',12000),
(106,'Monitor','Electronics',15000),
(107,'Printer','Electronics',10000),
(108,'Keyboard','Electronics',2000);

INSERT INTO Orders VALUES
(1001,1,'2025-01-05'),
(1002,2,'2025-01-08'),
(1003,3,'2025-01-10'),
(1004,1,'2025-02-01'),
(1005,4,'2025-02-03'),
(1006,5,'2025-02-10'),
(1007,6,'2025-02-12'),
(1008,7,'2025-02-15'),
(1009,8,'2025-03-01'),
(1010,2,'2025-03-05');

INSERT INTO OrderDetails VALUES
(1001,101,1),
(1001,103,2),

(1002,102,1),

(1003,104,2),
(1003,105,1),

(1004,102,1),
(1004,106,2),

(1005,107,1),
(1005,108,4),

(1006,103,5),

(1007,101,1),

(1008,105,1),

(1009,106,1),

(1010,101,2),
(1010,108,3);

select * from Customers;
select * from Products;
select * from Orders;
select * from OrderDetails;
-- Find customers who have placed at least one order.
select customername from Customers
where customerid in (select customerid from orders);

-- Find customers who have never placed an order.
select customername from Customers
where customerid not in (select customerid from orders);

-- Find customers who purchased products from the Electronics category.
select customername from Customers 


-- Find all products that have been sold at least once.
select productname from products 
where productid in (select productid from orderdetails );

-- Find products that have never been sold.
select productname from products 
where productid not in (select productid from orderdetails );

-- Find customers who purchased products from the Electronics category.
select distinct customername from customers c
join orders o
on c.customerid = o.customerid 
join orderdetails od
on od.orderid = o.orderid
join products p
on od.productid = p.productid
WHERE p.category = 'Electronics';

-- Find customers who purchased both Electronics and Furniture products.
SELECT CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT o.CustomerID
    FROM Orders o
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    WHERE p.Category = 'Electronics'
)
AND CustomerID IN
(
    SELECT o.CustomerID
    FROM Orders o
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    WHERE p.Category = 'Furniture'
);

-- Find customers who purchased only Electronics products.
SELECT CustomerName
FROM Customers
WHERE CustomerID IN
(
    SELECT o.CustomerID
    FROM Orders o
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    WHERE p.Category = 'Electronics'
)

AND CustomerID NOT IN
(
    SELECT o.CustomerID
    FROM Orders o
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    WHERE p.Category = 'Furniture'
);

-- Find orders containing products priced above the average product price.
SELECT
	PRODUCTNAME
FROM
	PRODUCTS
WHERE
	PRICE >  (
		SELECT
			AVG(PRICE)
		FROM
			PRODUCTS
	);
-- Find customers who bought products costing more than ₹20,000.
select distinct customername from  customers 
where customerid in (select c.customerid from customers c 
join orders o 
on c.customerid = o.customerid
join OrderDetails od 
on od.orderid = o.orderid
join products p 
on p.productid = od.productid
where p.price > 20000);

-- Find cities where customers have placed at least one order.
select distinct city from  customers 
where customerid in (select customerid from orders
);




-- Find products more expensive than ANY Furniture product.
select productname from products 
where price > any (select price from products where category = 'Furniture' );

-- Find products more expensive than ALL Furniture products.
select productname from products 
where price > all (select price from products where category = 'Furniture' );

-- Find products cheaper than ANY Electronics product.
select productname from products
where price <  any(select price from products 
where category = 'Electronics'
);

-- Find products cheaper than ALL Electronics products.
select productname from products
where price <  all(select price from products 
where category = 'Electronics'
);

-- Find customers whose total spending is greater than ANY customer from Delhi.
SELECT
    c.CustomerName,
    c.CustomerID,
    SUM(p.Price * od.Quantity) AS TotalSpending
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
JOIN Products p
    ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING SUM(p.Price * od.Quantity) > ANY
(
    SELECT SUM(p.Price * od.Quantity)
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    WHERE c.City = 'Delhi'
    GROUP BY c.CustomerID
);
-- Find customers whose total spending is greater than ALL customers from Mumbai
select c.customername , c.customerid from customers  c 
JOIN Orders o
    ON c.CustomerID = o.CustomerID
JOIN OrderDetails od
    ON o.OrderID = od.OrderID
JOIN Products p
    ON od.ProductID = p.ProductID
group by c.customername  , c.customerid 
having sum(p.price * od.quantity) > all ( SELECT SUM(p.Price * od.Quantity)
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
where c.city = 'Mumbai'  
group by c.customerid
);

-- Find products priced higher than ANY product purchased by Customer 1.
select distinct  p.productname from products p
join OrderDetails od
on p.productid = od.productid
join orders o 
on o.orderid = od.orderid
join customers c
on c.customerid = o.customerid
where price > any ( select p.price from products p 
join OrderDetails od
on p.productid = od.productid
join orders o 
on o.orderid = od.orderid
join customers c
on c.customerid = o.customerid
where c.customerid = 1 );

-- Find products priced higher than ALL products purchased by Customer 1.
select distinct  p.productname from products p
join OrderDetails od
on p.productid = od.productid
join orders o 
on o.orderid = od.orderid
join customers c
on c.customerid = o.customerid
where price > all ( select p.price from products p 
join OrderDetails od
on p.productid = od.productid
join orders o 
on o.orderid = od.orderid
join customers c
on c.customerid = o.customerid
where c.customerid = 1 );


                                 	-- CTE
-- Create a CTE to calculate total sales for each customer.
WITH TotalSales AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName
)

SELECT *
FROM TotalSales
order by customerid asc;

-- Using a CTE, find the highest spending customer.
WITH TotalSales AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName
)

SELECT *
FROM TotalSales
order by totalsales desc 
limit 1 ;

-- Using a CTE, find customers whose sales are above the average sales.
WITH TotalSales AS
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY c.CustomerID, c.CustomerName)

select * from TotalSales
where totalsales > ( select avg(totalsales) from totalsales)
;
-- Using a CTE, calculate total revenue by city.
WITH TotalSales AS
(
    SELECT
       
		c.city,
        SUM(p.Price * od.Quantity) AS TotalSales
    FROM Customers c
    JOIN Orders o
        ON c.CustomerID = o.CustomerID
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY c.city)
	
select city , totalsales from TotalSales
;

-- Using multiple CTEs, calculate:
-- Order Value
-- Customer Sales

WITH OrderValue AS
(
    SELECT
        o.OrderID,
        o.CustomerID,
        SUM(p.Price * od.Quantity) AS OrderValue
    FROM Orders o
    JOIN OrderDetails od
        ON o.OrderID = od.OrderID
    JOIN Products p
        ON od.ProductID = p.ProductID
    GROUP BY o.OrderID, o.CustomerID
),

customersales as ( select ov.customerid ,  c.customername ,sum(ov.ordervalue) as customersales from ordervalue ov 
join customers c
on ov.customerid = c.customerid 
group by ov.customerid,c.customername
)

SELECT *
FROM CustomerSales;

-- Using CTE, find customers with more than two orders.
with custvsord as ( select c.customerid, c.customername ,count(distinct o.orderid) as nooforderid from customers c
join Orders o
on c.customerid  = o.customerid
join OrderDetails od
on od.orderid = o.orderid 
join Products p
on p.productid = od.productid
group by c.customerid,c.customername)

select * from custvsord
where nooforderid > 2
order by customerid asc ;

	-- Find top 5 products by revenue using a CTE.
	with productbyrev as ( select p.productname , sum(p.price*od.quantity) as totalrevenue
	from products p
	join OrderDetails od
	on p.productid =od.productid 
	group by p.productname)
	
	select * from  productbyrev
	order by totalrevenue desc 
	limit 5;

-- Find monthly sales using a CTE.
with months as ( 
select extract( month from o.orderdate) as months,
extract( years from o.orderdate) as years,
 sum(p.price *od.quantity) as monthwisesales
from OrderDetails od
join orders o 
on o.orderid = od.orderid 
join products p
on p.productid = od.productid
group by extract( month from o.orderdate),
extract( years from o.orderdate))
 
 select * from months;



                                  -- Window functions 
								  --  ROW_NUMBER()
								  
-- Assign row numbers to customers based on total sales.
select c.customerid , c.customername , sum(p.price*od.quantity) as totalsales
, row_number() over(order by sum(p.price*od.quantity) desc ) as rowno from customers c 
join Orders o 
on c.customerid = o.customerid 
join OrderDetails od
on o.orderid = od.orderid
join Products p
on od.productid = p.productid
group  by c.customerid, c.customername;




 

select * from Customers;
select * from Products;
select * from Orders;
select * from OrderDetails;




