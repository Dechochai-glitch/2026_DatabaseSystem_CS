-- สำรวจข้อมูล Receipts, Details, Employee, Products
Select * from Receipts
Select * from Details
Select * from Employees
Select * from Products

-- เริ่มต้น Transaction
Begin Transaction
--1. เพิ่มใบเสร็จใหม่ Receipts ยังไม่มียอด TotalCash
Insert into Receipts(ReceiptDate, EmployeeID, TotalCash)
    Values(getdate(), 4, 0)

--2. เพิ่มรายการสินค้าใน Details 2 รายการ (ก่อนทำ เปิดดูรหัสใบเสร็จล่าสุด)  --6
insert into Details(ReceiptID, ProductID, UnitPrice, Quantity)
    Values(6, 1, 17, 5)   -- ดินสอ
insert into Details(ReceiptID, ProductID, UnitPrice, Quantity)
    Values(6, 2, 17, 4)   -- ยางลบ

--3. ปรับปรุงยอดขาย TotalCash
update Receipts set TotalCash = 
    (select sum(unitprice*quantity) from Details
    where ReceiptID = 6)
    where receiptID = 6

--4. ปรับปรุงจำนวนสินค้า ดินสอ -5 ยางลบ -4
update Products set UnitsInStock = UnitsInStock - 5 where productID = 1 --ดินสอ
update Products set UnitsInStock = UnitsInStock - 4 where productID = 2 --ยางลบ
--จบการทำงาน
commit

---------- ทดสอบ Rolll back -----------
-- เริ่มต้น Transaction
Begin Transaction
--1. เพิ่มใบเสร็จใหม่ Receipts ยังไม่มียอด TotalCash
Insert into Receipts(ReceiptDate, EmployeeID, TotalCash)
    Values(getdate(), 4, 0)

--2. เพิ่มรายการสินค้าใน Details 2 รายการ (ก่อนทำ เปิดดูรหัสใบเสร็จล่าสุด)  --6
insert into Details(ReceiptID, ProductID, UnitPrice, Quantity)
    Values(6, 1, 17, 5)   -- ดินสอ
insert into Details(ReceiptID, ProductID, UnitPrice, Quantity)
    Values(6, 2, 17, 4)   -- ยางลบ


    ----- ตรวจสอบข้อมูล
    select * from receipts where ReceiptID = 6
    select * from Details where ReceiptID = 6
