"""MySQL Examples in Python"""

# Import libraries
import mysql.connector
import pandas

# Connect to database
CONNECTION = mysql.connector.connect(host='localhost', user='root',
                                     passwd='password',
                                     auth_plugin='mysql_native_password')
MYSQL = CONNECTION.cursor()


# Create get_query function
def get_query(query):
    return pandas.read_sql(query, CONNECTION)


# Create send_statement function
def send_statement(statement):
    MYSQL.execute(statement)
    CONNECTION.commit()


# Create call_procedure function
def call_procedure(procedure, *args):
    MYSQL.callproc(procedure, args)
    for result in MYSQL.stored_results():
        print(result.fetchall())


# Show databases
get_query("SHOW DATABASES;")

# Set default database
send_statement("USE Northwind;")

# Show tables
get_query("SHOW TABLES;")

# Write CustomersBackup table into MySQL
send_statement("CREATE TABLE CustomersBackup AS SELECT * FROM Customers;")

# Select
get_query("SELECT * FROM Customers;")
get_query("SELECT CustomerName, City FROM Customers;")

# Select distinct
get_query("SELECT Country FROM Customers;")
get_query("SELECT DISTINCT	Country FROM Customers;")
get_query("SELECT COUNT(DISTINCT Country) FROM Customers;")

# Where
get_query("SELECT * FROM Customers WHERE Country = 'Mexico';")
get_query("SELECT * FROM Customers WHERE CustomerID = 1;")

# Operators
get_query("SELECT * FROM Products WHERE Price = 18;")
get_query("SELECT * FROM Products WHERE Price > 30;")
get_query("SELECT * FROM Products WHERE Price < 30;")
get_query("SELECT * FROM Products WHERE Price >= 30;")
get_query("SELECT * FROM Products WHERE Price <= 30;")
get_query("SELECT * FROM Products WHERE Price <> 18;")
get_query("SELECT * FROM Products WHERE Price != 18;")
get_query("SELECT * FROM Products WHERE Price BETWEEN 50 AND 60;")
get_query("SELECT * FROM Customers WHERE City LIKE 's%';")
get_query("SELECT * FROM Customers WHERE City IN ('London', 'Paris');")

# And
get_query("SELECT * FROM Customers WHERE Country = 'Germany' \
AND City = 'Berlin';")

# Or
get_query("SELECT * FROM Customers WHERE City = 'Berlin' OR City = 'Munchen';")
get_query("SELECT * FROM Customers \
WHERE Country = 'Germany' OR Country = 'Spain';")
get_query("SELECT * FROM Customers WHERE Country = 'Germany' \
AND (City = 'Berlin' OR City = 'Munchen');")

# Not
get_query("SELECT * FROM Customers WHERE NOT Country = 'Germany';")
get_query("SELECT * FROM Customers WHERE NOT Country = 'Germany' \
AND NOT Country = 'USA';")

# Order by
get_query("SELECT * FROM Customers ORDER BY Country;")
get_query("SELECT * FROM Customers ORDER BY Country DESC;")
get_query("SELECT * FROM Customers ORDER BY Country, CustomerName;")
get_query("SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;")

# Insert into
send_statement("INSERT INTO Customers (CustomerName, ContactName, Address, \
City, PostalCode, Country) \
VALUES ('Cardinal', 'Tom B. Erichsen', 'Skagen 21', 'Stavanger', '4006', \
'Norway');")
send_statement("INSERT INTO Customers (CustomerName, City, Country) \
VALUES ('Cardinal', 'Stavanger', 'Norway');")

# Null values
get_query("SELECT CustomerName, ContactName, Address FROM Customers \
WHERE Address IS NULL;")
get_query("SELECT CustomerName, ContactName, Address FROM Customers \
WHERE Address IS NOT NULL;")

# Update
send_statement("UPDATE Customers SET ContactName = 'Alfred Schmidt', \
City = 'Frankfurt' WHERE CustomerID = 1;")
send_statement("UPDATE Customers SET ContactName = 'Juan' \
WHERE Country = 'Mexico';")
send_statement("UPDATE Customers SET ContactName = 'Juan';")

# Delete
send_statement("DELETE FROM Customers \
WHERE CustomerName = 'Alfreds Futterkiste';")
send_statement("DELETE FROM Customers;")
send_statement("DROP TABLE Customers;")
send_statement("CREATE TABLE Customers AS SELECT * FROM CustomersBackup;")
send_statement("DROP TABLE CustomersBackup;")

