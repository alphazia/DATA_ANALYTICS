-- Create a database for the project
CREATE DATABASE DataAnalysisProject;
GO

USE DataAnalysisProject;
GO

-- Create a table for Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Email NVARCHAR(100),
    Phone NVARCHAR(20),
    City NVARCHAR(50),
    Country NVARCHAR(50)
);
GO

-- Create a table for Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName NVARCHAR(100),
    Category NVARCHAR(50),
    Price DECIMAL(10, 2),
    Stock INT
);
GO

-- Create a table for Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATE,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    TotalAmount DECIMAL(10, 2)
);
GO

-- Create a table for OrderDetails
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT,
    Price DECIMAL(10, 2)
);
GO

-- Insert sample data into Customers
INSERT INTO Customers (FirstName, LastName, Email, Phone, City, Country) VALUES
('John', 'Doe', 'john.doe@example.com', '123-456-7890', 'New York', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901', 'Los Angeles', 'USA'),
('Ali', 'Khan', 'ali.khan@example.com', '345-678-9012', 'London', 'UK');
GO

-- Insert sample data into Products
INSERT INTO Products (ProductName, Category, Price, Stock) VALUES
('Laptop', 'Electronics', 1200.00, 50),
('Smartphone', 'Electronics', 800.00, 100),
('Headphones', 'Accessories', 100.00, 200);
GO

-- Insert sample data into Orders
INSERT INTO Orders (OrderDate, CustomerID, TotalAmount) VALUES
('2024-12-01', 1, 2000.00),
('2024-12-05', 2, 1600.00);
GO

-- Insert sample data into OrderDetails
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1200.00),
(1, 3, 8, 100.00),
(2, 2, 2, 800.00);
GO

-- Example queries for data analysis

-- 1. Retrieve all customers
SELECT * FROM Customers;

-- 2. Retrieve total sales by product
SELECT P.ProductName, SUM(OD.Quantity) AS TotalQuantity, SUM(OD.Price * OD.Quantity) AS TotalSales
FROM OrderDetails OD
JOIN Products P ON OD.ProductID = P.ProductID
GROUP BY P.ProductName;

-- 3. Retrieve total sales by customer
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, SUM(O.TotalAmount) AS TotalSpent
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY C.FirstName, C.LastName;

-- 4. Retrieve stock levels for all products
SELECT ProductName, Stock
FROM Products;

-- 5. Retrieve order details with customer and product information
SELECT O.OrderID, C.FirstName + ' ' + C.LastName AS CustomerName, P.ProductName, OD.Quantity, OD.Price
FROM OrderDetails OD
JOIN Orders O ON OD.OrderID = O.OrderID
JOIN Customers C ON O.CustomerID = C.CustomerID
JOIN Products P ON OD.ProductID = P.ProductID;

-- 6. Retrieve orders made within the last 30 days
SELECT *
FROM Orders
WHERE OrderDate >= DATEADD(DAY, -30, GETDATE());
