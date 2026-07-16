--เริ่มจาก Master สร้างฐานข้อมูลชื่อ
Create Database CSMinimart
--ปรับให้ฐานข้อมูลสามารถเพิ่มข้อมูลที่เป็นภาษาไทยได้
Alter Database CSMinimart Collate Tahi_CI_AS;
--เปลี่ยนฐานข้อมูลไปใช้ CSMinimart เปลี่ยนแถบเมนู
--สร้างตารางเก็บข้อมูลพนักงาน ชื่อ Empoyees
Create Table employees(
	EmployeeID int identity(1,1) Primary key,
	title varchar(20) null, -- null ใส่ก็ได้ไม่ใส่ก็ได้ตรงนี้ 
	firstname varchar(50) not null,
	lastname varchar(50) null,
	position varchar(50) null,
	usernamme varchar(50) Unique,
	passwordhash varchar(255) not null,
	IsActive bit Not null default 1
)