# Limit
get_query("SELECT * FROM Customers LIMIT 3;")
get_query("SELECT * FROM Customers WHERE Country = 'Germany' LIMIT 3;")

# Min and Max
get_query("SELECT MIN(Price) AS SmallestPrice FROM Products;")
get_query("SELECT MAX(Price) AS LargestPrice FROM Products;")

# Count, Avg, and Sum
get_query("SELECT COUNT(ProductID) FROM Products;")
get_query("SELECT AVG(Price) FROM Products;")
get_query("SELECT SUM(Quantity) FROM OrderDetails;")

# Like
get_query("SELECT * FROM Customers WHERE CustomerName LIKE 'a%';")
get_query("SELECT * FROM Customers WHERE CustomerName LIKE '%a';")
get_query("SELECT * FROM Customers WHERE CustomerName LIKE '%or%';")
get_query("SELECT * FROM Customers WHERE CustomerName LIKE '_r%';")
get_query("SELECT * FROM Customers WHERE CustomerName LIKE 'a__%';")
get_query("SELECT * FROM Customers WHERE ContactName LIKE 'a%o';")
get_query("SELECT * FROM Customers WHERE CustomerName NOT LIKE 'a%';")

# Wildcards
get_query("SELECT * FROM Customers WHERE City LIKE 'ber%';")
get_query("SELECT * FROM Customers WHERE City LIKE '%es%';")
get_query("SELECT * FROM Customers WHERE City LIKE '_ondon';")
get_query("SELECT * FROM Customers WHERE City LIKE 'L_n_on';")
get_query("SELECT * FROM Customers WHERE City RLIKE '^[bsp]';")
get_query("SELECT * FROM Customers WHERE City RLIKE '^[a-c]';")
get_query("SELECT * FROM Customers WHERE City NOT RLIKE '^[bsp]';")

# In
get_query("SELECT * FROM Customers \
WHERE Country IN ('Germany', 'France', 'UK');")
get_query("SELECT * FROM Customers \
WHERE Country NOT IN ('Germany', 'France', 'UK');")
get_query("SELECT * FROM Customers \
WHERE Country IN (SELECT Country FROM Suppliers);")

# Between
get_query("SELECT * FROM Products WHERE Price BETWEEN 10 AND 20;")
get_query("SELECT * FROM Products WHERE Price NOT BETWEEN 10 AND 20;")
get_query("SELECT * FROM Products \
WHERE Price BETWEEN 10 AND 20 AND NOT CategoryID IN (1, 2, 3);")
get_query("SELECT * FROM Products WHERE ProductName \
BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' ORDER BY ProductName;")
get_query("SELECT * FROM Products WHERE ProductName \
BETWEEN 'Carnarvon Tigers' AND 'Chef Anton\\'s Cajun Seasoning' \
ORDER BY ProductName;")
get_query("SELECT * FROM Products WHERE ProductName \
NOT BETWEEN 'Carnarvon Tigers' AND 'Mozzarella di Giovanni' \
ORDER BY ProductName;")
get_query("SELECT * FROM Orders WHERE STR_TO_DATE(OrderDate, '%c/%e/%Y') \
BETWEEN '1996-07-01' AND '1996-07-31';")

# Aliases
get_query("SELECT CustomerID AS ID, CustomerName AS Customer FROM Customers;")
get_query("SELECT CustomerName AS Customer, ContactName AS 'Contact Person' \
FROM Customers;")
get_query("SELECT CustomerName, CONCAT(Address, ', ', PostalCode, ', ', \
City, ', ', Country) AS Address FROM Customers;")
get_query("SELECT o.OrderID, o.OrderDate, c.CustomerName \
FROM Customers AS c, Orders AS o \
WHERE c.CustomerName = 'Around the Horn' AND c.CustomerID = o.CustomerID;")
get_query("SELECT Orders.OrderID, Orders.OrderDate, Customers.CustomerName \
FROM Customers, Orders WHERE Customers.CustomerName = 'Around the Horn' \
AND Customers.CustomerID = Orders.CustomerID;")

