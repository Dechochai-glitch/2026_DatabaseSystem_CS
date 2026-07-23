--สำรวจรายชื่อตาราง
SELECT *
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
--สำรวจโครงสร้าง
EXEC sp_help 'employees';

--คำสั่ง Select เบื่องต้น
--ต้องการข้อมูลสินค้า
select * from Products
--ต้องการ รหัสสินค้า ชื่อสินค้า ราคา
Select ProductID, ProductName, Unitprice from Products
---- Alias Name = ชื่อเล่น
Select ProductID as รหัส, ProductName as ชื่อสินค้า, Unitprice as ราคา
from Products
--ใช้ Distinct สำหรับกำจัดข้อมูลที่ซ้ำกัน
Select Distinct Position from Employees
--ใช้	 Top(n) สำหรับเเสดงข้อมูล n รายการ
Select top(3) ProductID, ProductName, Unitprice
from Products
--ปรับปรุงราคาสินค้า"ดินสอ"
Update products
set UnitPrice = 20, UnitsInStock = 100
Where ProductName = 'ดินสอ'
-- ดูข้อมูลหลังปรับ
Select *from products

--ปรับปรุงจำนนวนคงเหลือของน้ำส้ม เพิ่มจากเดิมอีก100ชิ้น
Update products
set UnitsInStock = UnitsInStock + 100
Where ProductName = 'น้ำส้ม'
--ปรับราคาเเซมพุ ลด5บาท
Update products
set UnitPrice = UnitPrice - 5
Where ProductName = 'เเซมพู'
-- ดูข้อมูลหลังปรับ
Select *from products

-- ลบข้อมูลออกจากระบบ
DELETE FROM dbo.Products
WHERE ProductID = N'P'

-- การใช้ Where ในคำสั่ง select
Select * from Products
Where UnitPrice <20

--ชื่อ นามสกุล พนักงาน ที่มีตำเเหน่ง 'Sale maneger'
Select FirstName, LastName
from Employees
Where Position = 'Sale manager'

--รหัส ชื่อสินค้า ที่เลิกจำหน่ายเเล้ว ( discontinue = 1 )
Select ProductID, ProductName
from Products
Where Discontinued = 1

-- คำสั่ง and,or,not
SELECT *
FROM dbo.Products
WHERE UnitPrice >= 10
AND UnitsInStock < 100;

SELECT *
FROM dbo.Products
WHERE CategoryID = 2
OR CategoryID = 4;

SELECT *
FROM dbo.Products
WHERE NOT Discontinued = 1;

--ต้องการข้อมูลสินค้าจำนวนคงเหลือ 300-500 ชิ้น
Select * from Products
Where UnitsInStock between 300 and 500;

--การใช้เงื่อนไขร่วมกับ WildCard %
--ต้องการข้อมูลพนักงานที่มีขึ้นต้นด้วย ก
Select * from Employees
Where fristname like 'ก%'
--ต้องการข้อมูลพนักงานที่มีนามสกุลลงท้ายด้วย "คำ"
Select * from Employees
Where Lastname like 'คำ%'

--เตรียมข้อมูลใช้กับคำสั่ง is Null
insert into Employees(FirstName, UserName, Password)
values ('ไอซ์','ice','1234'), ('บาส','bass','1234')

--ข้อมูลพนักงานที่ไม่ทราบนามสกุล
Select * from Employees
Where LastName is null

--ปรับปรุงข้อมูลทดสอบช่องว่าง
update Employees set LastName = ''
Where FirstName = 'บาส'

--ปัญหาเบื่องต้นจากค่า Null 
Select FirstName+' '+LastName as ชื่อพนักงาน
from Employees

--ต้องการข้อมุลใบเสร็จที่ขายสินค้าก่อนวันที่ 10 กพ. 2013
select * from Receipts
Where ReceiptDate < '2013-02-10'

--บางกรณีใช้ Function Year() หรือ Month() ร่วมกับเงื่อนไขได้
--ต้องการข้อมูลใบเสร็จที่ขายสินค้า
Select * from Receipts
Where Year(ReceiptDate) = 2013
and Month(ReceiptDate) = 02

--ต้องการข้อมูลใบเสร็จ อันใหม่ที่สุดขึ้นก่อน
Select * from Receipts
order by ReceiptDate desc
