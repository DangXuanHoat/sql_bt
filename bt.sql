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
VALUES (value1, value2, value3,...valueN);
INSERT INTO MUONSACH   
VALUES (value1, value2, value3,...valueN)