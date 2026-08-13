-- lab ในชั้นเรียน 13 สิงหาคม 2569
-- 1. ต้องการข้อมูล รหัสใบสั่งซื้อ ยอดเงินรวมที่หักส่วนลดเเล้ว จากเเต่ล่ะใบสั่งซื้อ ทั้งหมด เรียงลำดับตามยอดเงิน จากมากไปน้อย
SELECT OrderID, SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalCast
FROM [Order Details]
GROUP BY OrderID
ORDER BY TotalCast DESC;


-- 2. ต้องการชื่อประเทศ ของผู้เเทนจำหน่าย (sippliers) เเละจำนวนผู้เเทนจำหน่ายในเเต่ล่ะประเทศ
--	  เเสดงมาเฉพาะรายการที่ผู้เเทนจำหน่ายมีมากกว่า 1 ราย
SELECT Country, COUNT(SupplierID) AS SupplierCount
FROM Suppliers
GROUP BY Country
HAVING COUNT(SupplierID) > 1;


-- 3. รหัสสินค้า จำนวนรวมทั้งหมดที่ขายได้ ราคาสูงสุดที่ขายได้ ราคาต่ำสุดที่ขายได้
--    เเสดงเฉพาะสินค้าที่ขายได้รวมมากกว่า 1500 ชิ้น
SELECT ProductID,
    SUM(Quantity) AS TotalQuantity,
    MAX(UnitPrice) AS MaxPrice,
    MIN(UnitPrice) AS MinPrice
FROM [Order Details]
GROUP BY ProductID
HAVING SUM(Quantity) > 1500;


-- การ Query ข้อมูล จากหลายตาราง (Join Table)
Select * from Products
Select * from Categories
-- INNER JOIN
Select *
From Products Inner join Categories
    on Products.CategoryID = Categories.CategoryID
-- ต้องการรหัสหมวดหมู่ ชื่อหมวดหมู่สินค้า รหัสสินค้า ชื่อสินค้า ราตา
--      โดยเรียงลำตับตามหมวดหมู่สินค้า เเละราคาสุงไปต่ำ
Select products.CategoryID, CategoryName, ProductID, ProductName, UnitPrice
From Products Inner join Categories
    on Products.CategoryID = Categories.CategoryID
Order by CategoryID asc ,UnitPrice desc

Select p.CategoryID, CategoryName, ProductID, ProductName, UnitPrice
From Products as p Inner join Categories as c
    on P.CategoryID = C.CategoryID
Order by CategoryID asc ,UnitPrice desc

-- ต้องการชื่อผู้รับผิดชอบการสั่งซื้อเเต่ล่ะรายการ
Select * from Orders
Select * from Employees

-- รหัสใบสี่งซื้อ วันที่สั่งซื้อ วันทีี่รับสินค้า ประเทศปลายทาง ชื่อ-นามสกุลพนักงานผู้รับผิดชอบ
Select o.OrderID, o.OrderDate, o.ShippedDate, o.ShipCountry, e.FirstName + space(2) + e.LastName SaleMan
From Orders o inner join Employees e on o.EmployeeID = e.EmployeeID

--ต้องการรหัสหมวดหมู่สินค้า รหัสสิน ค้าชื่อสินค้า ราคา ประเทศที่มา
--โดยเรียงลำดับตามหมวดหมู่สินค้า และราคาสูงไปต่ำ และสิงค้ามาจากประเทศ USA,Mexico,Canada
Select c.CategoryID, c.CategoryName, p.ProductID, p.ProductName, p.UnitPrice, s.Country
from Products p inner join Categories c on p.CategoryID = c.CategoryID
                inner join Suppliers s on p.SupplierID = s.SupplierID
Where s.Country in ('USA','Mexico','canada')
Order by Country

select * from Products
select * from Categories
select * from Suppliers

--แบบฝึกหัดการ Join ตาราง
-- 1. ต้องการ รหัสบริษัทขนส่ง, ชื่อบริษัทขนส่ง, จำนวนใบสังซื้อที่เกี่ยวข้อง, ยอดรวมค่าขนส่ง
Select  s.ShipperID, s.CompanyName, 
        COUNT(*) TotelOrder,  SUM(o.Freight) sumfright
From  Shippers s INNER JOIN  Orders o ON s.ShipperID = o.ShipVia
Group by s.ShipperID, CompanyName;

-- 2. รหัสใบสั่งชื่อ วันที่สังซือ ซือบริษัทลกค้า ให้แสดงเฉพาะ ลกค้าทีอยในประเทศ USA
Select OrderID, format(o.OrderDate,'d','en-gb') as [order date],c.CompanyName
from Orders o join customers c on o.CustomerID = c.CustomerID
where c.Country = 'USA'

