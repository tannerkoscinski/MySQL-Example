# Import library
library(RMySQL)

# Connect to database
northwind = dbConnect(MySQL(), user = "root", password = "password",
                      host = "localhost", dbname = "Northwind")
dbDisconnect(northwind)

# List tables
dbListTables(northwind)

# List fields in Customers table
dbListFields(northwind, "Customers")

# Read Customers table into R
customers = dbReadTable(northwind, "Customers")

# Write CustomersBackup table into MySQL
#dbWriteTable(northwind, "CustomersBackup", customers)
remove(customers)
dbSendStatement(northwind, "CREATE TABLE CustomersBackup AS
                SELECT * FROM Customers;")

# Select
dbGetQuery(northwind, "SELECT * FROM Customers;")
dbGetQuery(northwind, "SELECT CustomerName, City FROM Customers;")

# Select distinct
dbGetQuery(northwind, "SELECT Country FROM Customers;")
dbGetQuery(northwind, "SELECT DISTINCT	Country FROM Customers;")
dbGetQuery(northwind, "SELECT COUNT(DISTINCT Country) FROM Customers;")

# Where
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country = 'Mexico';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerID = 1;")

# Operators
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price = 18;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price > 30;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price < 30;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price >= 30;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price <= 30;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price <> 18;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price != 18;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price BETWEEN 50 AND 60;")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City LIKE 's%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City IN ('London', 'Paris');")

# And
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin';")

# Or
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City = 'Berlin' OR City = 'Munchen';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country = 'Germany' OR Country = 'Spain';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country = 'Germany' AND (City = 'Berlin' OR City = 'Munchen');")

# Not
dbGetQuery(northwind, "SELECT * FROM Customers WHERE NOT Country = 'Germany';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE NOT Country = 'Germany' AND NOT Country = 'USA';")

# Order by
dbGetQuery(northwind, "SELECT * FROM Customers ORDER BY Country;")
dbGetQuery(northwind, "SELECT * FROM Customers ORDER BY Country DESC;")
dbGetQuery(northwind, "SELECT * FROM Customers ORDER BY Country, CustomerName;")
dbGetQuery(northwind, "SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;")