# Inner join
get_query("SELECT Orders.OrderID, Customers.CustomerName, Orders.OrderDate \
FROM Orders INNER JOIN Customers ON Orders.CustomerID = Customers.CustomerID;")
get_query("SELECT Orders.OrderID, Customers.CustomerName, \
Shippers.ShipperName FROM ((Orders INNER JOIN Customers \
ON Orders.CustomerID = Customers.CustomerID) \
INNER JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID);")

# Left join
get_query("SELECT Customers.CustomerName, Orders.OrderID FROM Customers \
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID \
ORDER BY Customers.CustomerName;")

# Right join
get_query("SELECT Orders.OrderID, Employees.LastName, Employees.FirstName \
FROM Orders RIGHT JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID \
ORDER BY Orders.OrderID;")

# Full join
get_query("SELECT Customers.CustomerName, Orders.OrderID FROM Customers \
LEFT JOIN Orders ON Customers.CustomerID = Orders.CustomerID \
UNION SELECT Customers.CustomerName, Orders.OrderID FROM Customers \
RIGHT JOIN Orders ON Customers.CustomerID = Orders.CustomerID \
ORDER BY CustomerName;")

# Self join
get_query("SELECT A.CustomerName AS CustomerName1, B.CustomerName AS \
CustomerName2, A.City FROM Customers AS A, Customers AS B \
WHERE A.CustomerID != B.CustomerID AND A.City = B.City ORDER BY A.City;")

# Union
get_query("SELECT City FROM Customers \
UNION SELECT City FROM Suppliers ORDER BY City;")
get_query("SELECT City FROM Customers \
UNION ALL SELECT City FROM Suppliers ORDER BY City;")
get_query("SELECT City, Country FROM Customers WHERE Country = 'Germany' \
UNION SELECT City, Country FROM Suppliers WHERE Country = 'Germany' \
ORDER BY City;")
get_query("SELECT City, Country FROM Customers WHERE Country = 'Germany' \
UNION ALL SELECT City, Country FROM Suppliers WHERE Country = 'Germany'\
ORDER BY City;")
get_query("SELECT 'Customer' As 'Customer/Supplier', ContactName, City, \
Country FROM Customers \
UNION SELECT 'Supplier', ContactName, City, Country FROM Suppliers;")

# Group by
get_query("SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country;")
get_query("SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country \
ORDER BY COUNT(CustomerID) DESC;")
get_query("SELECT Shippers.ShipperName, COUNT(Orders.OrderID) \
AS NumberOfOrders FROM Orders \
LEFT JOIN Shippers ON Orders.ShipperID = Shippers.ShipperID \
GROUP BY ShipperName;")

# Having
get_query("SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country \
HAVING COUNT(CustomerID) > 5;")
get_query("SELECT COUNT(CustomerID), Country FROM Customers GROUP BY Country \
HAVING COUNT(CustomerID) > 5 ORDER BY COUNT(CustomerID) DESC;")
get_query("SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders \
FROM Orders INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID \
GROUP BY LastName HAVING COUNT(Orders.OrderID) > 10;")
get_query("SELECT Employees.LastName, COUNT(Orders.OrderID) AS NumberOfOrders \
FROM Orders INNER JOIN Employees ON Orders.EmployeeID = Employees.EmployeeID \
WHERE LastName = 'Davolio' OR LastName = 'Fuller' GROUP BY LastName \
HAVING COUNT(Orders.OrderID) > 25;")

# Exists
get_query("SELECT SupplierName FROM Suppliers \
WHERE EXISTS (SELECT ProductName FROM Products \
WHERE Products.SupplierID = Suppliers.SupplierID AND Price < 20);")
get_query("SELECT SupplierName FROM Suppliers \
WHERE EXISTS (SELECT ProductName FROM Products \
WHERE Products.SupplierID = Suppliers.SupplierID AND Price = 22);")

# Any
get_query("SELECT ProductName FROM Products WHERE ProductID = ANY \
(SELECT ProductID FROM OrderDetails WHERE Quantity = 10);")
get_query("SELECT ProductName FROM Products WHERE ProductID = ANY \
(SELECT ProductID FROM OrderDetails WHERE Quantity > 99);")

# All
get_query("SELECT ProductName FROM Products WHERE ProductID = ALL \
(SELECT ProductID FROM OrderDetails WHERE Quantity = 10);")

