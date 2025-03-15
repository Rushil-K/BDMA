show databases;
use hospital_management;

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