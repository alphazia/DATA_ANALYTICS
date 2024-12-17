-- Step 1: Create the Database
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'EmployeeManagement')
    DROP DATABASE EmployeeManagement;

CREATE DATABASE EmployeeManagement;
GO

USE EmployeeManagement;
GO

-- Step 2: Drop Tables If They Exist
IF OBJECT_ID('EmployeeDepartments', 'U') IS NOT NULL DROP TABLE EmployeeDepartments;
IF OBJECT_ID('Vacations', 'U') IS NOT NULL DROP TABLE Vacations;
IF OBJECT_ID('Salaries', 'U') IS NOT NULL DROP TABLE Salaries;
IF OBJECT_ID('Departments', 'U') IS NOT NULL DROP TABLE Departments;
IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;

-- Step 3: Create Tables

-- Employees Table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')),
    HireDate DATE NOT NULL
);

-- Salaries Table
CREATE TABLE Salaries (
    SalaryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    BasicSalary DECIMAL(10, 2) NOT NULL,
    Allowances DECIMAL(10, 2) DEFAULT 0,
    Deductions DECIMAL(10, 2) DEFAULT 0,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- Vacations Table
CREATE TABLE Vacations (
    VacationID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Reason NVARCHAR(255),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- Departments Table
CREATE TABLE Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName NVARCHAR(100) NOT NULL
);

-- EmployeeDepartments Table
CREATE TABLE EmployeeDepartments (
    EmployeeDepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) ON DELETE CASCADE
);

-- Step 4: Insert Sample Data

-- Insert Employees
INSERT INTO Employees (FirstName, LastName, DateOfBirth, Gender, HireDate)
VALUES 
('Alice', 'Smith', '1990-05-14', 'Female', '2015-06-01'),
('Bob', 'Johnson', '1985-09-21', 'Male', '2012-03-15'),
('Charlie', 'Brown', '1992-11-10', 'Male', '2018-09-25'),
('David', 'Williams', '1988-01-17', 'Male', '2017-03-10'),
('Emily', 'Davis', '1995-07-23', 'Female', '2020-09-01'),
('Frank', 'Miller', '1980-10-11', 'Male', '2010-01-15'),
('Grace', 'Wilson', '1993-03-19', 'Female', '2019-05-20'),
('Henry', 'Moore', '1987-06-30', 'Male', '2016-08-12'),
('Ivy', 'Taylor', '1996-12-14', 'Female', '2021-02-01'),
('Jack', 'Anderson', '1983-04-28', 'Male', '2011-11-15');

-- Insert Salaries
INSERT INTO Salaries (EmployeeID, BasicSalary, Allowances, Deductions)
VALUES 
(1, 5000.00, 500.00, 100.00),
(2, 7000.00, 700.00, 200.00),
(3, 4500.00, 300.00, 50.00),
(4, 5500.00, 400.00, 150.00),
(5, 6000.00, 350.00, 100.00),
(6, 8000.00, 800.00, 300.00),
(7, 4800.00, 320.00, 120.00),
(8, 7500.00, 700.00, 250.00),
(9, 5100.00, 400.00, 100.00),
(10, 7200.00, 600.00, 200.00);

-- Insert Vacations
INSERT INTO Vacations (EmployeeID, StartDate, EndDate, Reason)
VALUES 
(1, '2024-01-10', '2024-01-20', 'Family Trip'),
(2, '2024-03-05', '2024-03-15', 'Medical Leave'),
(4, '2024-06-01', '2024-06-10', 'Vacation'),
(6, '2024-04-15', '2024-04-25', 'Travel Abroad'),
(8, '2024-07-10', '2024-07-20', 'Family Event');

-- Insert Departments
INSERT INTO Departments (DepartmentName)
VALUES ('Human Resources'), ('Engineering'), ('Marketing'), ('Finance'), ('IT');

-- Insert EmployeeDepartments
INSERT INTO EmployeeDepartments (EmployeeID, DepartmentID)
VALUES 
(1, 1), 
(2, 2), 
(3, 3), 
(4, 4), 
(5, 5),
(6, 2),
(7, 1),
(8, 4),
(9, 3),
(10, 5);

-- Step 5: Queries for Displaying Data

-- Query 1: Display All Employees with Basic Information
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS FullName, Gender, HireDate
FROM Employees;

-- Query 2: Display Employees with Their Salaries
SELECT 
    E.EmployeeID, 
    CONCAT(E.FirstName, ' ', E.LastName) AS FullName, 
    S.BasicSalary, 
    S.Allowances, 
    S.Deductions, 
    (S.BasicSalary + S.Allowances - S.Deductions) AS NetSalary
FROM Employees E
JOIN Salaries S ON E.EmployeeID = S.EmployeeID;

-- Query 3: Display Employees on Vacation
SELECT 
    E.EmployeeID, 
    CONCAT(E.FirstName, ' ', E.LastName) AS FullName, 
    V.StartDate, 
    V.EndDate, 
    V.Reason
FROM Employees E
JOIN Vacations V ON E.EmployeeID = V.EmployeeID;

-- Query 4: Display Employees and Their Departments
SELECT 
    E.EmployeeID, 
    CONCAT(E.FirstName, ' ', E.LastName) AS FullName, 
    D.DepartmentName
FROM Employees E
JOIN EmployeeDepartments ED ON E.EmployeeID = ED.EmployeeID
JOIN Departments D ON ED.DepartmentID = D.DepartmentID;

-- Query 5: Count Employees in Each Department
SELECT 
    D.DepartmentName, 
    COUNT(ED.EmployeeID) AS TotalEmployees
FROM Departments D
LEFT JOIN EmployeeDepartments ED ON D.DepartmentID = ED.DepartmentID
GROUP BY D.DepartmentName;
