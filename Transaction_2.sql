-- 68040249132

-- ตรวจสอบรหัสลูกค้า ALFKI
select CustomerID, companyname
from Customers
where CustomerID = 'ALFKI';

BEGIN TRANSACTION; -- เริ่มต้น Transaction
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 50.00);

SELECT SCOPE_IDENTITY() AS NewOrderID;

-- เพิ่มสินค้าชิ้นที่ 1 (ProductID = 1, จำนวน = 2)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11078, ProductID, UnitPrice, 2, 0
FROM Products
WHERE ProductID = 1;

SELECT * FROM Orders WHERE OrderID = 11078;
SELECT * FROM [Order Details] WHERE OrderID = 11078;

-- ตรวจสอบผลหลัง COMMIT
SELECT * FROM Orders WHERE OrderID = 11078;
SELECT * FROM [Order Details] WHERE OrderID = 11078;

USE Northwind;
BEGIN TRANSACTION; -- เริ่ม Transaction ใหม่
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 75.00);

SELECT SCOPE_IDENTITY() AS RollbackOrderID;--11709
-- เพิ่มสินค้าชิ้นที่ 1 (ProductID = 1, จำนวน = 1)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11709, ProductID, UnitPrice, 1, 0
FROM Products
WHERE ProductID = 1;

SELECT * FROM Orders WHERE OrderID = 11079;
SELECT * FROM [Order Details] WHERE OrderID = 11079;

COMMIT;
-- ตรวจสอบผลหลัง COMMIT
SELECT * FROM Orders WHERE OrderID = 11079;
SELECT * FROM [Order Details] WHERE OrderID = 11079;

SELECT SCOPE_IDENTITY() AS NewOrderID;

-- เพิ่มสินค้าชิ้นที่ 1 (ProductID = 1, จำนวน = 2)
INSERT INTO [Order Details] (OrderID, ProductID, UnitPrice, Quantity, Discount)
SELECT 11079, ProductID, UnitPrice, 2, 0
FROM Products
WHERE ProductID = 1;

SELECT * FROM Orders WHERE OrderID = 11079;
SELECT * FROM [Order Details] WHERE OrderID = 11079;

COMMIT; 
-- ตรวจสอบผลหลัง COMMIT
SELECT * FROM Orders WHERE OrderID = 11079;
SELECT * FROM [Order Details] WHERE OrderID = 11079;

USE Northwind;
BEGIN TRANSACTION; -- เริ่ม Transaction ใหม่
INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, Freight)
VALUES ('ALFKI', 1, GETDATE(), DATEADD(DAY, 7, GETDATE()), 75.00);

