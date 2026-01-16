/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Author:  Risman S
 * Created: Jan 16, 2026
 */

-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 16, 2026 at 04:01 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `truck_queue_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `drivers`
--

CREATE TABLE `drivers` (
  `ID` int(11) NOT NULL,
  `DriverName` varchar(100) NOT NULL,
  `PhoneNumber` varchar(30) DEFAULT NULL,
  `IsBackup` tinyint(1) NOT NULL DEFAULT 0,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `CreatedBy` varchar(50) DEFAULT NULL,
  `UpdatedAt` timestamp NULL DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `drivers`
--

INSERT INTO `drivers` (`ID`, `DriverName`, `PhoneNumber`, `IsBackup`, `IsActive`, `CreatedAt`, `CreatedBy`, `UpdatedAt`, `UpdatedBy`) VALUES
(5, 'Rizal', '0812478826621', 0, 1, '2026-01-13 16:49:45', 'admin', NULL, NULL),
(6, 'Adi Saputra', '085276538891', 0, 1, '2026-01-13 16:50:08', 'admin', NULL, NULL),
(7, 'Yunus', '08588587826', 0, 1, '2026-01-13 16:51:11', 'admin', NULL, NULL),
(8, 'Sahrudin S.', '08129680373', 0, 1, '2026-01-13 16:51:37', 'admin', NULL, NULL),
(9, 'Iim Suhemi', '085567295515', 0, 1, '2026-01-13 16:52:10', 'admin', NULL, NULL);

--
-- Triggers `drivers`
--
DELIMITER $$
CREATE TRIGGER `trg_Drivers_Update` BEFORE UPDATE ON `drivers` FOR EACH ROW BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `trucks`
--

CREATE TABLE `trucks` (
  `ID` int(11) NOT NULL,
  `PlateNumber` varchar(20) NOT NULL,
  `TruckName` varchar(100) DEFAULT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `CreatedBy` varchar(50) DEFAULT NULL,
  `UpdatedAt` timestamp NULL DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `trucks`
--

INSERT INTO `trucks` (`ID`, `PlateNumber`, `TruckName`, `IsActive`, `CreatedAt`, `CreatedBy`, `UpdatedAt`, `UpdatedBy`) VALUES
(5, 'B 9264 KEU', 'SPX', 1, '2026-01-13 16:52:43', 'admin', NULL, NULL),
(6, 'B 9882 UEU', 'Hino', 1, '2026-01-13 16:54:12', 'admin', NULL, NULL),
(7, 'B 7788 EF', 'Toyota Dyna', 1, '2026-01-13 16:54:31', 'admin', NULL, NULL),
(8, 'B 1234 CD', 'Mitsubishi Fuso', 1, '2026-01-13 16:54:51', 'admin', NULL, NULL),
(9, 'B 9123 XY', 'Hino Dutro 110', 1, '2026-01-13 16:55:12', 'admin', NULL, NULL);

--
-- Triggers `trucks`
--
DELIMITER $$
CREATE TRIGGER `trg_Trucks_Update` BEFORE UPDATE ON `trucks` FOR EACH ROW BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `truck_driver_assignments`
--

CREATE TABLE `truck_driver_assignments` (
  `ID` int(11) NOT NULL,
  `TruckID` int(11) NOT NULL,
  `DriverID` int(11) NOT NULL,
  `IsPrimary` tinyint(1) NOT NULL DEFAULT 1,
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `EffectiveFrom` date DEFAULT NULL,
  `EffectiveTo` date DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `CreatedBy` varchar(50) DEFAULT NULL,
  `UpdatedAt` timestamp NULL DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `truck_driver_assignments`
--

INSERT INTO `truck_driver_assignments` (`ID`, `TruckID`, `DriverID`, `IsPrimary`, `IsActive`, `EffectiveFrom`, `EffectiveTo`, `CreatedAt`, `CreatedBy`, `UpdatedAt`, `UpdatedBy`) VALUES
(5, 5, 5, 1, 1, '2026-01-01', NULL, '2026-01-13 16:55:52', 'admin', NULL, NULL),
(6, 6, 6, 1, 1, '2026-01-01', NULL, '2026-01-13 16:56:14', 'admin', NULL, NULL),
(7, 7, 7, 1, 1, '2026-01-01', NULL, '2026-01-13 16:57:02', 'admin', NULL, NULL),
(8, 8, 8, 1, 1, '2026-01-01', NULL, '2026-01-13 16:57:15', 'admin', NULL, NULL),
(9, 9, 9, 1, 1, '2026-01-01', NULL, '2026-01-13 16:57:26', 'admin', NULL, NULL);

--
-- Triggers `truck_driver_assignments`
--
DELIMITER $$
CREATE TRIGGER `trg_Assignments_Update` BEFORE UPDATE ON `truck_driver_assignments` FOR EACH ROW BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `truck_empty_queue`
--

CREATE TABLE `truck_empty_queue` (
  `ID` bigint(20) NOT NULL,
  `TruckID` int(11) NOT NULL,
  `DriverID` int(11) NOT NULL,
  `ReportedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `PhotoUrl` varchar(255) NOT NULL,
  `Note` varchar(255) DEFAULT NULL,
  `Status` enum('WAITING','ASSIGNED','CANCELLED') NOT NULL DEFAULT 'WAITING',
  `AssignedDeliveryCode` varchar(100) DEFAULT NULL,
  `AssignedAt` timestamp NULL DEFAULT NULL,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `CreatedBy` varchar(50) DEFAULT NULL,
  `UpdatedAt` timestamp NULL DEFAULT NULL,
  `UpdatedBy` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `truck_empty_queue`
