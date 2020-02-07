# Set default database
USE Northwind;

# Select
SELECT * FROM Customers;
SELECT CustomerName, City FROM Customers;

# Select distinct
SELECT Country FROM Customers;
SELECT DISTINCT	Country FROM Customers;
SELECT COUNT(DISTINCT Country) FROM Customers;

# Where
SELECT * FROM Customers WHERE Country = 'Mexico';
SELECT * FROM Customers WHERE CustomerID = 1;

# Operators
SELECT * FROM Products WHERE Price = 18;
SELECT * FROM Products WHERE Price > 30;
SELECT * FROM Products WHERE Price < 30;
SELECT * FROM Products WHERE Price >= 30;
SELECT * FROM Products WHERE Price <= 30;
SELECT * FROM Products WHERE Price <> 18;
SELECT * FROM Products WHERE Price != 18;
SELECT * FROM Products WHERE Price BETWEEN 50 AND 60;
SELECT * FROM Customers WHERE City LIKE 's%';
SELECT * FROM Customers WHERE City IN ('London', 'Paris');

# And
SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin';

# Or
SELECT * FROM Customers WHERE City = 'Berlin' OR City = 'Munchen';
SELECT * FROM Customers WHERE Country = 'Germany' OR Country = 'Spain';
SELECT * FROM Customers WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'Munchen');

# Not
SELECT * FROM Customers WHERE NOT Country = 'Germany';
SELECT * FROM Customers WHERE NOT Country = 'Germany' AND NOT Country = 'USA';

# Order by
SELECT * FROM Customers ORDER BY Country;
SELECT * FROM Customers ORDER BY Country DESC;
SELECT * FROM Customers ORDER BY Country, CustomerName;
SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;

# Insert into
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');
INSERT INTO Customers (CustomerName, City, Country)
VALUES ('Cardinal', 'Stavanger', 'Norway');

# Null values
SELECT CustomerName, ContactName, Address FROM Customers WHERE Address IS NULL;
SELECT CustomerName, ContactName, Address FROM Customers WHERE Address IS NOT NULL;

# Update
UPDATE Customers SET ContactName = 'Alfred Schmidt', City = 'Frankfurt' WHERE CustomerID = 1;
UPDATE Customers SET ContactName = 'Juan' WHERE Country = 'Mexico';
UPDATE Customers SET ContactName = 'Juan';

# Delete
DELETE FROM Customers WHERE CustomerName = 'Alfreds Futterkiste';
DELETE FROM Customers;
DROP TABLE Customers;
CREATE TABLE Customers AS SELECT * FROM NorthwindBackup.Customers;

# Limit
SELECT * FROM Customers LIMIT 3;
SELECT * FROM Customers WHERE Country = 'Germany' LIMIT 3;

# Min and Max
SELECT MIN(Price) AS SmallestPrice FROM Products;
SELECT MAX(Price) AS LargestPrice FROM Products;

# Count, Avg, and Sum
SELECT COUNT(ProductID) FROM Products;
SELECT AVG(Price) FROM Products;
SELECT SUM(Quantity) FROM OrderDetails;

# Like
SELECT * FROM Customers WHERE CustomerName LIKE 'a%';
SELECT * FROM Customers WHERE CustomerName LIKE '%a';
SELECT * FROM Customers WHERE CustomerName LIKE '%or%';
SELECT * FROM Customers WHERE CustomerName LIKE '_r%';
SELECT * FROM Customers WHERE CustomerName LIKE 'a__%';
SELECT * FROM Customers WHERE ContactName LIKE 'a%o';
SELECT * FROM Customers WHERE CustomerName NOT LIKE 'a%';

# Wildcards
SELECT * FROM Customers WHERE City LIKE 'ber%';
SELECT * FROM Customers WHERE City LIKE '%es%';
SELECT * FROM Customers WHERE City LIKE '_ondon';
SELECT * FROM Customers WHERE City LIKE 'L_n_on';
SELECT * FROM Customers WHERE City RLIKE '^[bsp]';
SELECT * FROM Customers WHERE City RLIKE '^[a-c]';
SELECT * FROM Customers WHERE City NOT RLIKE '^[bsp]';

# In
SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');
SELECT * FROM Customers WHERE Country NOT IN ('Germany', 'France', 'UK');
SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);

# Between
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;
SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;
SELECT * FROM Products WHERE Price BETWEEN 10 AND 20 AND NOT CategoryID IN (1, 2, 3);
SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;
SELECT * FROM Products
WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Chef Anton\'s Cajun Seasoning'
ORDER BY ProductName;
SELECT * FROM Products
WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
ORDER BY ProductName;
SELECT * FROM Orders
WHERE STR_TO_DATE(OrderDate, '%c/%e/%Y') BETWEEN '1996-07-01' AND '1996-07-31';

