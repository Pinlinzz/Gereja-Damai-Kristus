// --- IMPORT MODUL ---
const express = require('express');
const path = require('path');
const ejs = require('ejs');
const mysql = require('mysql2/promise');
const bcrypt = require('bcryptjs');
const cors = require('cors');
const bodyParser = require('body-parser');

// Memuat variabel environment (seperti DB_USERNAME) dari file .env
require('dotenv').config(); 

// --- PENGATURAN APLIKASI EXPRESS ---
const app = express();
const PORT = process.env.PORT || 3000;

// --- KONFIGURASI DATABASE (dari server lama Anda) ---
const dbConfig = {
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USERNAME || 'root', // Menggunakan DB_USERNAME
    password: process.env.DB_PASSWORD || '',
    database: process.env.DB_DATABASE || 'gereja_db' // Menggunakan DB_DATABASE
};
const pool = mysql.createPool(dbConfig);

// --- MIDDLEWARE ---
app.use(cors()); // Mengizinkan API diakses
app.use(bodyParser.json()); // Membaca data JSON dari API
app.use(express.urlencoded({ extended: true })); // Menggantikan fungsi getBody
app.set('view engine', 'ejs'); // Mengatur EJS
app.set('views', path.join(__dirname, 'views'));

// Ini menggantikan semua blok 'fs.readFile' Anda untuk file statis
// Ini akan menyajikan style.css, script.js, images/, DAN report-gereja-damai/
app.use(express.static(path.join(__dirname, 'public')));


// --- IMPORT RUTE API (dari folder api_routes) ---
const financeRoutes = require('./api_routes/finance');
const eventsRoutes = require('./api_routes/events');

// --- GUNAKAN RUTE API ---
// Ini adalah bagian yang hilang: memberi tahu server cara merespons panel admin
app.use('/api/finance', financeRoutes); 
app.use('/api', eventsRoutes);


// --- ROUTING HALAMAN EJS (Server lama Anda yang di-upgrade) ---

// Halaman Utama
app.get('/', async (req, res) => {
    let connection;
    try {
        connection = await pool.getConnection();
        // **PERBAIKAN:** Query ini sekarang membaca dari 'jadwal_kegiatan'
        // dan mengganti nama kolom (AS title) agar cocok dengan index.ejs
        const query = `
            SELECT 
                nama_kegiatan AS title,
                kategori AS category,
                DATE(waktu_mulai) AS event_date,
                TIME(waktu_mulai) AS start_time,
                lokasi AS location,
                penanggung_jawab AS contact_person,
                kontak AS contact_info,
                deskripsi AS description
            FROM jadwal_kegiatan 
            WHERE waktu_mulai >= CURDATE() 
            ORDER BY waktu_mulai ASC 
            LIMIT 3`;
        const [events] = await connection.execute(query);
        res.render('index', { events: events });
    } catch (error) {
        console.error("Error fetching events:", error);
        res.status(500).send('Terjadi kesalahan pada server.');
    } finally {
        if (connection) connection.release();
    }
});

// Halaman GET lainnya
app.get('/login', (req, res) => {
    res.render('login', { error: null });
});

app.get('/register', (req, res) => {
    res.render('register', { error: null });
});

app.get('/about', (req, res) => {
    res.render('about');
});

app.get('/contact', (req, res) => {
    res.render('contact');
});

app.get('/calendar', (req, res) => {
    res.render('calendar');
});

app.get('/logout', (req, res) => {
    res.redirect('/');
});


// --- LOGIC FORM (POST) ---

// LOGIN LOGIC
app.post('/login', async (req, res) => {
    let connection;
    try {
        const { username, password } = req.body; // Express menggantikan getBody

        connection = await pool.getConnection();
        const loginQuery = `
            SELECT u.*, r.role_name 
            FROM users u
            JOIN roles r ON u.role_id = r.role_id
            WHERE u.username = ? OR u.email = ?`;
            
        const [rows] = await connection.execute(loginQuery, [username, username]);

        if (rows.length === 0) {
            return res.render('login', { error: 'Username atau password salah.' });
        }
        const user = rows[0];

        if (!user.is_active) {
            return res.render('login', { error: 'Akun Anda tidak aktif.' });
        }

        const isPasswordValid = await bcrypt.compare(password, user.password_hash);

        if (!isPasswordValid) {
            return res.render('login', { error: 'Username atau password salah.' });
        }

        await connection.execute('UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE user_id = ?', [user.user_id]);

        if (user.role_name === 'Admin' || user.role_name === 'Super Admin') {
            return res.render('admin_dashboard', { user }); // Menggunakan EJS
        } else {
            return res.render('dashboard', { user });
        }
    } catch (error) {
        console.error('Login Error:', error);
        res.status(500).send('Terjadi kesalahan pada server.');
    } finally {
        if (connection) connection.release();
    }
});

// REGISTER LOGIC
app.post('/register', async (req, res) => {
    let connection;
    try {
        const { fullName, username, email, password, confirmPassword } = req.body;

        if (!fullName || !username || !email || !password) {
            return res.render('register', { error: 'Semua kolom wajib diisi.' });
        }
        if (password !== confirmPassword) {
            return res.render('register', { error: 'Konfirmasi password tidak cocok.' });
        }

        connection = await pool.getConnection();
        const [existingUsers] = await connection.execute('SELECT user_id FROM users WHERE username = ? OR email = ?', [username, email]);

        if (existingUsers.length > 0) {
            return res.render('register', { error: 'Username atau email sudah terdaftar.' });
        }

        const [roleRows] = await connection.execute('SELECT role_id FROM roles WHERE role_name = ?', ['User']);
        if (roleRows.length === 0) {
            throw new Error("Role 'User' tidak ditemukan di database.");
        }
        const userRoleId = roleRows[0].role_id;
        
        const passwordHash = await bcrypt.hash(password, 10);
        
        await connection.execute(
            'INSERT INTO users (full_name, username, email, password_hash, role_id) VALUES (?, ?, ?, ?, ?)',
            [fullName, username, email, passwordHash, userRoleId]
        );
        
        res.redirect('/login?status=registered');
    } catch (error) {
        console.error('Register Error:', error);
        res.status(500).send('Terjadi kesalahan pada server.');
    } finally {
        if (connection) connection.release();
    }
});


// --- MENJALANKAN SERVER ---
app.listen(PORT, () => {
    console.log(`Server berjalan pada port ${PORT} -> http://localhost:${PORT}/`);
    pool.getConnection()
        .then(connection => {
            console.log("Koneksi ke database MySQL berhasil.");
            connection.release();
        })
        .catch(err => {
            console.error("Gagal terkoneksi ke database MySQL:", err.message);
            console.log("Pastikan server MySQL berjalan dan konfigurasi di server.js sudah benar.");
        });
});