/* cau 1 */
CREATE TABLE SACH(
   Masach   TEXT(5) NOT NULL,
   Tensach TEXT (50)    NOT NULL,
   Namxb  NUMERIC   NOT NULL,
   Nhaxb  TEXT (50) NOT NULL ,       
   PRIMARY KEY (Masach);
);
CREATE TABLE SINHVIEN(
   Masv   TEXT(5) NOT NULL,
   Hoten TEXT (50)    NOT NULL,
   Ngaysinh  NUMERIC   NOT NULL,
   Gioitinh  TEXT (50) NOT NULL , 
   Diachi  TEXT (50) NOT NULL .      
   PRIMARY KEY (Masv);
);
CREATE TABLE MUONSACH(
   Masach   TEXT(5) NOT NULL,
   Masv   TEXT(5) NOT NULL,
   Ngaymuon DATETIME    NOT NULL,
   Ngaytra  DATETIME   NOT NULL,
   Quanlythuvien  TEXT (50) NOT NULL ,       
   PRIMARY KEY (Masach,Masv);
);

/* cau 2 */
ALTER TABLE MUONSACH ADD FOREIGN KEY (Masach) REFERENCES SACH(Masach);
ALTER TABLE MUONSACH ADD FOREIGN KEY (Masv) REFERENCES SINHVIEN(Masv);

/*Cau 3*/
INSERT INTO SACH   
VALUES ("Ms01", "Tin hoc dai cuong",2013,"Dai hoc bach khoa Ha Noi"),
("Ms02","Dai so tuyen tinh",2010,"Dai hoc Su pham"); 
INSERT INTO SINHVIEN   
VALUES ("Sv1", "Pham Quynh Như",'12/12/1996', "Nu","Van Lam Hung Yen"),("Sv1", "Pham Quynh Như",'12/12/1996', "Nu","Van Lam Hung Yen"),("Sv1", "Pham Quynh Như",'12/12/1996', "Nu","Van Lam Hung Yen");
INSERT INTO MUONSACH   
VALUES ("Ms01", "SV02", '12//12/2015','12/30/2015',"PHam Hong Thai"),("Ms01", "SV02", '12//12/2015','12/30/2015',"PHam Hong Thai"),("Ms01", "SV02", '12//12/2015','12/30/2015',"PHam Hong Thai");


/* A */
-- 1
ALTER TABLE SACH
ADD TG nchar(30);
-- 2
ALTER TABLE SACH
MODIFY COLUMN TG nvarchar(30);
--3
sp_rename 'SACH.TG', 'Tác Giả', 'COLUMN';
--4
ALTER TABLE ten_bang
DROP COLUMN Tác Giả;
ALTER TABLE ten_bang
DROP COLUMN Namxb;
--5 
/* Như câu 3 tự thêm */
/* B */
--6
SELECT *  /* Trả toàn bộ các cột*/
FROM SINHVIEN
ORDER BY Ngaysinh,Diachi ASC; /* giảm dần dùng DESC*/
--7
SELECT *  
FROM SACH
ORDER BY Nhaxb ASC ,Tensach DESC;
--8
SELECT Hoten,Gioitinh,Diachi
FROM SINHVIEN
WHERE Gioitinh = 'Nu' AND Diachi LIKE '% Hà Nội%';
--9
SELECT *  
FROM SINHVIEN
WHERE Ngaysinh > '1997-01-01'
OR Gioitinh ="Nam" 

-- Đưa ra thông tin về các bạn mượn sách ngày 11/12/2015 và do Phạm Hồng
-- Thái quản lý
SELECT *
FROM SINHVIEN
INNER JOIN MUONSACH
ON SINHVIEN.Gioitinh = "Nam" AND SINHVIEN.Masv = MUONSACH.Masv AND MUONSACH.Quanlythuvien = "Phạm Hồng Thái";

