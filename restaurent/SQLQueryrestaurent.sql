-- Creating the Menu Table
CREATE TABLE Menu (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(255),
    Category VARCHAR(100),
    Price DECIMAL(10, 2)
);

-- Creating the Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY,
    Name VARCHAR(255),
    Role VARCHAR(100),
    Salary DECIMAL(10, 2)
);

-- Creating the Customers Table
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(255),
    Visits INT,
    TotalSpent DECIMAL(10, 2)
);

-- Creating the Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(255),
    ContactNumber VARCHAR(20),
    ProductSupplied VARCHAR(100)
);

-- Creating the Inventory Table
CREATE TABLE Inventory (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(255),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);




-- Inserting into Menu
INSERT INTO Menu (ItemID, ItemName, Category, Price) VALUES
(1, 'Margherita Pizza', 'Pizza', 12.5),
(2, 'Cheeseburger', 'Burger', 10.0),
(3, 'Caesar Salad', 'Salad', 8.5),
(4, 'Grilled Salmon', 'Seafood', 15.0),
(5, 'Spaghetti Carbonara', 'Pasta', 13.0),
(6, 'Chicken Tacos', 'Mexican', 9.0),
(7, 'Beef Steak', 'Steak', 18.0),
(8, 'Vegetable Soup', 'Soup', 6.5),
(9, 'Pancakes', 'Dessert', 7.0),
(10, 'Chocolate Cake', 'Dessert', 5.5);

-- Inserting into Staff
INSERT INTO Staff (StaffID, Name, Role, Salary) VALUES
(101, 'John Smith', 'Chef', 4000),
(102, 'Jane Doe', 'Waiter', 2200),
(103, 'Mary Johnson', 'Manager', 3500),
(104, 'James Brown', 'Cleaner', 1800),
(105, 'Emily Davis', 'Chef', 4200),
(106, 'Michael Wilson', 'Waiter', 2100),
(107, 'Jessica Taylor', 'Bartender', 2500),
(108, 'David Martinez', 'Waiter', 2300),
(109, 'Sarah White', 'Cleaner', 1850),
(110, 'Daniel Harris', 'Manager', 3600);

-- Inserting into Customers
INSERT INTO Customers (CustomerID, Name, Visits, TotalSpent) VALUES
(201, 'Chris Evans', 4, 120),
(202, 'Megan Lee', 6, 200),
(203, 'Amanda Clark', 2, 80),
(204, 'Peter Parker', 5, 150),
(205, 'Bruce Wayne', 3, 100),
(206, 'Natasha Romanoff', 7, 250),
(207, 'Tony Stark', 8, 400),
(208, 'Steve Rogers', 2, 70),
(209, 'Clark Kent', 4, 130),
(210, 'Diana Prince', 6, 180);

-- Inserting into Suppliers
INSERT INTO Suppliers (SupplierID, SupplierName, ContactNumber, ProductSupplied) VALUES
(301, 'Fresh Foods Co.', '123-456', 'Vegetables'),
(302, 'Prime Meats Ltd.', '234-567', 'Meat'),
(303, 'Ocean Catch', '345-678', 'Seafood'),
(304, 'Green Veggies Inc.', '456-789', 'Vegetables'),
(305, 'Dairy Best', '567-890', 'Dairy'),
(306, 'Spice Market', '678-901', 'Spices'),
(307, 'Baker''s Delight', '789-012', 'Bakery'),
(308, 'Cocoa Supply', '890-123', 'Chocolate'),
(309, 'Soft Beverages', '901-234', 'Beverages'),
(310, 'Herbs & More', '012-345', 'Herbs');

-- Inserting into Inventory
INSERT INTO Inventory (ProductID, ProductName, Quantity, UnitPrice) VALUES
(401, 'Tomatoes', 50, 1.5),
(402, 'Beef', 30, 5.0),
(403, 'Salmon', 20, 7.0),
(404, 'Lettuce', 40, 2.0),
(405, 'Cheese', 25, 4.5),
(406, 'Flour', 35, 1.0),
(407, 'Cocoa Powder', 15, 3.5),
(408, 'Eggs', 60, 0.2),
(409, 'Milk', 45, 1.8),
(410, 'Olive Oil', 20, 6.0);








-- Select all data from Menu
SELECT * FROM Menu;

-- Select specific columns from Staff
SELECT Name, Role, Salary FROM Staff;

-- Filter Customers who spent more than $150
SELECT * FROM Customers WHERE TotalSpent > 150;

-- Show Inventory products with Quantity less than 30
SELECT * FROM Inventory WHERE Quantity < 30;

-- Join Menu and Inventory on common Item/Product names
SELECT m.ItemName, m.Price, i.Quantity
FROM Menu m
JOIN Inventory i ON m.ItemName LIKE CONCAT('%', i.ProductName, '%');





-- Update the price of "Margherita Pizza" in Menu
UPDATE Menu
SET Price = 13.5
WHERE ItemName = 'Margherita Pizza';

-- Increase Salary for Waiters in Staff
UPDATE Staff
SET Salary = Salary + 200
WHERE Role = 'Waiter';

-- Reduce Quantity of 'Tomatoes' in Inventory by 10
UPDATE Inventory
SET Quantity = Quantity - 10
WHERE ProductName = 'Tomatoes';



-- Delete a Customer who spent less than $100
DELETE FROM Customers
WHERE TotalSpent < 100;

-- Remove a product from Inventory
DELETE FROM Inventory
WHERE ProductID = '401';
SELECT * FROM Inventory

-- Delete a staff member by ID
DELETE FROM Staff
WHERE StaffID = 109;



-- Add a new column 'Discount' in Menu table
ALTER TABLE Menu
ADD Discount DECIMAL(5,2);

-- Add a column 'HireDate' in Staff table
ALTER TABLE Staff
ADD HireDate DATE;




-- Drop the Suppliers table
DROP TABLE Suppliers;