# Insert into select
send_statement("INSERT INTO Customers (CustomerName, City, Country) \
SELECT SupplierName, City, Country FROM Suppliers;")
send_statement("INSERT INTO Customers (CustomerName, ContactName, Address, \
City, PostalCode, Country) SELECT SupplierName, ContactName, Address, City, \
PostalCode, Country FROM Suppliers;")
send_statement("INSERT INTO Customers (CustomerName, City, Country) \
SELECT SupplierName, City, Country FROM Suppliers WHERE Country = 'Germany';")
send_statement("DELETE FROM Customers WHERE CustomerID IS NULL;")

# Case
get_query("SELECT OrderID, Quantity, \
CASE WHEN Quantity > 30 THEN 'The quantity is greater than 30' \
WHEN Quantity = 30 THEN 'The quantity is 30' ELSE 'The quantity is under 30' \
END AS QuantityText FROM OrderDetails;")
get_query("SELECT CustomerName, City, Country FROM Customers ORDER BY \
(CASE WHEN City IS NULL THEN Country ELSE City END);")

# Null functions
get_query("SELECT ProductName, 10 * (5 + IFNULL(Price, 0)) FROM Products;")
get_query("SELECT ProductName, 10 * (5 + COALESCE(Price, 0)) FROM Products;")

# Stored procedures
send_statement("CREATE PROCEDURE SelectAllCustomers() \
BEGIN SELECT * FROM Customers; END")
call_procedure('SelectAllCustomers')
send_statement("DROP PROCEDURE SelectAllCustomers;")
send_statement("CREATE PROCEDURE SelectAllCustomers(InputCity CHAR(30)) \
BEGIN SELECT * FROM Customers WHERE City = InputCity; END")
call_procedure('SelectAllCustomers', 'London')
send_statement("DROP PROCEDURE SelectAllCustomers;")
send_statement("CREATE PROCEDURE SelectAllCustomers(InputCity CHAR(30), \
InputPostalCode CHAR(10)) BEGIN SELECT * FROM Customers \
WHERE City = InputCity AND PostalCode = InputPostalCode; END")
call_procedure('SelectAllCustomers', 'London', 'WA1 1DP')
send_statement("DROP PROCEDURE SelectAllCustomers;")

# Create database
send_statement("CREATE DATABASE TestDB;")

# Drop database
send_statement("DROP DATABASE TestDB;")

# Create table
send_statement("CREATE TABLE Persons (PersonID INT, LastName VARCHAR(255), \
FirstName VARCHAR(255), Address VARCHAR(255), City VARCHAR(255));")
send_statement("CREATE TABLE TestTable AS \
SELECT CustomerName, ContactName FROM Customers;")

# Drop table
send_statement("TRUNCATE TABLE TestTable;")
send_statement("DROP TABLE TestTable;")

# Alter table
send_statement("ALTER TABLE Customers ADD Email VARCHAR(255);")
send_statement("ALTER TABLE Customers DROP COLUMN Email;")
send_statement("ALTER TABLE Persons ADD DateOfBirth DATE;")
send_statement("ALTER TABLE Persons MODIFY COLUMN DateOfBirth YEAR;")
send_statement("ALTER TABLE Persons DROP COLUMN DateOfBirth;")
send_statement("DROP TABLE Persons;")

# Not null
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255) NOT NULL, Age INT);")
send_statement("ALTER TABLE Persons MODIFY Age INT NOT NULL;")
send_statement("DROP TABLE Persons;")

# Unique
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
UNIQUE (ID));")
send_statement("DROP TABLE Persons;")
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
CONSTRAINT UC_Person UNIQUE (ID, LastName));")
send_statement("ALTER TABLE Persons ADD UNIQUE (ID);")
send_statement("ALTER TABLE Persons DROP INDEX UC_Person;")
send_statement("ALTER TABLE Persons \
ADD CONSTRAINT UC_Person UNIQUE (ID, LastName);")
send_statement("DROP TABLE Persons;")

# Primary key
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
PRIMARY KEY (ID));")
send_statement("DROP TABLE Persons;")
send_statement("CREATE TABLE Persons (ID int NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
CONSTRAINT PK_Person PRIMARY KEY (ID, LastName));")
send_statement("ALTER TABLE Persons DROP PRIMARY KEY;")
send_statement("ALTER TABLE Persons ADD PRIMARY KEY (ID);")
send_statement("ALTER TABLE Persons DROP PRIMARY KEY;")
send_statement("ALTER TABLE Persons \
ADD CONSTRAINT PK_Person PRIMARY KEY (ID, LastName);")

