-- ==========================================================
--  CREATE DATABASE
-- ==========================================================
DROP DATABASE IF EXISTS truck_queue_management;

CREATE DATABASE IF NOT EXISTS truck_queue_management;
USE truck_queue_management;

-- ==========================================================
--  TABLE: Users
-- ==========================================================
DROP TABLE IF EXISTS Users;
CREATE TABLE Users (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    NoHp VARCHAR(100) NOT NULL,
    Alamat VARCHAR(255) NOT NULL,
    Role VARCHAR(100) NOT NULL DEFAULT 'admin',
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- ==========================================================
--  TABLE: Trucks
-- ==========================================================
DROP TABLE IF EXISTS Trucks;
CREATE TABLE Trucks (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    PlateNumber VARCHAR(20) NOT NULL UNIQUE,
    TruckName VARCHAR(100),
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy VARCHAR(50),
    UpdatedAt TIMESTAMP NULL,
    UpdatedBy VARCHAR(50)
);

-- ==========================================================
--  TABLE: Drivers
-- ==========================================================
DROP TABLE IF EXISTS Drivers;
CREATE TABLE Drivers (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    DriverName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(30),
    IsBackup BOOLEAN NOT NULL DEFAULT FALSE,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy VARCHAR(50),
    UpdatedAt TIMESTAMP NULL,
    UpdatedBy VARCHAR(50)
);

-- ==========================================================
--  TABLE: TruckDriverAssignments
-- ==========================================================
DROP TABLE IF EXISTS Truck_Driver_Assignments;
CREATE TABLE Truck_Driver_Assignments (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    TruckID INT NOT NULL,
    DriverID INT NOT NULL,
    IsPrimary BOOLEAN NOT NULL DEFAULT TRUE,
    IsActive BOOLEAN NOT NULL DEFAULT TRUE,
    EffectiveFrom DATE,
    EffectiveTo DATE,
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy VARCHAR(50),
    UpdatedAt TIMESTAMP NULL,
    UpdatedBy VARCHAR(50),

    CONSTRAINT FK_Assign_Truck FOREIGN KEY (TruckID) REFERENCES Trucks(ID),
    CONSTRAINT FK_Assign_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(ID),

    CONSTRAINT UX_PrimaryDriverPerTruck UNIQUE (TruckID)
);

-- ==========================================================
--  TABLE: TruckEmptyQueue
-- ==========================================================
DROP TABLE IF EXISTS Truck_Empty_Queue;
CREATE TABLE Truck_Empty_Queue (
    ID BIGINT AUTO_INCREMENT PRIMARY KEY,
    TruckID INT NOT NULL,
    DriverID INT NOT NULL,
    ReportedAt TIMESTAMP NOT NULL,
    PhotoUrl VARCHAR(255) NOT NULL,
    Note VARCHAR(255),
    Status ENUM('WAITING', 'ASSIGNED', 'CANCELLED') NOT NULL DEFAULT 'WAITING',
    AssignedDeliveryCode VARCHAR(100),
    AssignedAt TIMESTAMP NULL,
    CreatedAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CreatedBy VARCHAR(50),
    UpdatedAt TIMESTAMP NULL,
    UpdatedBy VARCHAR(50),

    CONSTRAINT FK_Queue_Truck FOREIGN KEY (TruckID) REFERENCES Trucks(ID),
    CONSTRAINT FK_Queue_Driver FOREIGN KEY (DriverID) REFERENCES Drivers(ID),

    INDEX IX_TruckEmptyQueue_Status_ReportedAt (Status, ReportedAt),
    INDEX IX_TruckEmptyQueue_Truck_Status (TruckID, Status)
);

-- ==========================================================
--  DUMMY DATA
-- ==========================================================

-- Users
INSERT INTO Users (Username, Password, Name, Email, NoHp, Alamat, IsActive)
VALUES
('admin', 'admin123', 'Bekur', '1@email.com', '021', 'Bumi', TRUE);

-- Trucks
INSERT INTO Trucks (PlateNumber, TruckName, CreatedBy)
VALUES
('B 9123 XY', 'Hino Dutro 110', 'admin'),
('B 1234 CD', 'Mitsubishi Fuso', 'admin'),
('B 7788 EF', 'Toyota Dyna', 'admin');

-- Drivers
INSERT INTO Drivers (DriverName, PhoneNumber, IsBackup, IsActive, CreatedBy)
VALUES
('Budi Santoso', '081234567890', FALSE, TRUE, 'admin'),
('Joko Prasetyo', '082233445566', FALSE, TRUE, 'admin'),
('Andri Saputra', '083311223344', FALSE, TRUE, 'admin');

-- TruckDriverAssignments
INSERT INTO Truck_Driver_Assignments 
(TruckID, DriverID, IsPrimary, IsActive, EffectiveFrom, CreatedBy)
VALUES
(1, 1, TRUE, TRUE, '2025-01-01', 'admin'),
(2, 2, TRUE, TRUE, '2025-01-01', 'admin'),
(3, 3, TRUE, TRUE, '2025-01-01', 'admin');

-- TruckEmptyQueue
INSERT INTO Truck_Empty_Queue
(TruckID, DriverID, ReportedAt, PhotoUrl, Note, Status, CreatedBy)
VALUES
(1, 1, '2025-12-10 08:00:00', 'https://example.com/foto1.jpg', 'Kosong di gudang A', 'WAITING', 'admin'),
(2, 2, '2025-12-10 08:05:00', 'https://example.com/foto2.jpg', 'Kosong di gudang B', 'WAITING', 'admin'),
(3, 3, '2025-12-10 08:10:00', 'https://example.com/foto3.jpg', 'Kosong di parkir timur', 'WAITING', 'admin');

-- ==========================================================
--  TRIGGER: Update UpdatedAt
-- ==========================================================
DELIMITER $$

CREATE TRIGGER trg_Trucks_Update
BEFORE UPDATE ON Trucks
FOR EACH ROW
BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_Drivers_Update
BEFORE UPDATE ON Drivers
FOR EACH ROW
BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_Assignments_Update
BEFORE UPDATE ON Truck_Driver_Assignments
FOR EACH ROW
BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_Truck_Empty_Queue_Update
BEFORE UPDATE ON Truck_Empty_Queue
FOR EACH ROW
BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END $$

DELIMITER ;
