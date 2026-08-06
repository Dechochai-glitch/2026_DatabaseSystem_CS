--Lab ในชั้นเรียนวันที่  6 สิงหาคม 2569
--ใช้ ฐานข้อมูล Northwind เพื่อ Query ข้อมูลต่อไปนี้
--1.ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ที่อยู่ในเมือง London
SELECT TitleOfCourtesy, FirstName, LastName
FROM Employees
WHERE City = 'London';

--2.ข้อมูล รหัสสินค้า ชื่อสินค้า ราคา จำนวน ของสินค้าที่มีจำนวนน้อยกว่า 30
SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
WHERE UnitsInStock < 30;

--3.รหัสลูกค้า ชื่อบริษัท เบอร์โทรศัพท์ ของลูกค้าที่อยู่ในประเทศต่อไปนี้
--    Sweden, Germany, France, Spain, UK
SELECT CustomerID, CompanyName, Phone
FROM Customers
WHERE Country IN ('Sweden', 'Germany', 'France', 'Spain', 'UK');

--4.ข้อมูลลูกค้าที่ไม่มีหมายเลขโทรสาร (Fax)
SELECT *
FROM Customers
WHERE Fax IS NULL;

--5.ข้อมูลสินค้าที่มีจำนวนสินค้าต่ำกว่าจุดสั่งซื้อ และ มีจำนวนที่สั่งซื้อแล้ว
SELECT *
FROM Products
WHERE UnitsInStock < ReorderLevel 
  AND UnitsOnOrder > 0;

--6.ชื่อ นามสกุล พนักงานที่เข้าทำงานในปี 1992
SELECT FirstName, LastName
FROM Employees
WHERE YEAR(HireDate) = 1992;

--7.ต้องการข้อมูลสินค้าที่มีราคาตั้งแต่ 20-70
SELECT *
FROM Products
WHERE UnitPrice BETWEEN 20 AND 70;

--8.ข้อมูลลูกค้าที่มีชื่อบริษัทขึ้นต้นด้วย S และอยู่ประเทศ Mexico
SELECT *
FROM Customers
WHERE CompanyName LIKE 'S%' 
  AND Country = 'Mexico';

--9.ข้อมูลลูกค้าที่มีตำเเหน่งของผู้ที่ประสานงานเป็น Manager 
SELECT *
FROM Customers
WHERE ContactTitle LIKE '%Manager%';


--Aggregate function
Select 
	count(*) as ProductCount,
	MIN(UnitPrice) as MinimumPrice,	MAX(UnitPrice) as MaximumPrice,	AVG(UnitPrice) as AveragePrice
	From dbo.Products

Select 
	count(*) as จำนวนชนิด,
	MIN(UnitPrice) as ราคาต่ำสุด,	MAX(UnitPrice) as ราคาสูงสุด,	AVG(UnitPrice) as ราคาเฉลี่ย, Sum(UnitPrice) as ราคารวมทั้งหมด
From dbo.Products

--ต้องการทราบว่าสินค้าเเต่ล่ะหมวดหมู่(CategoryID) มีสินค่ากี่ชนิด เเต่ล่ะชนิดมีราคาเฉลี่ย มีราคาสุงสุด เเละต่ำสุด
Select CategoryID, count(*) จำนวนชนิด, Avg(UnitPrice) ราคาเฉลี่ย, Max(UnitPrice) ราคราสูงสุด, Min(UnitPrice) ราคาต่ำสุด
from Products
Group by CategoryID

--ต้องการทราบข้อมูลว่าในเเต่ล่ะประเทศ (Country) มีลูกค้ากี่ราย (ถ้าทำได้เเล้วเพิ่ม city )
Select Country,city ,Count(*) จำนวนลูกค้า
from Customers
group by Country ,City
order by Count(*) DESC

--ต้องการทราบข้อมูลว่าในเเต่ล่ะประเทศ (Country) เเสดงเฉพาะที่มีจำนวนลูกค้า 10 รายขึ้นไป
Select Country, Count(*) จำนวนลูกค้า
from Customers
group by Country
having count(*) >=10

--ต้องการทราบว่าสินค้าที่มีมูลค่าสูง (ราคาตั้งเเต่ 75 ขึ้นไป) เเต่ล่ะหมวดหมู่มีจำนวนกี่ชนิด มีราคาเฉลี่ยเท่าใด
--ให้เเสดงเฉพาะสินค้ามี่มีราคาเฉลี่ย มากกว่า 200
Select categoryID, count(*) จำนวนชนิด, Avg(Unitprice) ราตาเฉลี่ย
from products
where UnitPrice >=75
group by CategoryID
having avg(unitprice) >200

--จากตาราง [Order Details] ให้รวบรวมว่าในเเต่ล่ะการสั่งซื้อ มียอดเงินรวมเท่าใด
Select orderID, UnitPrice, Quantity, Discount,
	UnitPrice * Quantity as ราคาเต็ม,
	UnitPrice * Quantity * Discount as ส่วนลด,
	(UnitPrice * Quantity) - (UnitPrice * Quantity * Discount) as ราคาหักส่วนลดเเล้ว,
	(UnitPrice * Quantity * (1- Discount)) as หักส่วนลดสูตรย่อ
from [Order Details]

--ต้องการเฉพาะใบสั่งซื้อที่มียอดกว่า 1000
Select orderID, count(*) จำนวนรายการ ,
	sum(UnitPrice * Quantity * (1- Discount)) as  ยอดเงินรวม
from [Order Details]
group by orderID
having sum(UnitPrice * Quantity * (1- Discount)) > 2000
order by 3 desc


