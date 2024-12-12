CREATE DATABASE ASM_SE072032;
GO
USE ASM_SE072032
GO
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName NVARCHAR(100) NOT NULL
);
INSERT INTO Category (CategoryName) 
VALUES 
('Milk Tea'),
('Fruit Tea'),
('Smoothies'),
('Add-ons');

SELECT * FROM Category;

CREATE TABLE Product (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductCode NVARCHAR(50) NOT NULL,
    ProductName NVARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    InventoryQuantity INT NOT NULL,
    ProductImage NVARCHAR(MAX),
    CategoryID INT,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);
INSERT INTO Product (ProductCode, ProductName, Price, InventoryQuantity, ProductImage, CategoryID) 
VALUES 
('MT001', 'Classic Milk Tea', 4.50, 100, 'classic_milk_tea.jpg', 1),
('MT002', 'Brown Sugar Milk Tea', 5.00, 80, 'brown_sugar_milk_tea.jpg', 1),
('FT001', 'Passion Fruit Tea', 4.75, 60, 'passion_fruit_tea.jpg', 2),
('SM001', 'Strawberry Smoothie', 5.25, 50, 'strawberry_smoothie.jpg', 3),
('AO001', 'Pearls', 0.50, 200, 'pearls.jpg', 4),
('AO002', 'Pudding', 0.75, 150, 'pudding.jpg', 4);
SELECT * FROM Product;

SELECT 
    ProductID, 
    ProductName, 
    Price, 
    InventoryQuantity AS Quantity, 
    CategoryName
FROM 
    Product
INNER JOIN 
    Category ON Product.CategoryID = Category.CategoryID;


CREATE TABLE Employee (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeCode NVARCHAR(50) NOT NULL,
    EmployeeName NVARCHAR(100) NOT NULL,
    Position NVARCHAR(50),
    AuthorityLevel NVARCHAR(50) NOT NULL,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    PasswordChanged BIT DEFAULT 0
);
INSERT INTO [dbo].[Employee] 
VALUES ('Emp1', 'Nguyen Van A', 'Manager', 'Admin', 'admin1','123456', 1);

INSERT INTO [dbo].[Employee] 
VALUES ('Emp2', 'Nguyen Van B', 'Staff', 'Warehouse Manager', 'warehousemanager1','123456', 1),
		('Emp3', 'Nguyen Van C', 'Staff', 'Sale', 'sale1','123456', 0);

SELECT * FROM [dbo].[Employee];

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerCode NVARCHAR(50) NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL,
    PhoneNumber NVARCHAR(20),
    Address NVARCHAR(255)
);
INSERT INTO Customer (CustomerCode, CustomerName, PhoneNumber, Address) 
VALUES
('CUS001', 'Nguyen Van D', '0901234567', '123 Le Loi, Ho Chi Minh City'),
('CUS002', 'Tran Thi E', '0912345678', '456 Nguyen Hue, Da Nang'),
('CUS003', 'Le Van F', '0923456789', '789 Tran Phu, Ha Noi');
SELECT * FROM Customer;
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATETIME NOT NULL,
    EmployeeID INT,
    CustomerID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
INSERT INTO Orders (OrderDate, EmployeeID, CustomerID) 
VALUES 
('2024-12-01', 2, 1),
('2024-12-03', 3, 2),
('2024-12-04', 3, 3);
SELECT * FROM Orders;

SELECT 
    OrderID, 
    OrderDate, 
    EmployeeName AS Employee, 
    CustomerName AS Customer, 
    PhoneNumber AS CustomerPhone
FROM 
    Orders
INNER JOIN 
    Employee ON Orders.EmployeeID = Employee.EmployeeID
INNER JOIN 
    Customer ON Orders.CustomerID = Customer.CustomerID;


CREATE TABLE OrderDetail (
    OrderDetailID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT,
    ProductID INT,
    QuantitySold INT NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
INSERT INTO OrderDetail (OrderID, ProductID, QuantitySold) 
VALUES 
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 4, 2);
SELECT * FROM OrderDetail;


CREATE TABLE Import (
    ImportID INT PRIMARY KEY IDENTITY(1,1),
    ImportDate DATETIME NOT NULL,
    EmployeeID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);
INSERT INTO Import (ImportDate, EmployeeID) 
VALUES 
('2024-11-28', 2),
('2024-11-30', 2);
SELECT * FROM Import;

CREATE TABLE ImportDetail (
    ImportDetailID INT PRIMARY KEY IDENTITY(1,1),
    ImportID INT,
    ProductID INT,
    QuantityImported INT NOT NULL,
    ImportCost DECIMAL(10, 2),
    FOREIGN KEY (ImportID) REFERENCES Import(ImportID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);
INSERT INTO ImportDetail (ImportID, ProductID, QuantityImported, ImportCost) 
VALUES 
(1, 1, 20, 80.00),
(1, 2, 10, 100.00),
(2, 3, 15, 60.00),
(2, 4, 25, 50.00);
SELECT * FROM ImportDetail;
SELECT ImportDetailID, ImportDate, ProductName, QuantityImported, ImportCost
FROM ImportDetail
INNER JOIN Import ON ImportDetail.ImportID = Import.ImportID
INNER JOIN Product ON ImportDetail.ProductID = Product.ProductID;