-- 3. รหัสพนักงาน ชื่อนามสกุล จำนวนใบสั่งซื้อที่เกี่ย
Select e.EmployeeID , firstName + space(2) + lastname EmployeeName,
       count(*) TotalOrders
from Employees e join orders o on e.EmployeeID = o.EmployeeID
group by e.EmployeeID , firstName + space(2) + lastname

-- 4. รหัสใบสั่งซื้อ วันที่สั่งซื่อ ชื่อพนักงาน ชื่อบริษัทลุกค้า ชื่อบริษัทขนส่ง
--    ยอดรวมในใบสั่งซื้อ เฉพาะรายการทีขายในปี 1997 เรียงตามลำดับ ยอดเงินจากมากไปน้อย
Select o.OrderID, format(o.OrderDate,'d','en-gb') as [order date],
       firstName EmployeeName, c.CompanyName CustomerCompany,
       s.CompanyName ShipperCompany,
       SUM(od.UnitPrice * od.Quantity * (1 - od.Discount)) AS totalCash
from orders o inner join Employees e on o.EmployeeID = e.EmployeeID
              inner join customers c on o.CustomerID = c.CustomerID
              inner join [Order Details] od on o.OrderID = od.OrderID
              inner join Shippers s on o.ShipVia = s.ShipperID
WHERE YEAR(o.OrderDate) = 1997
group by o.OrderID, 
         FORMAT(o.OrderDate, 'd', 'en-gb'),
         e.FirstName, 
         c.CompanyName, 
         s.CompanyName
ORDER BY totalCash DESC;

-- ต้องการ รหัสสินค้า ชื่อสินค้า จำนวนที่ขายได้ เฉพาะสินค้าที่ขายดีที่สุด 5 อันดับเเรก ในปี 1997
Select top 5 p.ProductID, p.ProductName, SUM(od.Quantity)TotalQuantity
From Products p inner join [Order Details] od ON p.ProductID = od.ProductID
                inner join Orders o ON od.OrderID = o.OrderID
where year(orderdate) = 1997
group by p.ProductID,p.ProductName
order by 3 desc

-- ข้อมุล ชื่อบริษัทลูกค้า เเละประเทศลูกค้า ที่ซื้อสินค้าที่มาจากบริษัทชื่อ Exotic Liquids
SELECT DISTINCT c.CompanyName, c.Country
FROM Suppliers s inner join Products p ON s.SupplierID = p.SupplierID
                 inner join [Order Details] od ON p.ProductID = od.ProductID
                 inner join Orders o ON od.OrderID = o.OrderID
                 inner join Customers c ON o.CustomerID = c.CustomerID
WHERE  s.CompanyName = 'Exotic Liquids';


-- ข้อมูลบริษัทลูกค้าที่ซื้อสินค้าหมวดหมู่ Seafood
SELECT DISTINCT c.CustomerID ,c.CompanyName ,c.ContactName ,c.Country 
FROM Categories cat inner join Products p ON cat.CategoryID = p.CategoryID
                    inner join [Order Details] od ON p.ProductID = od.ProductID
                    inner join Orders o ON od.OrderID = o.OrderID
                    inner join Customers c ON o.CustomerID = c.CustomerID
WHERE cat.CategoryName = 'Seafood';


-- Sub Query (Query ซ้อนกัน)
-- ชื่อพนักงานที่มีตำแหน่งเดียวกับ Nancy (nancy ตำแหน่งอะไร)
Select FirstName
from Employees
where title = (select title from Employees where FirstName = 'nancy')

-- ชื่อพนักงานที่มีอยุน้อยกว่า Robert (Robert เกิดเมื่อใด)
Select FirstName
from Employees
where BirthDate > (select birthdate from Employees where FirstName = 'robert')

-- รหัสสินค้า ชื่อสินค้า ที่มีราคาสูงกว่าค่าเฉลี่ยทั้งหมดของราคาสินค้า (ค่าเฉลี่ยของราคาสินค้าคืออะไร)
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice > (SELECT AVG(UnitPrice) FROM Products);

-- ชื่อ นามสกุล พนักงานที่อายุมากที่สุด
SELECT TOP 1 FirstName, LastName
FROM Employees
ORDER BY BirthDate ASC;

-- ชื่อนามสกุล พนักงานที่เข้างานหลังสุด
SELECT TOP 1 FirstName, LastName
FROM Employees
ORDER BY HireDate DESC;