-- Đưa ra thông tin về tình trạng mượn trả sách của bạn Phan Huy Tùng. Thông tin hiển thị gồm Họ tên, Tên sách, Ngày mượn, Ngày trả
SELECT SINHVIEN.Hoten AS Họ Tên,SACH.Tensach AS Tên Sách,MUONSACH.Ngaymuon AS Ngày Mượn,MUONSACH.Ngaytra AS Ngày Trả
FROM MUONSACH
INNER JOIN MUONSACH,SACH
ON SINHVIEN.Hoten = "Phan Huy Tùng" AND SINHVIEN.Masv = MUONSACH.Masv AND SACH.Masach = MUONSACH.Masach ;
-- Đưa ra số lượng các bạn sinh viên Nữ
SELECT COUNT(*)
  FROM SINHVIEN
  WHERE Gioitinh ='Nữ';
-- Đưa ra năm xuất bản lớn nhất, nhỏ nhất
SELECT MAX(Namxb)
FROM SACH; 
SELECT MIN(Namxb)
FROM SACH; 
-- Đưa ra danh sách các bạn sinh viên mượn sách và số lần mượn sách của
-- từng bạn. Thông tin đưa ra gồm: Họ tên, số lần mượn trả sách
SELECT SINHVIEN.Hoten AS Họ tên, COUNT(*) AS Số lần mượn trả sách
  FROM SINHVIEN
  WHERE Gioitinh ='Nữ';
-- Đưa ra số lượt mượn trả sách của từng sách. Thông tin đưa ra gồm : Mã
-- sách, Tên sách, Năm xuất bản, Số lượt mượn trả
SELECT   SACH.Masach AS Mã Sách,
         SACH.Tensach AS Tên sách,
         SACH.Namxb AS Năm xuất bản,
         COUNT(MUONSACH.Ngaymuon)+COUNT(MUONSACH.Ngaytra) AS Số lượt mượn trả
         COUNT(MUONSACH.Ngaymuon) AS Lần Mượn,
         COUNT(MUONSACH.Ngaytra) AS Lần Trả
FROM MUONSACH
INNER JOIN SACH
ON MUONSACH.Masach =  SACH.Masach;

-- Đưa ra danh sách các bạn sinh viên mượn trả sách hơn 2 lần. Thông tin
-- hiển thị bao gồm: Mã sinh viên, họ tên, giới tính, số lượt mượn trả sách
SELECT   MUONSACH.Masv AS Mã Sinh Viên,SINHVIEN.Hoten AS họ tên,
         SINHVIEN.Gioitinh AS giới tính,
         COUNT(MUONSACH.Ngaymuon) AS Lần Mượn,
         COUNT(MUONSACH.Ngaytra) AS Lần Trả
FROM MUONSACH
INNER JOIN SINHVIEN
ON (COUNT(MUONSACH.Ngaymuon) > 2 OR COUNT(MUONSACH.Ngaytra) > 2) AND MUONSACH.Masv  =  SINHVIEN.Masv;

-- Đưa ra danh sách các sách được mượn hơn 1. Thông tin đưa ra gồm: Mã
-- sách, Tên sách, Số lần mượn trả.
SELECT   SACH.Masach AS Mã Sách,
         SACH.Tensach AS Tên sách,
         COUNT(MUONSACH.Ngaymuon) AS Lần Mượn,
         COUNT(MUONSACH.Ngaytra) AS Lần Trả
FROM MUONSACH
INNER JOIN SACH
ON (COUNT(MUONSACH.Ngaymuon) > 1 OR COUNT(MUONSACH.Ngaytra) > 1) AND MUONSACH.Masach =  SACH.Masach;
--  Liệt kê danh sách các tên sách bắt đầu bằng chữ T
SELECT *
FROM SACH
WHERE SACH.Tensach LIKE 'T%';
--  Liệt kê danh sách các sinh viên là nữ ( dấu x)
SELECT *
FROM SINHVIEN
WHERE SINHVIEN.Gioitinh = 'Nữ';
-- Đếm số sinh viên là nữ
SELECT COUNT(Gioitinh)
FROM SINHVIEN
WHERE SINHVIEN.Gioitinh = 'Nữ';
--  Tạo bảng mới chứa dữ liệu chèn vào gồm họ và tên, tuổi, địa chỉ của sinh viên

