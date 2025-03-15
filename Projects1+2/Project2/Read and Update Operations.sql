show databases;
use hospital_management;

-- This file contains 2 type of queries:-
-- 1. Retrieval and Analyse Queries
-- 2. Updation Queries

-- 1. Retrieval and Analyse Queries

-- Retrieve all patient details
SELECT * FROM Patients;

-- Get all doctors and their specializations
SELECT First_Name, Last_Name, Specialization FROM Doctors;

-- Find all appointments scheduled on a specific date
SELECT * FROM Appointments WHERE Appointment_Date = '2024-02-16';

-- Find all unavailable (occupied) rooms
SELECT * FROM Rooms WHERE Occupied_Status = 'Occupied';

-- Get patient details along with their address
SELECT P.Patient_ID, P.First_Name, P.Last_Name, A.Address_Line1, A.City, A.State, A.ZIP_Code
FROM Patients P
JOIN Patient_Addresses A ON P.Patient_ID = A.Patient_ID;

-- Find appointments for a specific doctor
SELECT A.Appointment_ID, P.First_Name AS Patient_Name, A.Appointment_Date, A.Appointment_Time
FROM Appointments A
JOIN Patients P ON A.Patient_ID = P.Patient_ID
WHERE A.Doctor_ID = 15;

-- Count total patients in the hospital
SELECT COUNT(*) AS Total_Patients FROM Patients;

-- Find total revenue generated from billing
SELECT SUM(Total_Amount) AS Total_Revenue FROM Billing;

-- Get the frequenc of diagnosed diseases
SELECT Diagnosis_Details, COUNT(*) AS Frequency
FROM Diagnosis
GROUP BY Diagnosis_Details
ORDER BY Frequency DESC;

-- Find doctors with more than 5 years of experience
SELECT Doctor_ID, First_Name, Last_Name, Specialization, Experience_Years
FROM Doctors
WHERE Experience_Years > 5;

-- Get patients who have unpaid bills
SELECT P.Patient_ID, P.First_Name, P.Last_Name, B.Total_Amount, B.Payment_Status
FROM Patients P
JOIN Billing B ON P.Patient_ID = B.Patient_ID
WHERE B.Payment_Status = 'Unpaid';

-- Find total revenue from a specific department
SELECT D.Department_ID, D.Specialization, SUM(B.Total_Amount) AS Total_Revenue
FROM Doctors D
JOIN Appointments A ON D.Doctor_ID = A.Doctor_ID
JOIN Billing B ON A.Patient_ID = B.Patient_ID
WHERE D.Department_ID = 112
GROUP BY D.Department_ID, D.Specialization;

-- Find average hospital stay duration per patient
SELECT P.Patient_ID, P.First_Name, P.Last_Name, 
       AVG(DATEDIFF(A.Discharge_Date, A.Admission_Date)) AS Avg_Stay_Days
FROM Patients P
JOIN Admissions A ON P.Patient_ID = A.Patient_ID
GROUP BY P.Patient_ID, P.First_Name, P.Last_Name
ORDER BY Avg_Stay_Days DESC;

-- Find patients who had the highest medical expenses
SELECT P.Patient_ID, P.First_Name, P.Last_Name, SUM(B.Total_Amount) AS Total_Billed
FROM Patients P
JOIN Billing B ON P.Patient_ID = B.Patient_ID
GROUP BY P.Patient_ID, P.First_Name, P.Last_Name
ORDER BY Total_Billed DESC
LIMIT 5;

-- Find peak hospital admission hours
SELECT HOUR(Appointment_Time) AS Hour_Of_Day, COUNT(*) AS Total_Admissions
FROM Appointments
GROUP BY Hour_Of_Day
ORDER BY Total_Admissions DESC;

-- Get a List of All Inventory Items with Their Suppliers
SELECT I.Item_ID, I.Item_Name, I.Category, I.Quantity, 
       S.Supplier_Name, S.Contact_Number, S.Email