# Foreign key
send_statement("CREATE TABLE NewOrders (OrderID INT NOT NULL, \
OrderNumber INT NOT NULL, PersonID INT, PRIMARY KEY (OrderID), \
FOREIGN KEY (PersonID) REFERENCES Persons(ID));")
send_statement("DROP TABLE NewOrders;")
send_statement("CREATE TABLE NewOrders (OrderID INT NOT NULL, \
OrderNumber INT NOT NULL, PersonID INT, PRIMARY KEY (OrderID), \
CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID));")
send_statement("ALTER TABLE NewOrders \
ADD FOREIGN KEY (PersonID) REFERENCES Persons(ID);")
send_statement("ALTER TABLE NewOrders DROP FOREIGN KEY FK_PersonOrder;")
send_statement("ALTER TABLE NewOrders \
ADD CONSTRAINT FK_PersonOrder FOREIGN KEY (PersonID) REFERENCES Persons(ID);")
send_statement("DROP TABLE NewOrders;")
send_statement("DROP TABLE Persons;")

# Check
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
CHECK (Age >= 18));")
send_statement("DROP TABLE Persons;")
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
City VARCHAR(255), \
CONSTRAINT CHK_Person CHECK (Age >= 18 AND City = 'Sandnes'));")
send_statement("ALTER TABLE Persons ADD CHECK (Age >= 18);")
send_statement("ALTER TABLE Persons \
ADD CONSTRAINT CHK_PersonAge CHECK (Age >= 18 AND City = 'Sandnes');")
send_statement("ALTER TABLE Persons DROP CHECK CHK_PersonAge;")
get_query("SELECT * FROM INFORMATION_SCHEMA.CHECK_CONSTRAINTS;")
send_statement("DROP TABLE Persons;")

# Default
send_statement("CREATE TABLE Persons (ID INT NOT NULL, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
City VARCHAR(255) DEFAULT 'Sandnes');")
send_statement("CREATE TABLE NewOrders (ID INT NOT NULL, \
OrderNumber INT NOT NULL, OrderDate DATETIME DEFAULT NOW());")
send_statement("DROP TABLE NewOrders;")
send_statement("ALTER TABLE Persons ALTER City SET DEFAULT 'Sandnes';")
send_statement("ALTER TABLE Persons ALTER City DROP DEFAULT;")

# Index
send_statement("CREATE INDEX idx_lastname ON Persons (LastName);")
send_statement("CREATE INDEX idx_pname ON Persons (LastName, FirstName);")
send_statement("ALTER TABLE Persons DROP INDEX idx_pname;")
send_statement("CREATE UNIQUE INDEX idx_pname \
ON Persons (LastName, FirstName);")
send_statement("DROP TABLE Persons;")

# Auto increment
send_statement("CREATE TABLE Persons (PersonID INT NOT NULL AUTO_INCREMENT, \
LastName VARCHAR(255) NOT NULL, FirstName VARCHAR(255), Age INT, \
PRIMARY KEY (PersonID));")
send_statement("ALTER TABLE Persons AUTO_INCREMENT = 100;")
send_statement("INSERT INTO Persons (FirstName, LastName) \
VALUES ('Lars', 'Monsen');")
send_statement("DROP TABLE Persons;")

# Views
send_statement("CREATE VIEW BrazilCustomers AS \
SELECT CustomerName, ContactName FROM Customers WHERE Country = 'Brazil';")
get_query("SELECT * FROM BrazilCustomers;")
send_statement("CREATE VIEW ProductsAboveAveragePrice AS \
SELECT ProductName, Price FROM Products WHERE Price > (SELECT AVG(Price) \
FROM Products);")
get_query("SELECT * FROM ProductsAboveAveragePrice;")
send_statement("CREATE OR REPLACE VIEW BrazilCustomers AS \
SELECT CustomerName, ContactName, City FROM Customers \
WHERE Country = 'Brazil';")
send_statement("DROP VIEW BrazilCustomers;")
send_statement("DROP VIEW ProductsAboveAveragePrice;")

# Disconnect from database
MYSQL.close()
CONNECTION.close()