# Insert into
dbSendStatement(northwind, "INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
                VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', 'Norway');")
dbSendStatement(northwind, "INSERT INTO Customers (CustomerName, City, Country)
                VALUES ('Cardinal', 'Stavanger', 'Norway');")

# Null values
dbGetQuery(northwind, "SELECT CustomerName, ContactName, Address FROM Customers WHERE Address IS NULL;")
dbGetQuery(northwind, "SELECT CustomerName, ContactName, Address FROM Customers WHERE Address IS NOT NULL;")

# Update
dbSendStatement(northwind, "UPDATE Customers SET ContactName = 'Alfred Schmidt', City = 'Frankfurt' WHERE CustomerID = 1;")
dbSendStatement(northwind, "UPDATE Customers SET ContactName = 'Juan' WHERE Country = 'Mexico';")
dbSendStatement(northwind, "UPDATE Customers SET ContactName = 'Juan';")

# Delete
dbSendStatement(northwind, "DELETE FROM Customers WHERE CustomerName = 'Alfreds Futterkiste';")
dbSendStatement(northwind, "DELETE FROM Customers;")
dbSendStatement(northwind, "DROP TABLE Customers;")
dbSendStatement(northwind, "CREATE TABLE Customers AS
                SELECT * FROM CustomersBackup;")
dbSendStatement(northwind, "DROP TABLE CustomersBackup;")

# Limit
dbGetQuery(northwind, "SELECT * FROM Customers LIMIT 3;")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country = 'Germany' LIMIT 3;")

# Min and Max
dbGetQuery(northwind, "SELECT MIN(Price) AS SmallestPrice FROM Products;")
dbGetQuery(northwind, "SELECT MAX(Price) AS LargestPrice FROM Products;")

# Count, Avg, and Sum
dbGetQuery(northwind, "SELECT COUNT(ProductID) FROM Products;")
dbGetQuery(northwind, "SELECT AVG(Price) FROM Products;")
dbGetQuery(northwind, "SELECT SUM(Quantity) FROM OrderDetails;")

# Like
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerName LIKE 'a%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerName LIKE '%a';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerName LIKE '%or%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerName LIKE '_r%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerName LIKE 'a__%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE ContactName LIKE 'a%o';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE CustomerName NOT LIKE 'a%';")

# Wildcards
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City LIKE 'ber%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City LIKE '%es%';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City LIKE '_ondon';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City LIKE 'L_n_on';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City RLIKE '^[bsp]';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City RLIKE '^[a-c]';")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE City NOT RLIKE '^[bsp]';")

# In
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country IN ('Germany', 'France', 'UK');")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country NOT IN ('Germany', 'France', 'UK');")
dbGetQuery(northwind, "SELECT * FROM Customers WHERE Country IN (SELECT Country FROM Suppliers);")

# Between
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;")
dbGetQuery(northwind, "SELECT * FROM Products WHERE Price BETWEEN 10 AND 20 AND NOT CategoryID IN (1, 2, 3);")
dbGetQuery(northwind, "SELECT * FROM Products
           WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
           ORDER BY ProductName;")
dbGetQuery(northwind, "SELECT * FROM Products
           WHERE ProductName BETWEEN 'Carnarvon Tigers' AND 'Chef Anton\\'s Cajun Seasoning'
           ORDER BY ProductName;")
dbGetQuery(northwind, "SELECT * FROM Products
           WHERE ProductName NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni'
           ORDER BY ProductName;")
dbGetQuery(northwind, "SELECT * FROM Orders
           WHERE STR_TO_DATE(OrderDate, '%c/%e/%Y') BETWEEN '1996-07-01' AND '1996-07-31';")

# Aliases
dbGetQuery(northwind, "SELECT CustomerID AS ID, CustomerName AS Customer FROM Customers;")
dbGetQuery(northwind, "SELECT CustomerName AS Customer, ContactName AS 'Contact Person' FROM Customers;")
dbGetQuery(northwind, "SELECT CustomerName, CONCAT(Address, ', ', PostalCode, ', ', City, ', ', Country) AS Address FROM Customers;")
dbGetQuery(northwind, "SELECT o.OrderID, o.OrderDate, c.CustomerName FROM Customers AS c, Orders AS o
           WHERE c.CustomerName = 'Around the Horn' AND c.CustomerID = o.CustomerID;")
dbGetQuery(northwind, "SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName FROM Customers, Orders
           WHERE Customers.CustomerName = 'Around the Horn' AND Customers.CustomerID = Orders.CustomerID;")

# Inner join
dbGetQuery(northwind, "SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate
           FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;")
dbGetQuery(northwind, "SELECT Orders.OrderID, Customers.CustomerName, Shippers.ShipperName
           FROM ((Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID)
           INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);")

# Left join
dbGetQuery(northwind, "SELECT Customers.CustomerName, Orders.OrderID
           FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID ORDER BY Customers.CustomerName;")

# Right join
dbGetQuery(northwind, "SELECT Orders.OrderID, Employees.LastName, Employees.FirstName
           FROM Orders RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID ORDER BY Orders.OrderID;")

# Full join
dbGetQuery(northwind, "SELECT Customers.CustomerName, Orders.OrderID
           FROM Customers LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
           UNION
           SELECT Customers.CustomerName, Orders.OrderID
           FROM Customers RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID
           ORDER BY CustomerName;")

# Self join
dbGetQuery(northwind, "SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
           FROM Customers AS A, Customers AS B
           WHERE A.CustomerID != B.CustomerID AND A.City = B.City ORDER BY A.City;")

# Union
dbGetQuery(northwind, "SELECT City FROM Customers
           UNION
           SELECT City FROM Suppliers
           ORDER BY City;")
dbGetQuery(northwind, "SELECT City FROM Customers
           UNION ALL
           SELECT City FROM Suppliers
           ORDER BY City;")
dbGetQuery(northwind, "SELECT City, Country FROM Customers WHERE Country = 'Germany'
           UNION
           SELECT City, Country FROM Suppliers WHERE Country = 'Germany'
           ORDER BY City;")
dbGetQuery(northwind, "SELECT City, Country FROM Customers WHERE Country = 'Germany'
           UNION ALL
           SELECT City, Country FROM Suppliers WHERE Country = 'Germany'
           ORDER BY City;")
dbGetQuery(northwind, "SELECT 'Customer' As 'Customer/Supplier', ContactName, City, Country FROM Customers
           UNION
           SELECT 'Supplier', ContactName, City, Country FROM Suppliers;")

# Group by
dbGetQuery(northwind, "SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country;")
dbGetQuery(northwind, "SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country ORDER BY COUNT(CustomerID) DESC;")
dbGetQuery(northwind, "SELECT Shippers.ShipperName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
           LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID GROUP BY ShipperName;")

# Having
dbGetQuery(northwind, "SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country HAVING COUNT(CustomerID) > 5;")
dbGetQuery(northwind, "SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country HAVING COUNT(CustomerID) > 5 ORDER BY COUNT(CustomerID) DESC;")
dbGetQuery(northwind, "SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
           INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID GROUP BY LastName HAVING COUNT(Orders.OrderID) > 10;")
dbGetQuery(northwind, "SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders FROM Orders
           INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID
           WHERE LastName = 'Davolio' OR LastName = 'Fuller' GROUP BY LastName HAVING COUNT(Orders.OrderID) > 25;")

# Exists
dbGetQuery(northwind, "SELECT SupplierName FROM Suppliers
           WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.SupplierID AND Price < 20);")
dbGetQuery(northwind, "SELECT SupplierName FROM Suppliers
           WHERE EXISTS (SELECT ProductName FROM Products WHERE Products.SupplierID = Suppliers.SupplierID AND Price = 22);")

# Any
dbGetQuery(northwind, "SELECT ProductName FROM Products
           WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);")
dbGetQuery(northwind, "SELECT ProductName FROM Products
           WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity > 99);")

# All
dbGetQuery(northwind, "SELECT ProductName FROM Products
           WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity = 10);")

# Insert into select
dbSendStatement(northwind, "INSERT INTO Customers (CustomerName, City, Country)
                SELECT SupplierName, City, Country FROM Suppliers;")
dbSendStatement(northwind, "INSERT INTO Customers (CustomerName, ContactName, Address, City, PostalCode, Country)
                SELECT SupplierName, ContactName, Address, City, PostalCode, Country FROM Suppliers;")
dbSendStatement(northwind, "INSERT INTO Customers (CustomerName, City, Country)
                SELECT SupplierName, City, Country FROM Suppliers WHERE Country = 'Germany';")
dbSendStatement(northwind, "DELETE FROM Customers WHERE CustomerID IS NULL;")

# Case
dbGetQuery(northwind, "SELECT OrderID, Quantity,
           CASE
           WHEN Quantity > 30 THEN 'The quantity is greater than 30'
           WHEN Quantity = 30 THEN 'The quantity is 30'
           ELSE 'The quantity is under 30'
           END AS QuantityText
           FROM OrderDetails;")
dbGetQuery(northwind, "SELECT CustomerName, City, Country FROM Customers
           ORDER BY
           (CASE
             WHEN City IS NULL THEN Country
             ELSE City
             END);")

# Null functions
dbGetQuery(northwind, "SELECT ProductName, 10 * (5 + IFNULL(Price, 0)) FROM Products;")
dbGetQuery(northwind, "SELECT ProductName, 10 * (5 + COALESCE(Price, 0)) FROM Products;")

# Stored procedures
dbSendStatement(northwind, "CREATE PROCEDURE SelectAllCustomers()
BEGIN
  SELECT * FROM Customers;
END")
dbGetQuery(northwind, "CALL SelectAllCustomers;")
dbNextResult(northwind)
dbSendStatement(northwind, "DROP PROCEDURE SelectAllCustomers;")
dbSendStatement(northwind, "CREATE PROCEDURE SelectAllCustomers(InputCity CHAR(30))
BEGIN
  SELECT * FROM Customers WHERE City = InputCity;
END")
dbGetQuery(northwind, "CALL SelectAllCustomers('London');")
dbNextResult(northwind)
dbSendStatement(northwind, "DROP PROCEDURE SelectAllCustomers;")
dbSendStatement(northwind, "CREATE PROCEDURE SelectAllCustomers(InputCity CHAR(30), InputPostalCode CHAR(10))
BEGIN
  SELECT * FROM Customers WHERE City = InputCity AND PostalCode = InputPostalCode;
END")
dbGetQuery(northwind, "CALL SelectAllCustomers('London', 'WA1 1DP');")
dbNextResult(northwind)
dbSendStatement(northwind, "DROP PROCEDURE SelectAllCustomers;")

# Create database
dbSendStatement(northwind, "CREATE DATABASE TestDB;")

# Drop database
dbSendStatement(northwind, "DROP DATABASE TestDB;")

# Create table
dbSendStatement(northwind, "CREATE TABLE Persons (
  PersonID INT,
  LastName VARCHAR(255),
  FirstName VARCHAR(255),
  Address VARCHAR(255),
  City VARCHAR(255) 
);")
dbSendStatement(northwind, "CREATE TABLE TestTable AS
SELECT CustomerName, ContactName FROM Customers;")

# Drop table
dbSendStatement(northwind, "TRUNCATE TABLE TestTable;")
dbSendStatement(northwind, "DROP TABLE TestTable;")

# Alter table
dbSendStatement(northwind, "ALTER TABLE Customers
ADD Email VARCHAR(255);")
dbSendStatement(northwind, "ALTER TABLE Customers
DROP COLUMN Email;")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD DateOfBirth DATE;")
dbSendStatement(northwind, "ALTER TABLE Persons
MODIFY COLUMN DateOfBirth YEAR;")
dbSendStatement(northwind, "ALTER TABLE Persons
DROP COLUMN DateOfBirth;")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Not null
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255) NOT NULL,
  Age INT
);")
dbSendStatement(northwind, "ALTER TABLE Persons
MODIFY Age INT NOT NULL;")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Unique
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  UNIQUE (ID)
);")
dbSendStatement(northwind, "DROP TABLE Persons;")
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  CONSTRAINT UC_Person UNIQUE (ID, LastName)
);")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD UNIQUE (ID);")
dbSendStatement(northwind, "ALTER TABLE Persons
DROP INDEX UC_Person;")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD CONSTRAINT UC_Person UNIQUE (ID, LastName);")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Primary key
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  PRIMARY KEY (ID)
);")
dbSendStatement(northwind, "DROP TABLE Persons;")
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID int NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  CONSTRAINT PK_Person PRIMARY KEY (ID, LastName)
);")
dbSendStatement(northwind, "ALTER TABLE Persons
DROP PRIMARY KEY;")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD PRIMARY KEY (ID);")
dbSendStatement(northwind, "ALTER TABLE Persons
DROP PRIMARY KEY;")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD CONSTRAINT PK_Person PRIMARY KEY (ID, LastName);")

# Foreign key
dbSendStatement(northwind, "CREATE TABLE NewOrders (
  OrderID INT NOT NULL,
  OrderNumber INT NOT NULL,
  PersonID INT,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);")
dbSendStatement(northwind, "DROP TABLE NewOrders;")
dbSendStatement(northwind, "CREATE TABLE NewOrders (
  OrderID INT NOT NULL,
  OrderNumber INT NOT NULL,
  PersonID INT,
  PRIMARY KEY (OrderID),
  CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID)
);")
dbSendStatement(northwind, "ALTER TABLE NewOrders
ADD FOREIGN KEY (PersonID) REFERENCES Persons(ID);")
dbSendStatement(northwind, "ALTER TABLE NewOrders
DROP FOREIGN KEY FK_PersonOrder;")
dbSendStatement(northwind, "ALTER TABLE NewOrders
ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID);")
dbSendStatement(northwind, "DROP TABLE NewOrders;")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Check
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  CHECK (Age >= 18)
);")
dbSendStatement(northwind, "DROP TABLE Persons;")
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  City VARCHAR(255),
  CONSTRAINT CHK_Person CHECK (Age >= 18 AND City = 'Sandnes')
);")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD CHECK (Age >= 18);")
dbSendStatement(northwind, "ALTER TABLE Persons
ADD CONSTRAINT CHK_PersonAge CHECK (Age >= 18 AND City = 'Sandnes');")
dbSendStatement(northwind, "ALTER TABLE Persons
DROP CHECK CHK_PersonAge;")
dbGetQuery(northwind, "SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Default
dbSendStatement(northwind, "CREATE TABLE Persons (
  ID INT NOT NULL,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  City VARCHAR(255) DEFAULT 'Sandnes'
);")
dbSendStatement(northwind, "CREATE TABLE NewOrders (
  ID INT NOT NULL,
  OrderNumber INT NOT NULL,
  OrderDate DATETIME DEFAULT NOW()
);")
dbSendStatement(northwind, "DROP TABLE NewOrders;")
dbSendStatement(northwind, "ALTER TABLE Persons
ALTER City SET DEFAULT 'Sandnes';")
dbSendStatement(northwind, "ALTER TABLE Persons
ALTER City DROP DEFAULT;")

# Index
dbSendStatement(northwind, "CREATE INDEX idx_lastname ON Persons (LastName);")
dbSendStatement(northwind, "CREATE INDEX idx_pname ON Persons (LastName, FirstName);")
dbSendStatement(northwind, "ALTER TABLE Persons
DROP INDEX idx_pname;")
dbSendStatement(northwind, "CREATE UNIQUE INDEX idx_pname ON Persons (LastName, FirstName);")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Auto increment
dbSendStatement(northwind, "CREATE TABLE Persons (
  PersonID INT NOT NULL AUTO_INCREMENT,
  LastName VARCHAR(255) NOT NULL,
  FirstName VARCHAR(255),
  Age INT,
  PRIMARY KEY (PersonID)
);")
dbSendStatement(northwind, "ALTER TABLE Persons AUTO_INCREMENT = 100;")
dbSendStatement(northwind, "INSERT INTO Persons (FirstName, LastName)
VALUES ('Lars', 'Monsen');")
dbSendStatement(northwind, "DROP TABLE Persons;")

# Views
dbSendStatement(northwind, "CREATE VIEW BrazilCustomers AS
SELECT CustomerName, ContactName FROM Customers WHERE Country = 'Brazil';")
dbGetQuery(northwind, "SELECT * FROM BrazilCustomers;")
dbSendStatement(northwind, "CREATE VIEW ProductsAboveAveragePrice AS
SELECT ProductName, Price FROM Products WHERE Price > (SELECT AVG(Price) FROM Products);")
dbGetQuery(northwind, "SELECT * FROM ProductsAboveAveragePrice;")
dbSendStatement(northwind, "CREATE OR REPLACE VIEW BrazilCustomers AS
SELECT CustomerName, ContactName, City FROM Customers WHERE Country = 'Brazil';")
dbSendStatement(northwind, "DROP VIEW BrazilCustomers;")
dbSendStatement(northwind, "DROP VIEW ProductsAboveAveragePrice;")

# Disconnect from database
dbDisconnect(northwind)