FROM Inventory I
JOIN Suppliers S ON I.Supplier_ID = S.Supplier_ID;

-- Find Patients Who Had an Abnormal Test Result
SELECT L.Patient_ID, TR.Test_ID, T.Test_Name, TR.Results
FROM Lab_Reports L
JOIN Test_Results TR ON L.Report_ID = TR.Report_ID
JOIN Tests T ON TR.Test_ID = T.Test_ID
WHERE TR.Results LIKE '%abnormal%' OR TR.Results LIKE '%elevated%' OR TR.Results LIKE '%tumor%' OR TR.Results LIKE '%fracture%';

-- Find the Earliest and Latest Test Conducted
SELECT MIN(Report_Date) AS Earliest_Test, MAX(Report_Date) AS Latest_Test
FROM Lab_Reports;

-- Find the Supplier Providing the Highest Quantity of Items
SELECT S.Supplier_Name, SUM(I.Quantity) AS Total_Quantity
FROM Inventory I
JOIN Suppliers S ON I.Supplier_ID = S.Supplier_ID
GROUP BY S.Supplier_Name
ORDER BY Total_Quantity DESC
LIMIT 1;

-- Find the Monthly Revenue from Tests Conducted
SELECT DATE_FORMAT(L.Report_Date, '%Y-%m') AS Month, SUM(T.Price) AS Total_Revenue
FROM Lab_Reports L
JOIN Test_Results TR ON L.Report_ID = TR.Report_ID
JOIN Tests T ON TR.Test_ID = T.Test_ID
GROUP BY Month
ORDER BY Month DESC;

-- Identify the Top 3 Most Profitable Tests
SELECT T.Test_Name, SUM(T.Price) AS Total_Profit
FROM Test_Results TR
JOIN Tests T ON TR.Test_ID = T.Test_ID
GROUP BY T.Test_Name
ORDER BY Total_Profit DESC
LIMIT 3;


-- 2. Updation Queries

-- Update Patient Details
UPDATE Patients 
SET Contact_Number = '9998887776', Email = 'amit.updated@email.com' 
WHERE Patient_ID = 1;
select * from Patients;

-- Change a Doctor's Email
UPDATE Doctors 
SET Email = 'rohan.verma@newmail.com' 
WHERE Doctor_ID = 3;
select * from Doctors;

-- Change Appointment Status
UPDATE Appointments 
SET Status = 'Cancelled' 
WHERE Appointment_ID = 5;
select * from Appointments;

-- Increase Doctor's Experience by 2 Years
UPDATE Doctors 
SET Experience_Years = Experience_Years + 2 
WHERE Specialization = 'Cardiology';
select * from Doctors;

-- Update Billing Status Based on Amount Paid
UPDATE Billing 
SET Payment_Status = 'Paid' 
WHERE Bill_ID IN (
    SELECT Bill_ID FROM Payment_Details WHERE Amount_Paid >= Total_Amount
);
select * from Billing;

-- Apply a Discount to Unpaid Bills Above ₹500
UPDATE Billing 
SET Total_Amount = Total_Amount * 0.9 
WHERE Total_Amount > 500 AND Payment_Status = 'Unpaid';
select * from Billing;

-- Auto-Assign Doctors to Unassigned Appointments
UPDATE Appointments 
SET Doctor_ID = (
    SELECT Doctor_ID FROM Doctors 
    WHERE Specialization = 'General Surgery' 
    ORDER BY Experience_Years DESC LIMIT 1
) 
WHERE Doctor_ID IS NULL;

-- Adjust Staff Salaries Based on Performance
UPDATE Staff 
SET Salary = CASE 
    WHEN Role = 'Doctor' THEN Salary * 1.15 
    WHEN Role = 'Nurse' THEN Salary * 1.10 
    WHEN Role = 'Administrator' THEN Salary * 1.05 
    ELSE Salary * 1.02 
END;