# Aliases
SELECT CustomerID AS ID, CustomerName AS Customer FROM Customers;
SELECT CustomerName AS Customer, ContactName AS 'Contact Person' FROM Customers;
SELECT CustomerName, CONCAT(Address, ', ', PostalCode, ', ', City, ', ', Country) AS Address FROM Customers;
SELECT o.OrderID, o.OrderDate, c.CustomerName FROM Customers AS c, Orders AS o
WHERE c.CustomerName = 'Around the Horn' AND c.CustomerID = o.CustomerID;
SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName FROM Customers, Orders
WHERE Customers.CustomerName = 'Around the Horn' AND Customers.CustomerID = Orders.CustomerID;

# Inner join
SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;
SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
FROM ((Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);

# Left join
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID ORDER BY Customers.CustomerName;

# Right join
SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
FROM Orders RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID ORDER BY Orders.OrderID;

# Full join
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
UNION
SELECT Customers.CustomerName, Orders.OrderID
FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
ORDER BY CustomerName;

# Self join
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers AS A, Customers AS B
WHERE A.CustomerID != B.CustomerID AND A.City = B.City ORDER BY A.City;

# Union
SELECT City FROM Customers
UNION
SELECT City FROM Suppliers
ORDER BY City;
SELECT City FROM Customers
UNION ALL
SELECT City FROM Suppliers
ORDER BY City;
SELECT City, Country FROM Customers WHERE Country = 'Germany'
UNION
SELECT City, Country FROM Suppliers WHERE Country = 'Germany'
ORDER BY City;
SELECT City, Country FROM Customers WHERE Country = 'Germany'
UNION ALL
SELECT City, Country FROM Suppliers WHERE Country = 'Germany'
ORDER BY City;
SELECT 'Customer' As 'Customer/Supplier', ContactName, City, Country FROM Customers
UNION
SELECT 'Supplier', ContactName, City, Country FROM Suppliers;

# Group by
SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country;
SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country ORDER BY COUNT(CustomerID) DESC;
SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID GROUP BY ShipperName;

# Having
SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country HAVING COUNT(CustomerID) > 5;
SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country HAVING COUNT(CustomerID) > 5 ORDER BY COUNT(CustomerID) DESC;
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID GROUP BY LastName HAVING COUNT(Orders.OrderID) > 10;
SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
WHERE LastName = 'Davolio' OR LastName = 'Fuller' GROUP BY LastName HAVING COUNT(Orders.OrderID) > 25;

# Exists
SELECT SupplierName FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.SupplierID AND Price < 20);
SELECT SupplierName FROM Suppliers
WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.SupplierID AND Price = 22);

# Any
SELECT ProductName FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);
SELECT ProductName FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity > 99);

# All
SELECT ProductName FROM Products
WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);

# Insert into select
INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers;
INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
SELECT SupplierName, ContactName, Address, City, PostalCode, Country FROM Suppliers;
INSERT INTO Customers (CustomerName, City, Country)
SELECT SupplierName, City, Country FROM Suppliers WHERE Country = 'Germany';
DELETE FROM Customers WHERE CustomerID IS NULL;

# Case
SELECT OrderID, Quantity,
CASE
    WHEN Quantity > 30 THEN 'The quantity is greater than 30'
    WHEN Quantity = 30 THEN 'The quantity is 30'
    ELSE 'The quantity is under 30'
END AS QuantityText
FROM OrderDetails;
SELECT CustomerName, City, Country FROM Customers
ORDER BY
(CASE
    WHEN City IS NULL THEN Country
    ELSE City
END);

# Null functions
SELECT ProductName, 10 * (5 + IFNULL(Price, 0)) FROM Products;
SELECT ProductName, 10 * (5 + COALESCE(Price, 0)) FROM Products;

# Stored procedures
DELIMITER //
CREATE PROCEDURE SelectAllCustomers()
BEGIN
	SELECT * FROM Customers;
END//
DELIMITER ;
CALL SelectAllCustomers;
DROP PROCEDURE SelectAllCustomers;
DELIMITER //
CREATE PROCEDURE SelectAllCustomers(InputCity CHAR(30))
BEGIN
	SELECT * FROM Customers WHERE City = InputCity;
END//
DELIMITER ;
CALL SelectAllCustomers('London');
DROP PROCEDURE SelectAllCustomers;
DELIMITER //
CREATE PROCEDURE SelectAllCustomers(InputCity CHAR(30), InputPostalCode CHAR(10))
BEGIN
	SELECT * FROM Customers WHERE City = InputCity AND PostalCode = InputPostalCode;
END//
DELIMITER ;
CALL SelectAllCustomers('London', 'WA1 1DP');
DROP PROCEDURE SelectAllCustomers;

# Create database
CREATE DATABASE TestDB;
SHOW DATABASES;

# Drop database
DROP DATABASE TestDB;

