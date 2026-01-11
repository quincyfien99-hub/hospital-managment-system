-- Hospital Management System Database
CREATE DATABASE IF NOT EXISTS hms;
USE hms;

-- Users Table
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role ENUM('admin', 'doctor', 'nurse', 'patient', 'staff') DEFAULT 'patient',
    phone VARCHAR(20),
    address TEXT,
    date_of_birth DATE,
    gender ENUM('male', 'female', 'other'),
    profile_image VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Patients Table
CREATE TABLE patients (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE,
    blood_group VARCHAR(5),
    allergies TEXT,
    medical_history TEXT,
    emergency_contact VARCHAR(100),
    insurance_number VARCHAR(50),
    insurance_provider VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

-- Appointments Table
CREATE TABLE appointments (
    id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    department VARCHAR(100),
    reason TEXT,
    status ENUM('scheduled', 'confirmed', 'completed', 'cancelled') DEFAULT 'scheduled',
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES users(id),
    FOREIGN KEY (doctor_id) REFERENCES users(id)
);

-- Insert sample data
INSERT INTO users (email, password, first_name, last_name, role, phone) VALUES
('admin@hms.com', '$2b$10$YourHashedPasswordHere', 'Admin', 'User', 'admin', '+1234567890'),
('doctor@hms.com', '$2b$10$YourHashedPasswordHere', 'John', 'Smith', 'doctor', '+1234567891'),
('patient@hms.com', '$2b$10$YourHashedPasswordHere', 'Jane', 'Doe', 'patient', '+1234567892');

INSERT INTO patients (user_id, blood_group, allergies) VALUES
(3, 'O+', 'Peanuts, Penicillin');