-- Chèn thêm cột số ngày mượn vào bảng mượn sách và để mặc định kiểu int
ALTER TABLE MUONSACH
ADD SoNgayMuon INT(5);
-- Cập nhật dữ liệu vào  số cột ngày mượn trong bảng mượn sách: ngày trả- ngày mượn
UPDATE MUONSACH
SET Ngaymuon = DATEDIFF(month, MUONSACH.Ngaymuon, MUONSACH.Ngaytra) 
WHERE *
-- Hãy cho biết những sinh viên mượn sách vào ngày 11/12/2015
SELECT SINHVIEN.Hoten 
FROM SINHVIEN
INNER JOIN MUONSACH,SACH
ON MUONSACH.Ngay\ = "11/12/2015" AND SINHVIEN.Masv = MUONSACH.Masv;
-- Hãy cho biết họ và tên những sinh viên có quản lý thư viên là Phạm Hồng Thái
SELECT SINHVIEN.Hoten 
FROM SINHVIEN
INNER JOIN MUONSACH,SACH
ON MUONSACH.Quanlythuvien = "Phạm Hồng Thái" AND SINHVIEN.Masv = MUONSACH.Masv;
-- Hãy cho biết có bao nhiêu sinh viên có quản lý thư viên là Phạm Hồng Thái
SELECT COUNT(SINHVIEN.Hoten)AS Số sinh viên có quản lý thư viên là Phạm Hồng Thái
FROM SINHVIEN
INNER JOIN MUONSACH,SACH
ON MUONSACH.Quanlythuvien = "Phạm Hồng Thái" AND SINHVIEN.Masv = MUONSACH.Masv;
-- Hãy đưa ra tên sách mà sv07 mượn
SELECT SACH.Tensach
FROM SACH
INNER JOIN MUONSACH,SINHVIEN
ON MUONSACH.Quanlythuvien = "Phạm Hồng Thái" AND SINHVIEN.Masv = MUONSACH.Masv AND MUONSACH.Masv = 'sv07';
-- Mã sách ms01 có bao nhiêu sinh viên mượn
SELECT COUNT(MUONSACH.Masv)
FROM MUONSACH
WHERE MUONSACH.Masach = "ms01"
-- Những sinh viên đã mượn mã sách ms01
SELECT * 
FROM SINHVIEN
INNER JOIN MUONSACH
ON MUONSACH.Masach = "ms01" AND SINHVIEN.Masv = MUONSACH.Masv;
-- Có bao nhiêu sinh viên đã mượn mã sách ms01 và được quản lý bởi Phạm Hồng Thái
SELECT COUNT(SINHVIEN.Masv) 
FROM SINHVIEN
INNER JOIN MUONSACH
ON MUONSACH.Masach = "ms01" AND SINHVIEN.Masv = MUONSACH.Masv;
-- Hãy đếm xem có bao nhiêu sinh viên có họ nguyễn
SELECT *
FROM SINHVIEN
WHERE SINHVIEN.Hoten  LIKE 'Nguyễn %'
-- Hãy đưa ra những sinh viên không có họ nguyễn
SELECT *
FROM SINHVIEN
WHERE SINHVIEN.Hoten NOT LIKE 'Nguyễn %'
-- Hãy đưa ra những sinh viên sinh năm 1997 và có giới tính là nữ
SELECT *
FROM SINHVIEN
WHERE SINHVIEN.Ngaysinh = 1997 AND SINHVIEN.Gioitinh = "Nữ"
-- Hãy liệt kê những đầu sách có năm xuất bản là 2008
SELECT *
FROM SACH
WHERE SACH.Namxb = 2008
-- Thay đổi địa chỉ của tất cả những sinh viên sinh năm 1995 thành Hà Nội