--

INSERT INTO `truck_empty_queue` (`ID`, `TruckID`, `DriverID`, `ReportedAt`, `PhotoUrl`, `Note`, `Status`, `AssignedDeliveryCode`, `AssignedAt`, `CreatedAt`, `CreatedBy`, `UpdatedAt`, `UpdatedBy`) VALUES
(6, 8, 8, '2026-01-13 18:04:55', 'uploads/1768323661614.jpg', 'Sudah Kosong', 'CANCELLED', 'DC03', '2026-01-13 18:01:16', '2026-01-13 17:01:01', 'admin', '2026-01-13 18:04:55', 'admin'),
(7, 9, 9, '2026-01-13 18:04:48', 'uploads/1768323732024.jpg', 'Sudah Kosong', 'CANCELLED', 'DC04', '2026-01-13 18:01:24', '2026-01-13 17:02:12', 'admin', '2026-01-13 18:04:48', 'admin'),
(8, 6, 6, '2026-01-13 18:04:52', 'uploads/1768323794271.jpg', 'Cancel order', 'CANCELLED', 'DC01', '2026-01-13 18:00:49', '2026-01-13 17:03:14', 'admin', '2026-01-13 18:04:52', 'admin'),
(9, 5, 5, '2026-01-13 18:04:44', 'uploads/1768323869375.jpg', 'Pengosongan', 'CANCELLED', 'DC02', '2026-01-13 18:01:05', '2026-01-13 17:04:29', 'admin', '2026-01-13 18:04:44', 'admin'),
(10, 7, 7, '2026-01-13 18:04:28', 'uploads/1768323937363.jpg', 'pengosongan', 'CANCELLED', 'DC05', '2026-01-13 18:01:33', '2026-01-13 17:05:37', 'admin', '2026-01-13 18:04:28', 'admin');

--
-- Triggers `truck_empty_queue`
--
DELIMITER $$
CREATE TRIGGER `trg_Truck_Empty_Queue_Update` BEFORE UPDATE ON `truck_empty_queue` FOR EACH ROW BEGIN
    SET NEW.UpdatedAt = CURRENT_TIMESTAMP;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` int(11) NOT NULL,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `NoHp` varchar(100) NOT NULL,
  `Alamat` varchar(255) NOT NULL,
  `Role` varchar(100) NOT NULL DEFAULT 'admin',
  `IsActive` tinyint(1) NOT NULL DEFAULT 1,
  `CreatedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `Username`, `Password`, `Name`, `Email`, `NoHp`, `Alamat`, `Role`, `IsActive`, `CreatedAt`) VALUES
(1, 'admin', 'admin123', 'admin', '1@email.com', '021', 'Bumi', 'admin', 1, '2025-12-11 14:40:33');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `drivers`
--
ALTER TABLE `drivers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `trucks`
--
ALTER TABLE `trucks`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `PlateNumber` (`PlateNumber`);

--
-- Indexes for table `truck_driver_assignments`
--
ALTER TABLE `truck_driver_assignments`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `UX_PrimaryDriverPerTruck` (`TruckID`),
  ADD KEY `FK_Assign_Driver` (`DriverID`);

--
-- Indexes for table `truck_empty_queue`
--
ALTER TABLE `truck_empty_queue`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `FK_Queue_Driver` (`DriverID`),
  ADD KEY `IX_TruckEmptyQueue_Status_ReportedAt` (`Status`,`ReportedAt`),
  ADD KEY `IX_TruckEmptyQueue_Truck_Status` (`TruckID`,`Status`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Username` (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `drivers`
--
ALTER TABLE `drivers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `trucks`
--
ALTER TABLE `trucks`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `truck_driver_assignments`
--
ALTER TABLE `truck_driver_assignments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `truck_empty_queue`
--
ALTER TABLE `truck_empty_queue`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `truck_driver_assignments`
--
ALTER TABLE `truck_driver_assignments`
  ADD CONSTRAINT `FK_Assign_Driver` FOREIGN KEY (`DriverID`) REFERENCES `drivers` (`ID`),
  ADD CONSTRAINT `FK_Assign_Truck` FOREIGN KEY (`TruckID`) REFERENCES `trucks` (`ID`);

--
-- Constraints for table `truck_empty_queue`
--
ALTER TABLE `truck_empty_queue`
  ADD CONSTRAINT `FK_Queue_Driver` FOREIGN KEY (`DriverID`) REFERENCES `drivers` (`ID`),
  ADD CONSTRAINT `FK_Queue_Truck` FOREIGN KEY (`TruckID`) REFERENCES `trucks` (`ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
