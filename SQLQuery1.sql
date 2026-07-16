--เริ่มจาก Master สร้างฐานข้อมูลชื่อ
Create Database CSMinimart
--ปรับให้ฐานข้อมูลสามารถเพิ่มข้อมูลที่เป็นภาษาไทยได้
Alter Database CSMinimart Collate Thai_CI_AS;
--เปลี่ยนฐานข้อมูลไปใช้ CSMinimart เปลี่ยนแถบเมนู
--สร้างตารางเก็บข้อมูลพนักงาน ชื่อ Empoyees
Create Table Employees(
	EmployeeID int identity(1,1) Primary key,
	title varchar(20) null,  
	firstname varchar(50) not null,
	lastname varchar(50) null,
	position varchar(50) null,
	usernamme varchar(50) Unique,
	passwordhash varchar(255) not null,
	IsActive bit Not null default 1
)

INSERT INTO Employees
    (Title, FirstName, LastName, Position, UserNamme, PasswordHash)
VALUES
    ('นางสาว', 'กาญจนา', 'พวงแก้ว', 'Sale Manager', 'user1', 'hashed1');

INSERT INTO Employees
    (Title, FirstName, LastName, Position, UserNamme, PasswordHash)
VALUES
    ('นาย', 'พีรพัฒน์', 'อุปพงศ์', 'Sale Manager', 'user2', 'hashed2');
--เเสดงตารางข้อมูลพนักงาน
SELECT * FROM Employees;
-----------------------------------------------------------

-- ตารางสินค้า

CREATE TABLE Categories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(200)
);

INSERT INTO Categories
    (CategoryName, Description)
VALUES ('เครื่องดื่ม','น้ำดื่ม น้ำผลไม้ ชาและกาแฟ');
INSERT INTO Categories
    (CategoryName, Description)
VALUES ('อาหาาร','มาม่า โจ๊ก');
INSERT INTO Categories
    (CategoryName, Description)
VALUES ('เครื่องปรุง','ซอส น้ำปลา เกลือ');
INSERT INTO Categories
    (CategoryName, Description)
VALUES ('เครื่องสำอาง','เเป้ง ลิป ครีม');
INSERT INTO Categories
    (CategoryName, Description)
VALUES ('เวชภัณฑ์','ยา เเอลกอฮอล์');
-- ดูข้อมูลสินค้า
SELECT * FROM Categories;
---------------------------------------------------------------

--สร้างตาราง products
CREATE TABLE Products (
    ProductID VARCHAR(13) PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0,
    UnitsInStock INT NOT NULL DEFAULT 0,
    CategoryID INT NOT NULL,
    Discontinued BIT NOT NULL DEFAULT 0,

    CONSTRAINT CK_Products_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Products_UnitsInStock
        CHECK (UnitsInStock >= 0),

    CONSTRAINT FK_Products_Categories
        FOREIGN KEY (CategoryID)
        REFERENCES Categories(CategoryID)
);

INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
    ('8858757001948', 'โค้ก', 15.00, 290, 1);

INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
    ('8852398155747', 'ปากกา', 20.00, 20, 1);

INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
    ('8852398121483', 'สมุด', 50.00, 20, 1);

INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
    ('8856446845825', 'หนังสือ', 100.00, 20, 1);

INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
    ('8845451553654', 'ขนมปัง', 40.00, 20, 1);
--ดูข้อมูล products
select * from Products
-------------------------------------------------------
-- สร้างตารางใบเสร็จ

CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,
    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),
    EmployeeID INT NOT NULL,
    TotalCash DECIMAL(10,2) NOT NULL DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);
--เพิ่มข้อมูลในตารางใบเสร็จ
INSERT INTO Receipts
    (EmployeeID, TotalCash)
VALUES
    (1, 115.00);
-- ดูตารางใบเสร็จ
SELECT * FROM Receipts;
-------------------------------------------------------
-- สร้างตาราง Details
CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);
-- เพิมข้อมูลตาราง Details
INSERT INTO Details(ReceiptID, ProductID, UnitPrice, Quantity)
VALUES(1, '8858757001948', 15.00, 3);

--ข้อมูลที่ผิด
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 0);

--ดูข้อมูลตารางDetails 
SELECT * FROM Details;