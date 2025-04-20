Mini --Project: "Simple Sales Data Analysis"-inner join includes

-- Drop tables if they already exist
DROP TABLE IF EXISTS OrderDetails;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

-- Create Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    Country VARCHAR(50)
);

-- Create Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create OrderDetails Table
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT,
    ProductName VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert Data into Customers
INSERT INTO Customers VALUES
(1, 'Alice Smith', 'USA'),
(2, 'Bob Johnson', 'UK'),
(3, 'Carlos Rivera', 'Mexico');

-- Insert Data into Orders
INSERT INTO Orders VALUES
(101, 1, '2024-01-15', 50.00),
(102, 2, '2024-01-20', 80.00),
(103, 1, '2024-02-05', 120.00),
(104, 3, '2024-02-20', 60.00);

-- Insert Data into OrderDetails
INSERT INTO OrderDetails VALUES
(1001, 101, 'Mouse', 2, 20.00),
(1002, 101, 'USB Cable', 1, 10.00),
(1003, 102, 'Keyboard', 2, 40.00),
(1004, 103, 'Monitor', 1, 120.00),
(1005, 104, 'Laptop Stand', 2, 30.00);

--run simple queries--

select * from Customers;
select * from Orders;
select * from OrderDetails;

---Get all orders with customer details--first two table join
Select 
Customers.CustomerName,
Customers.Country,
Orders.OrderID,
Orders.TotalAmount
from Orders
join Customers on Customers.CustomerID=Orders.CustomerID;

--Order-wise item details--and new colum  making by multiplying order quan*price -total price 
SELECT 
    od.OrderID,
    od.ProductName,
    od.Quantity,
    od.Price,
    (od.Quantity * od.Price) AS LineTotal
FROM OrderDetails od;

----Full view: Customer, Order, and Product info (3-table JOIN)s now 
SELECT 
    c.CustomerName,
    c.Country,
    o.OrderID,
    o.OrderDate,
    od.ProductName,
    od.Quantity,
    od.Price,
    (od.Quantity * od.Price) AS LineTotal
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
ORDER BY o.OrderDate;


