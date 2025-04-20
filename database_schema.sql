-- Create database if it doesn't exist
CREATE DATABASE IF NOT EXISTS hospital_management;
USE hospital_management;

-- Create admin table
CREATE TABLE IF NOT EXISTS admin (
    AdminID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP NULL
);

-- Create doctor table
CREATE TABLE IF NOT EXISTS doctor (
    DoctorID VARCHAR(20) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Specialization VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Phone VARCHAR(20),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP NULL
);

-- Create patient table
CREATE TABLE IF NOT EXISTS patient (
    PatientID VARCHAR(20) PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    Gender ENUM('male', 'female', 'other') NOT NULL,
    DateOfBirth DATE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    BloodGroup VARCHAR(5),
    Address TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    LastLogin TIMESTAMP NULL
);

-- Create a login_logs table to track login attempts
CREATE TABLE IF NOT EXISTS login_logs (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    UserID VARCHAR(20) NOT NULL,
    UserType ENUM('admin', 'doctor', 'patient') NOT NULL,
    LoginTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('success', 'failed') NOT NULL,
    IPAddress VARCHAR(45)
);
