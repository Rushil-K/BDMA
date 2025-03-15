show databases;
use hospital_management;
show tables;

-- Stresstesting for 1NF (1st Normal Form)
-- To check if a table follows First Normal Form (1NF) in SQL, you need to ensure that:
-- 1. Each column contains atomic values (no multiple values in a single column).
-- 2. Each row has a unique identifier (a primary key is defined).
-- 3. All columns store only single-valued attributes (no repeating groups or arrays).

-- Check for Multi-Valued Attributes
SELECT * FROM Patients 
WHERE Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%' 
   OR Insurance_Provider LIKE '%,%';
   
SELECT * FROM Patient_Addresses 
WHERE Address_Line1 LIKE '%,%' 
   OR Address_Line2 LIKE '%,%';

SELECT * FROM Doctors 
WHERE Specialization LIKE '%,%' 
   OR Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%';

SELECT * FROM Appointments 
WHERE Status LIKE '%,%' 
   OR Reason LIKE '%,%';

SELECT * FROM Medical_Records 
WHERE Record_ID IN (
    SELECT Record_ID FROM Diagnosis 
    GROUP BY Record_ID HAVING COUNT(Diagnosis_ID) > 1
);

SELECT * FROM Billing 
WHERE Payment_Status LIKE '%,%';

SELECT * FROM Payment_Details 
WHERE Payment_Mode LIKE '%,%';

SELECT * FROM Staff 
WHERE Role LIKE '%,%' 
   OR Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%' 
   OR Shift_Timings LIKE '%,%';

SELECT * FROM Rooms 
WHERE Room_Type LIKE '%,%';

SELECT * FROM Admissions 
WHERE Diagnosis LIKE '%,%';

SELECT * FROM Inventory 
WHERE Item_Name LIKE '%,%' 
   OR Category LIKE '%,%';

SELECT * FROM Suppliers 
WHERE Supplier_Name LIKE '%,%' 
   OR Contact_Number LIKE '%,%' 
   OR Email LIKE '%,%' 
   OR Category_Provided LIKE '%,%';

SELECT * FROM Lab_Reports 
WHERE Report_ID IN (
    SELECT Report_ID FROM Test_Results 
    GROUP BY Report_ID HAVING COUNT(Test_ID) > 1
);

SELECT * FROM Pharmacy 
WHERE Medicine_Name LIKE '%,%' 
   OR Category LIKE '%,%';

SELECT * FROM Stock 
WHERE Quantity_Available LIKE '%,%';

-- no column in any table contains multiple values separated by comma, so, 1NF is not violated. 



-- Check for Missing Primary Keys
SELECT TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_SCHEMA = 'hospital_management' 
AND TABLE_NAME NOT IN (
    SELECT DISTINCT TABLE_NAME 
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE CONSTRAINT_NAME = 'PRIMARY'
);
-- There are no tables with missing primary keys, so, 1NF is not violated.


-- Check for Repeating Groups
SELECT COLUMN_NAME, TABLE_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'hospital_management'
AND COLUMN_NAME REGEXP '_[0-9]$';
-- As no column names end with _1, _2, _3, etc., 1NF is not violated.

-- As, all checks for 1NF found that, 1NF is not violated, hence we can conclude that our database - Hospital Management - is 1NF compliant.