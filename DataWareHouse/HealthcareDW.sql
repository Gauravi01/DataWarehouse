use HealthcareDW;

CREATE TABLE DimPatient (
    PatientID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DOB DATE,
    Gender CHAR(1),
    ContactNumber NVARCHAR(15),
    Address NVARCHAR(100),
    Email NVARCHAR(50)
);

CREATE TABLE DimDoctor (
    DoctorID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Specialization NVARCHAR(50),
    ContactNumber NVARCHAR(15),
    Email NVARCHAR(50)
);

CREATE TABLE DimDate (
    DateID INT PRIMARY KEY,
    Date DATE,
    Day INT,
    Month INT,
    Year INT,
    Quarter INT,
    Weekday VARCHAR(10)
);

CREATE TABLE DimItem (
    ItemID INT PRIMARY KEY,
    ItemName VARCHAR(50),
    QuantityInStock INT,
    ReorderLevel INT,
    LastUpdated DATE
);

CREATE TABLE DimSupplier (
    SupplierID INT PRIMARY KEY,
    SupplierName VARCHAR(50),
    ContactNumber VARCHAR(15),
    Email VARCHAR(50),
    Address VARCHAR(100)
);

CREATE TABLE FactAppointment (
    AppointmentID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES DimPatient(PatientID),
    DoctorID INT FOREIGN KEY REFERENCES DimDoctor(DoctorID),
    AppointmentDate DATE,
    Status NVARCHAR(20),
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID)
);

CREATE TABLE FactBilling (
    BillID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES DimPatient(PatientID),
    Amount DECIMAL(10, 2),
    BillingDate DATE,
    Status NVARCHAR(20), -- e.g., Paid or Unpaid
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID)
);

CREATE TABLE FactLabResult (
    TestID INT PRIMARY KEY,
    PatientID INT FOREIGN KEY REFERENCES DimPatient(PatientID),
    TestType NVARCHAR(50), -- e.g., Blood Test, MRI, etc.
    TestDate DATE,
    TestResult NVARCHAR(100),
    DoctorID INT FOREIGN KEY REFERENCES DimDoctor(DoctorID),
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID)
);

CREATE TABLE FactInventory (
    InventoryID INT PRIMARY KEY,
    ItemID INT FOREIGN KEY REFERENCES DimItem(ItemID),
    QuantityInStock INT,
    SupplierID INT FOREIGN KEY REFERENCES DimSupplier(SupplierID),
    LastUpdated DATE,
    DateID INT FOREIGN KEY REFERENCES DimDate(DateID)
);





