CREATE DATABASE hospital_management;
USE hospital_management;

CREATE TABLE Patients (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Blood_Type VARCHAR(3),
    Insurance_Provider VARCHAR(100),
    Insurance_Number VARCHAR(50)
);

CREATE TABLE Patient_Addresses (
    Address_ID INT PRIMARY KEY,
    Patient_ID INT,
    Address_Line1 VARCHAR(255),
    Address_Line2 VARCHAR(255),
    City VARCHAR(100),
    State VARCHAR(100),
    ZIP_Code VARCHAR(10),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Specialization VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Experience_Years INT,
    Department_ID INT
);

CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Appointment_Date DATE,
    Appointment_Time TIME,
    Status VARCHAR(50),
    Reason VARCHAR(255),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE Medical_Records (
    Record_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Record_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE Diagnosis (
    Diagnosis_ID INT PRIMARY KEY,
    Record_ID INT,
    Diagnosis_Details TEXT,
    Prescription TEXT,
    FOREIGN KEY (Record_ID) REFERENCES Medical_Records(Record_ID)
);

CREATE TABLE Billing (
    Bill_ID INT PRIMARY KEY,
    Patient_ID INT,
    Total_Amount DECIMAL(10,2),
    Bill_Date DATE,
    Payment_Status VARCHAR(50),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

CREATE TABLE Payment_Details (
    Payment_ID INT PRIMARY KEY,
    Bill_ID INT,
    Amount_Paid DECIMAL(10,2),
    Payment_Date DATE,
    Payment_Mode VARCHAR(50),
    FOREIGN KEY (Bill_ID) REFERENCES Billing(Bill_ID)
);

CREATE TABLE Staff (
    Staff_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Role VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Department_ID INT,
    Salary DECIMAL(10,2),
    Shift_Timings VARCHAR(50)
);

CREATE TABLE Rooms (
    Room_ID INT PRIMARY KEY,
    Room_Type VARCHAR(50),
    Capacity INT,
    Occupied_Status VARCHAR(50)
);

CREATE TABLE Admissions (
    Admission_ID INT PRIMARY KEY,
    Patient_ID INT,
    Room_ID INT,
    Admission_Date DATE,
    Discharge_Date DATE,
    Diagnosis TEXT,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

CREATE TABLE Inventory (
    Item_ID INT PRIMARY KEY,
    Item_Name VARCHAR(100),
    Category VARCHAR(100),
    Quantity INT,
    Supplier_ID INT,
    Purchase_Date DATE
);

CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY,
    Supplier_Name VARCHAR(100),
    Contact_Number VARCHAR(15),
    Email VARCHAR(100),
    Address TEXT,
    Category_Provided VARCHAR(100)
);

CREATE TABLE Tests (
    Test_ID INT PRIMARY KEY,
    Test_Name VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10,2)
);

CREATE TABLE Lab_Reports (
    Report_ID INT PRIMARY KEY,
    Patient_ID INT,
    Doctor_ID INT,
    Report_Date DATE,
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

CREATE TABLE Test_Results (
    Result_ID INT PRIMARY KEY,
    Report_ID INT,
    Test_ID INT,
    Results TEXT,
    FOREIGN KEY (Report_ID) REFERENCES Lab_Reports(Report_ID),
    FOREIGN KEY (Test_ID) REFERENCES Tests(Test_ID)
);

CREATE TABLE Pharmacy (
    Medicine_ID INT PRIMARY KEY,
    Medicine_Name VARCHAR(100),
    Category VARCHAR(100),
    Price DECIMAL(10,2)
);

CREATE TABLE Stock (
    Stock_ID INT PRIMARY KEY,
    Medicine_ID INT,
    Quantity_Available INT,
    Expiry_Date DATE,
    FOREIGN KEY (Medicine_ID) REFERENCES Pharmacy(Medicine_ID)
);
