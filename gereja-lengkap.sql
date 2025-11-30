-- ===================================================================
-- DATABASE GEREJA LENGKAP - GABUNGAN MAIN PROJECT + REPORT GEREJA DAMAI
-- ===================================================================
-- Database tunggal untuk: Main Website + Admin Dashboard
-- ===================================================================

-- Drop database jika sudah ada (HATI-HATI: akan hapus semua data!)
-- DROP DATABASE IF EXISTS gereja_db;

-- Buat database
CREATE DATABASE IF NOT EXISTS gereja_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE gereja_db;

-- ===================================================================
-- SECTION 1: USER MANAGEMENT & AUTHENTICATION (Main Project)
-- ===================================================================

-- Tabel Roles
CREATE TABLE IF NOT EXISTS roles (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE,
    role_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabel Users
CREATE TABLE IF NOT EXISTS users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(20),
    role_id INT NOT NULL,
    is_active TINYINT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    FOREIGN KEY (role_id) REFERENCES roles(role_id)
) ENGINE=InnoDB;

-- Tabel Permissions
CREATE TABLE IF NOT EXISTS permissions (
    permission_id INT AUTO_INCREMENT PRIMARY KEY,
    permission_name VARCHAR(50) NOT NULL UNIQUE,
    permission_description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabel Role Permissions (Many-to-Many)
CREATE TABLE IF NOT EXISTS role_permissions (
    role_permission_id INT AUTO_INCREMENT PRIMARY KEY,
    role_id INT NOT NULL,
    permission_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES roles(role_id) ON DELETE CASCADE,
    FOREIGN KEY (permission_id) REFERENCES permissions(permission_id) ON DELETE CASCADE,
    UNIQUE KEY unique_role_permission (role_id, permission_id)
) ENGINE=InnoDB;

-- Tabel Login History
CREATE TABLE IF NOT EXISTS login_history (
    login_history_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    login_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ip_address VARCHAR(45),
    user_agent TEXT,
    login_status ENUM('success', 'failed') NOT NULL,
    failure_reason VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabel Password Reset Tokens
CREATE TABLE IF NOT EXISTS password_reset_tokens (
    token_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    reset_token VARCHAR(255) NOT NULL UNIQUE,
    token_expiry TIMESTAMP NOT NULL,
    is_used TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabel Sessions
CREATE TABLE IF NOT EXISTS sessions (
    session_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    session_token VARCHAR(255) NOT NULL UNIQUE,
    session_data TEXT,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP + INTERVAL 1 DAY),
    last_activity TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===================================================================
-- SECTION 2: EVENTS/CALENDAR (Main Project)
-- ===================================================================

-- Tabel Events untuk Main Website
CREATE TABLE IF NOT EXISTS events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    event_name VARCHAR(255) NOT NULL,
    event_description TEXT,
    event_category VARCHAR(100),
    event_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    location VARCHAR(200) DEFAULT 'Gereja Utama',
    contact_person VARCHAR(100),
    contact_info VARCHAR(100),
    registration_required TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_event_date (event_date)
) ENGINE=InnoDB;

-- ===================================================================
-- SECTION 3: FINANCE MANAGEMENT (Report Gereja Damai)
-- ===================================================================

-- Tabel Finance Transactions
CREATE TABLE IF NOT EXISTS finance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date DATE NOT NULL,
    description VARCHAR(255) NOT NULL,
    type ENUM('income', 'expense') NOT NULL,
    category VARCHAR(100) NOT NULL,
    amount DECIMAL(15, 2) NOT NULL,
    notes TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_date (date),
    INDEX idx_type (type),
    INDEX idx_category (category)
) ENGINE=InnoDB;

-- Tabel Finance Categories
CREATE TABLE IF NOT EXISTS finance_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    type ENUM('income', 'expense') NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Tabel Monthly Summary
CREATE TABLE IF NOT EXISTS monthly_summary (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month INT NOT NULL,
    total_income DECIMAL(15, 2) DEFAULT 0,
    total_expense DECIMAL(15, 2) DEFAULT 0,
    balance DECIMAL(15, 2) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    UNIQUE KEY unique_year_month (year, month)
) ENGINE=InnoDB;

-- ===================================================================
-- SECTION 4: EVENTS/CALENDAR (Report Gereja Damai - Admin)
-- ===================================================================

-- Tabel Jadwal Kegiatan untuk Admin Dashboard
CREATE TABLE IF NOT EXISTS jadwal_kegiatan (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama_kegiatan VARCHAR(255) NOT NULL,
    deskripsi TEXT NULL,
    kategori ENUM('Misa & Liturgi', 'Kegiatan Komunitas', 'Doa & Devosi', 'Pastoral & Acara Khusus') NOT NULL,
    waktu_mulai DATETIME NOT NULL,
    waktu_selesai DATETIME NULL,
    lokasi VARCHAR(100) DEFAULT 'Gereja Utama',
    penanggung_jawab VARCHAR(100) NULL,
    kontak VARCHAR(100) NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_waktu_mulai (waktu_mulai),
    INDEX idx_kategori (kategori)
) ENGINE=InnoDB;

-- ===================================================================
-- SECTION 5: INDEXES FOR PERFORMANCE
-- ===================================================================

-- Indexes untuk tabel users
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role_id ON users(role_id);

-- Indexes untuk tabel sessions
CREATE INDEX idx_sessions_user_id ON sessions(user_id);
CREATE INDEX idx_sessions_token ON sessions(session_token);

-- Indexes untuk tabel login_history
CREATE INDEX idx_login_history_user_id ON login_history(user_id);
CREATE INDEX idx_login_history_timestamp ON login_history(login_timestamp);

-- ===================================================================
-- SECTION 6: SEED DATA - ROLES & PERMISSIONS
-- ===================================================================

-- Insert Roles
INSERT INTO roles (role_name, role_description) VALUES
('Super Admin', 'Full access to all features and settings'),
('Admin', 'Administrative access with limited system settings'),
('Staff', 'Regular staff member with basic access'),
('User', 'Basic user with limited access')
ON DUPLICATE KEY UPDATE role_name=VALUES(role_name);

-- Insert Permissions
INSERT INTO permissions (permission_name, permission_description) VALUES
('user_create', 'Create new users'),
('user_read', 'View user information'),
('user_update', 'Update user information'),
('user_delete', 'Delete users'),
('role_manage', 'Manage roles and permissions'),
('report_view', 'View reports'),
('report_export', 'Export reports'),
('calendar_create', 'Create calendar events'),
('calendar_update', 'Update calendar events'),
('calendar_delete', 'Delete calendar events'),
('finance_create', 'Create financial transactions'),
('finance_read', 'View financial data'),
('finance_update', 'Update financial transactions'),
('finance_delete', 'Delete financial transactions')
ON DUPLICATE KEY UPDATE permission_name=VALUES(permission_name);

-- Insert Role Permissions (Super Admin: All permissions)
INSERT INTO role_permissions (role_id, permission_id) 
SELECT 1, permission_id FROM permissions
ON DUPLICATE KEY UPDATE role_id=VALUES(role_id);

-- Insert Role Permissions (Admin)
INSERT INTO role_permissions (role_id, permission_id)
SELECT 2, permission_id FROM permissions WHERE permission_name IN 
('user_read', 'user_update', 'report_view', 'report_export', 
 'calendar_create', 'calendar_update', 'finance_read', 'finance_create', 'finance_update')
ON DUPLICATE KEY UPDATE role_id=VALUES(role_id);

-- Insert Role Permissions (Staff)
INSERT INTO role_permissions (role_id, permission_id)
SELECT 3, permission_id FROM permissions WHERE permission_name IN 
('user_read', 'report_view', 'calendar_create', 'finance_read', 'finance_create')
ON DUPLICATE KEY UPDATE role_id=VALUES(role_id);

-- Insert Role Permissions (User)
INSERT INTO role_permissions (role_id, permission_id)
SELECT 4, permission_id FROM permissions WHERE permission_name IN 
('user_read', 'report_view', 'finance_read')
ON DUPLICATE KEY UPDATE role_id=VALUES(role_id);

-- ===================================================================
-- SECTION 7: SEED DATA - USERS
-- ===================================================================

-- Insert Sample Users
-- Password untuk semua user: "password123" kecuali admin
-- admin: admin123
-- Hash generated menggunakan bcrypt dengan salt rounds 10
INSERT INTO users (username, email, password_hash, full_name, phone_number, role_id) VALUES
('admin', 'admin@gereja.com', '$2b$10$OtsJMwURENWytBmkta2LJuulu6HpWkDXEUsjbQMI.MJ.EQoPhCA0a', 'Administrator', '08123456789', 1),
('pastor', 'pastor@gereja.com', '$2b$10$0G3gfGfsa.SyV1XfhmNA6OGWDHhKCCfmN2f/7Un2miypJ.ocspCYW', 'Pastor', '08123456790', 2),
('staff', 'staff@gereja.com', '$2a$10$YourHashedPasswordHere', 'Staff Gereja', '08123456791', 3),
('john', 'john@email.com', '$2a$10$YourHashedPasswordHere', 'John Doe', '08123456792', 4)
ON DUPLICATE KEY UPDATE username=VALUES(username);

-- NOTE: Ganti password hash di atas dengan hash yang benar!
-- Gunakan bcrypt untuk generate hash dari password "admin123" untuk user admin

-- ===================================================================
-- SECTION 8: SEED DATA - FINANCE CATEGORIES
-- ===================================================================

INSERT INTO finance_categories (name, type, description) VALUES
('Persembahan', 'income', 'Persembahan minggu reguler'),
('Perpuluhan', 'income', 'Persepuluhan dari jemaat'),
('Sumbangan Khusus', 'income', 'Sumbangan untuk keperluan khusus'),
('Building Fund', 'income', 'Dana pembangunan gereja'),
('Operasional', 'expense', 'Biaya operasional gereja'),
('Gaji', 'expense', 'Gaji petugas dan staff'),
('Utilitas', 'expense', 'Listrik, air, internet'),
('Pemeliharaan', 'expense', 'Pemeliharaan gedung dan fasilitas'),
('Program Gereja', 'expense', 'Biaya program dan kegiatan'),
('Sosial', 'expense', 'Bantuan sosial dan pelayanan masyarakat')
ON DUPLICATE KEY UPDATE name=VALUES(name);

-- ===================================================================
-- SECTION 9: SEED DATA - FINANCE TRANSACTIONS (Sample)
-- ===================================================================

INSERT INTO finance (date, description, type, category, amount, notes) VALUES
-- JANUARI 2025
('2025-01-05', 'Persembahan Minggu I', 'income', 'Persembahan', 4500000, 'Ibadah minggu pertama'),
('2025-01-12', 'Persembahan Minggu II', 'income', 'Persembahan', 5200000, 'Ibadah minggu kedua'),
('2025-01-19', 'Persembahan Minggu III', 'income', 'Persembahan', 4800000, 'Ibadah minggu ketiga'),
('2025-01-26', 'Persembahan Minggu IV', 'income', 'Persembahan', 5100000, 'Ibadah minggu keempat'),
('2025-01-05', 'Gaji Petugas Gereja', 'expense', 'Gaji', 4000000, 'Gaji bulan Januari'),
('2025-01-10', 'Biaya Listrik', 'expense', 'Utilitas', 1500000, 'Tagihan listrik Desember'),
('2025-01-10', 'Biaya Air', 'expense', 'Utilitas', 500000, 'Tagihan air Desember')
ON DUPLICATE KEY UPDATE date=VALUES(date);

-- ===================================================================
-- SECTION 10: SEED DATA - EVENTS (Main Website)
-- ===================================================================

INSERT INTO events (event_name, event_description, event_category, event_date, start_time, end_time, location, contact_person, contact_info, registration_required) VALUES
('Misa Minggu Pagi', 'Misa minggu reguler untuk umat', 'Misa & Liturgi', '2025-10-26', '07:00:00', '08:30:00', 'Gereja Utama', 'Sekretariat', '021-12345678', 0),
('Doa Rosario', 'Doa Rosario bersama umat', 'Doa & Devosi', '2025-10-27', '18:00:00', '19:00:00', 'Gua Maria', 'Legio Maria', '08123456789', 0),
('Retreat Pemuda', 'Retret khusus untuk kaum muda', 'Kegiatan Komunitas', '2025-11-02', '08:00:00', '17:00:00', 'Gedung Karya Pastoral', 'Seksi Kepemudaan', '08123456780', 1)
ON DUPLICATE KEY UPDATE event_name=VALUES(event_name);

-- ===================================================================
-- SECTION 11: SEED DATA - JADWAL KEGIATAN (Admin Dashboard)
-- ===================================================================

INSERT INTO jadwal_kegiatan 
  (nama_kegiatan, deskripsi, kategori, waktu_mulai, waktu_selesai, lokasi, penanggung_jawab)
VALUES
  ('Misa Harian Pagi', 'Misa harian biasa.', 'Misa & Liturgi', '2025-10-21 06:00:00', '2025-10-21 06:45:00', 'Gereja Utama', 'Romo Paroki'),
  ('Doa Rosario Meriah', 'Doa Rosario bersama umat.', 'Doa & Devosi', '2025-10-22 19:00:00', '2025-10-22 20:00:00', 'Gua Maria', 'Legio Maria'),
  ('Rapat Pengurus', 'Rapat bulanan pengurus gereja.', 'Kegiatan Komunitas', '2025-10-23 19:00:00', '2025-10-23 21:00:00', 'Ruang Rapat', 'Ketua Dewan'),
  ('Misa Minggu Pagi I', 'Misa mingguan untuk umat.', 'Misa & Liturgi', '2025-10-26 07:00:00', '2025-10-26 08:15:00', 'Gereja Utama', 'Romo Paroki'),
  ('Misa Minggu Pagi II', 'Misa mingguan dengan koor anak.', 'Misa & Liturgi', '2025-10-26 09:00:00', '2025-10-26 10:15:00', 'Gereja Utama', 'Romo Rekan')
ON DUPLICATE KEY UPDATE nama_kegiatan=VALUES(nama_kegiatan);

-- ===================================================================
-- SECTION 12: UPDATE MONTHLY SUMMARY
-- ===================================================================

INSERT INTO monthly_summary (year, month, total_income, total_expense, balance)
SELECT 
    YEAR(date) as year,
    MONTH(date) as month,
    SUM(CASE WHEN type = 'income' THEN amount ELSE 0 END) as total_income,
    SUM(CASE WHEN type = 'expense' THEN amount ELSE 0 END) as total_expense,
    SUM(CASE WHEN type = 'income' THEN amount ELSE -amount END) as balance
FROM finance
GROUP BY YEAR(date), MONTH(date)
ON DUPLICATE KEY UPDATE
    total_income = VALUES(total_income),
    total_expense = VALUES(total_expense),
    balance = VALUES(balance);

-- ===================================================================
-- COMPLETE! Database gereja_db siap digunakan!
-- ===================================================================
-- Total Tables: 14
-- - User Management: 7 tables
-- - Finance: 3 tables
-- - Events (Main): 1 table
-- - Events (Admin): 1 table
-- - Supporting: 2 tables
-- ===================================================================