# Create table
CREATE TABLE Persons (
    PersonID INT,
    LastName VARCHAR(255),
    FirstName VARCHAR(255),
    Address VARCHAR(255),
    City VARCHAR(255) 
);
CREATE TABLE TestTable AS
SELECT CustomerName, ContactName FROM Customers;

# Drop table
TRUNCATE TABLE TestTable;
DROP TABLE TestTable;

# Alter table
ALTER TABLE Customers
ADD Email VARCHAR(255);
ALTER TABLE Customers
DROP COLUMN Email;
ALTER TABLE Persons
ADD DateOfBirth DATE;
ALTER TABLE Persons
MODIFY COLUMN DateOfBirth YEAR;
ALTER TABLE Persons
DROP COLUMN DateOfBirth;
DROP TABLE Persons;

# Not null
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255) NOT NULL,
    Age INT
);
ALTER TABLE Persons
MODIFY Age INT NOT NULL;
DROP TABLE Persons;

# Unique
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    UNIQUE (ID)
);
DROP TABLE Persons;
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    CONSTRAINT UC_Person UNIQUE (ID, LastName)
);
ALTER TABLE Persons
ADD UNIQUE (ID);
ALTER TABLE Persons
DROP INDEX UC_Person;
ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID, LastName);
DROP TABLE Persons;

# Primary key
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    PRIMARY KEY (ID)
);
DROP TABLE Persons;
CREATE TABLE Persons (
    ID int NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    CONSTRAINT PK_Person PRIMARY KEY (ID, LastName)
);
ALTER TABLE Persons
DROP PRIMARY KEY;
ALTER TABLE Persons
ADD PRIMARY KEY (ID);
ALTER TABLE Persons
DROP PRIMARY KEY;
ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID, LastName);

# Foreign key
CREATE TABLE NewOrders (
    OrderID INT NOT NULL,
    OrderNumber INT NOT NULL,
    PersonID INT,
    PRIMARY KEY (OrderID),
    FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);
DROP TABLE NewOrders;
CREATE TABLE NewOrders (
    OrderID INT NOT NULL,
    OrderNumber INT NOT NULL,
    PersonID INT,
    PRIMARY KEY (OrderID),
    CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);
ALTER TABLE NewOrders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(ID);
ALTER TABLE NewOrders
DROP FOREIGN KEY FK_PersonOrder;
ALTER TABLE NewOrders
ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID);
DROP TABLE NewOrders;
DROP TABLE Persons;

# Check
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    CHECK (Age >= 18)
);
DROP TABLE Persons;
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    City VARCHAR(255),
    CONSTRAINT CHK_Person CHECK (Age >= 18 AND City = 'Sandnes')
);
ALTER TABLE Persons
ADD CHECK (Age >= 18);
ALTER TABLE Persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age >= 18 AND City = 'Sandnes');
ALTER TABLE Persons
DROP CHECK CHK_PersonAge;
SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;
DROP TABLE Persons;

# Default
CREATE TABLE Persons (
    ID INT NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    City VARCHAR(255) DEFAULT 'Sandnes'
);
CREATE TABLE NewOrders (
    ID INT NOT NULL,
    OrderNumber INT NOT NULL,
    OrderDate DATETIME DEFAULT NOW()
);
DROP TABLE NewOrders;
ALTER TABLE Persons
ALTER City SET DEFAULT 'Sandnes';
ALTER TABLE Persons
ALTER City DROP DEFAULT;

# Index
CREATE INDEX idx_lastname ON Persons (LastName);
CREATE INDEX idx_pname ON Persons (LastName, FirstName);
ALTER TABLE Persons
DROP INDEX idx_pname;
CREATE UNIQUE INDEX idx_pname ON Persons (LastName, FirstName);
DROP TABLE Persons;

# Auto increment
CREATE TABLE Persons (
    PersonID INT NOT NULL AUTO_INCREMENT,
    LastName VARCHAR(255) NOT NULL,
    FirstName VARCHAR(255),
    Age INT,
    PRIMARY KEY (PersonID)
);
ALTER TABLE Persons AUTO_INCREMENT = 100;
INSERT INTO Persons (FirstName, LastName)
VALUES ('Lars', 'Monsen');
DROP TABLE Persons;

# Views
CREATE VIEW BrazilCustomers AS
SELECT CustomerName, ContactName FROM Customers WHERE Country = 'Brazil';
SELECT * FROM BrazilCustomers;
CREATE VIEW ProductsAboveAveragePrice AS
SELECT ProductName, Price FROM Products WHERE Price > (SELECT AVG(Price) FROM Products);
SELECT * FROM ProductsAboveAveragePrice;
CREATE OR REPLACE VIEW BrazilCustomers AS
SELECT CustomerName, ContactName, City FROM Customers WHERE Country = 'Brazil';
DROP VIEW BrazilCustomers;
DROP VIEW ProductsAboveAveragePrice;
