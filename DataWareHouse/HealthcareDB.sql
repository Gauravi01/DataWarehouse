use HealthcareDB;

-- Creating the Patients Table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    DOB DATE,
    Gender CHAR(1), -- 'M' for Male, 'F' for Female
    ContactNumber NVARCHAR(15),
    Address NVARCHAR(100),
    Email NVARCHAR(50)
);

-- Creating the Doctors Table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Specialization NVARCHAR(50),
    ContactNumber NVARCHAR(15),
    Email NVARCHAR(50)
);

-- Creating the Appointments Table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATETIME,
    Status NVARCHAR(20),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Creating the Billing Table
CREATE TABLE Billing (
    BillID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT,
    Amount DECIMAL(10, 2),
    BillingDate DATE,
    Status NVARCHAR(10),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);


-- Inserting Sample Data into Doctors Table
DECLARE @i INT = 1;
DECLARE @FirstNames NVARCHAR(50);
DECLARE @LastNames NVARCHAR(50);
DECLARE @Specialization NVARCHAR(50);
DECLARE @ContactNumber NVARCHAR(15);
DECLARE @Email NVARCHAR(50);

WHILE @i <= 20
BEGIN
    -- Generate random values for each column
    SET @FirstNames = (SELECT TOP 1 FirstName FROM (VALUES ('Alice'), ('Bob'), ('Charlie'), ('David'), ('Emily'), 
                                                      ('Frank'), ('Grace'), ('Henry'), ('Ivy'), ('Jack'), 
                                                      ('Kathy'), ('Liam'), ('Mia'), ('Noah'), ('Olivia'), 
                                                      ('Paul'), ('Quinn'), ('Rachel'), ('Sam'), ('Tina')) AS Names(FirstName) ORDER BY NEWID());

    SET @LastNames = (SELECT TOP 1 LastName FROM (VALUES ('Johnson'), ('Smith'), ('Brown'), ('Williams'), ('Jones'), 
                                                   ('Miller'), ('Davis'), ('Garcia'), ('Rodriguez'), ('Martinez')) AS Surnames(LastName) ORDER BY NEWID());
    
    SET @Specialization = (SELECT TOP 1 Specialization FROM (VALUES ('Cardiology'), ('Neurology'), ('Pediatrics'), 
                                                              ('Orthopedics'), ('Dermatology'), ('Radiology'), 
                                                              ('Oncology'), ('General Practice'), ('Surgery'), 
                                                              ('Psychiatry')) AS Specialties(Specialization) ORDER BY NEWID());

    SET @ContactNumber = '07' + CAST(FLOOR(RAND() * 900000000 + 100000000) AS NVARCHAR(15)); -- Random contact number
    SET @Email = LOWER(@FirstNames + '.' + @LastNames + CAST(@i AS NVARCHAR(10)) + '@example.com');

    -- Insert generated values into Doctors table
    INSERT INTO Doctors (FirstName, LastName, Specialization, ContactNumber, Email)
    VALUES (@FirstNames, @LastNames, @Specialization, @ContactNumber, @Email);

    SET @i = @i + 1; -- Increment counter
END;



-- insert patient
DECLARE @i INT = 1;
DECLARE @FirstNames NVARCHAR(50);
DECLARE @LastNames NVARCHAR(50);
DECLARE @DOB DATE;
DECLARE @Gender CHAR(1);
DECLARE @ContactNumber NVARCHAR(15);
DECLARE @Address NVARCHAR(100);
DECLARE @Email NVARCHAR(50);

WHILE @i <= 100
BEGIN
    -- Generate random values for each column
    SET @FirstNames = (SELECT TOP 1 FirstName FROM (VALUES ('John'), ('Jane'), ('Michael'), ('Sara'), ('David'), ('Laura'), ('James'), ('Emily'), ('Robert'), ('Emma')) AS Names(FirstName) ORDER BY NEWID());
    SET @LastNames = (SELECT TOP 1 LastName FROM (VALUES ('Smith'), ('Johnson'), ('Brown'), ('Williams'), ('Jones'), ('Miller'), ('Davis'), ('Garcia'), ('Rodriguez'), ('Martinez')) AS Surnames(LastName) ORDER BY NEWID());
    SET @DOB = DATEADD(DAY, -1 * (FLOOR(RAND() * 20000)), GETDATE()); -- Random DOB within the last 55 years
    SET @Gender = CASE WHEN RAND() < 0.5 THEN 'M' ELSE 'F' END;
    SET @ContactNumber = '07' + CAST(FLOOR(RAND() * 9000000 + 1000000) AS NVARCHAR(15)); -- Generates a random contact number
    SET @Address = 'Address ' + CAST(@i AS NVARCHAR(10));
    SET @Email = LOWER(@FirstNames + '.' + @LastNames + CAST(@i AS NVARCHAR(10)) + '@example.com');

    -- Insert generated values into Patients table
    INSERT INTO Patients (FirstName, LastName, DOB, Gender, ContactNumber, Address, Email)
    VALUES (@FirstNames, @LastNames, @DOB, @Gender, @ContactNumber, @Address, @Email);

    SET @i = @i + 1; -- Increment counter
END;

-- insert appointments
DECLARE @i INT = 1;
DECLARE @PatientID INT;
DECLARE @DoctorID INT;
DECLARE @AppointmentDate DATETIME;
DECLARE @Status NVARCHAR(20);

WHILE @i <= 100
BEGIN
    -- Randomly select PatientID and DoctorID
    SET @PatientID = (SELECT TOP 1 PatientID FROM Patients ORDER BY NEWID());
    SET @DoctorID = (SELECT TOP 1 DoctorID FROM Doctors ORDER BY NEWID());

    -- Generate a random AppointmentDate within the next 30 days
    SET @AppointmentDate = DATEADD(DAY, CAST(RAND() * 30 AS INT), GETDATE());

    -- Randomly assign Status
    SET @Status = (SELECT TOP 1 Status FROM (VALUES ('Scheduled'), ('Completed'), ('Cancelled'), ('No Show')) AS Statuses(Status) ORDER BY NEWID());

    -- Insert generated values into Appointments table
    INSERT INTO Appointments (PatientID, DoctorID, AppointmentDate, Status)
    VALUES (@PatientID, @DoctorID, @AppointmentDate, @Status);

    SET @i = @i + 1; -- Increment counter
END;


-- insert billing 
DECLARE @i INT = 1;
DECLARE @PatientID INT;
DECLARE @Amount DECIMAL(10, 2);
DECLARE @BillingDate DATE;
DECLARE @Status NVARCHAR(10);

WHILE @i <= 100
BEGIN
    -- Randomly select PatientID from Patients table
    SET @PatientID = (SELECT TOP 1 PatientID FROM Patients ORDER BY NEWID());

    -- Generate a random Amount between 50.00 and 500.00
    SET @Amount = ROUND((RAND() * (500 - 50) + 50), 2); 

    -- Generate a random BillingDate within the last 30 days
    SET @BillingDate = DATEADD(DAY, -1 * (CAST(RAND() * 30 AS INT)), GETDATE());

    -- Randomly assign Status
    SET @Status = (SELECT TOP 1 Status FROM (VALUES ('Paid'), ('Pending'), ('Overdue')) AS Statuses(Status) ORDER BY NEWID());

    -- Insert generated values into Billing table
    INSERT INTO Billing (PatientID, Amount, BillingDate, Status)
    VALUES (@PatientID, @Amount, @BillingDate, @Status);

    SET @i = @i + 1; -- Increment counter
END;
