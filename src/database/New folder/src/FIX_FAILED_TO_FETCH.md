# 🔧 FIX: Failed to Fetch Error

Error yang Anda alami:
```
Error fetching transactions: TypeError: Failed to fetch
Error fetching categories: TypeError: Failed to fetch
Error fetching monthly data: TypeError: Failed to fetch
Error fetching summary: TypeError: Failed to fetch
```

Ini berarti **Backend API tidak jalan** atau tidak bisa diakses oleh Frontend.

---

## ✅ SOLUSI LANGKAH DEMI LANGKAH

### **STEP 1: Cek MySQL Service Jalan**

Backend butuh MySQL untuk jalan. Pastikan MySQL service sudah running.

**Windows:**
```bash
# Buka Command Prompt as Administrator
net start MySQL80

# Atau jika MySQL versi lain:
net start MySQL
```

**Mac:**
```bash
brew services start mysql

# Atau
mysql.server start
```

**Linux:**
```bash
sudo systemctl start mysql

# Atau
sudo service mysql start
```

**Verifikasi MySQL jalan:**
```bash
mysql -u root -p

# Jika berhasil login, MySQL sudah jalan
# Ketik: exit untuk keluar
```

---

### **STEP 2: Verifikasi File .env**

Pastikan file `backend/.env` sudah ada dan benar.

**Buka file:** `backend/.env`

**Isi harus seperti ini:**
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password_here
DB_NAME=gereja_damai_kristus
DB_PORT=3306

PORT=3001
NODE_ENV=development

CORS_ORIGIN=http://localhost:5173
```

**PENTING!** Ganti `DB_PASSWORD` dengan password MySQL Anda:
- Jika password MySQL = `admin123` → `DB_PASSWORD=admin123`
- Jika **TIDAK ADA** password → `DB_PASSWORD=` (kosongkan)

---

### **STEP 3: Install Backend Dependencies**

Buka Terminal di VSCode dan jalankan:

```bash
cd backend
npm install
```

Ini akan menginstall:
- express
- mysql2
- cors
- dotenv
- body-parser
- nodemon

**Tunggu sampai selesai!**

---

### **STEP 4: Test Koneksi Database**

Setelah npm install selesai, test koneksi database:

```bash
# Masih di folder backend
node test-connection.js
```

**Jika BERHASIL**, akan muncul:
```
🔍 Testing database connection...

📋 Configuration:
   Host: localhost
   User: root
   Database: gereja_damai_kristus
   Port: 3306
   Password: ***

✅ Database connected successfully!

📊 Finance table has 30 records

🎉 Everything looks good! You can now run: npm run dev
```

**Jika GAGAL**, akan muncul error. Lihat section Troubleshooting di bawah.

---

### **STEP 5: Start Backend Server**

```bash
# Masih di folder backend
npm run dev
```

**Jika BERHASIL**, akan muncul:
```
[nodemon] starting `node server.js`
🚀 Server is running on port 3001
📊 API endpoint: http://localhost:3001/api/finance
💚 Health check: http://localhost:3001/health
✅ Database connected successfully
```

**JANGAN TUTUP TERMINAL INI!** Backend harus tetap jalan.

---

### **STEP 6: Test Backend API**

Buka browser dan akses:

**http://localhost:3001/health**

Seharusnya muncul:
```json
{
  "status": "OK",
  "message": "Gereja Damai Kristus API is running",
  "timestamp": "2025-10-18T..."
}
```

**http://localhost:3001/api/finance/transactions**

Seharusnya muncul data JSON dari database.

**Jika browser tidak bisa akses**, berarti backend belum jalan. Cek lagi terminal backend.

---

### **STEP 7: Refresh Frontend**

Sekarang buka frontend:

**http://localhost:5173**

Klik menu **Finance**

Data seharusnya sudah muncul! ✅

Jika masih error, buka Console (F12) dan lihat error message.

---

## 🔍 TROUBLESHOOTING

### Error 1: "mysql: command not found"

**Masalah:** MySQL belum terinstall atau tidak ada di PATH.

**Solusi:**

**Windows:**
1. Download MySQL: https://dev.mysql.com/downloads/installer/
2. Install MySQL Community Server
3. Tambahkan ke PATH:
   - Cari folder: `C:\Program Files\MySQL\MySQL Server 8.0\bin`
   - Buka Control Panel → System → Advanced → Environment Variables
   - Edit PATH, tambahkan path di atas

**Mac:**
```bash
brew install mysql
```

**Linux:**
```bash
sudo apt-get install mysql-server
```

---

### Error 2: "Error: Access denied for user 'root'@'localhost'"

**Masalah:** Password MySQL salah di file `.env`

**Solusi:**

1. Test login manual:
   ```bash
   mysql -u root -p
   ```
   Masukkan password yang benar.

2. Update file `backend/.env`:
   ```env
   DB_PASSWORD=password_yang_benar
   ```

3. Jika lupa password, reset:
   ```bash
   # Stop MySQL
   net stop MySQL80
   
   # Start in safe mode dan reset
   # (Google: "reset mysql root password")
   ```

---

### Error 3: "Error: Unknown database 'gereja_damai_kristus'"

**Masalah:** Database belum dibuat.

**Solusi:**

```bash
# Login ke MySQL
mysql -u root -p

# Jalankan schema
SOURCE /path/to/your/project/database/schema.sql;

# Atau dari terminal
mysql -u root -p < database/schema.sql

# Verifikasi
mysql -u root -p -e "SHOW DATABASES;"
```

---

### Error 4: "Error: connect ECONNREFUSED 127.0.0.1:3306"

**Masalah:** MySQL service tidak jalan.

**Solusi:**

**Windows:**
```bash
net start MySQL80
```

**Mac:**
```bash
brew services start mysql
```

**Linux:**
```bash
sudo systemctl start mysql
```

**Verifikasi:**
```bash
# Windows
sc query MySQL80

# Mac/Linux
ps aux | grep mysql
```

---

### Error 5: "Cannot find module 'express'"

**Masalah:** Dependencies belum diinstall.

**Solusi:**
```bash
cd backend
npm install
```

---

### Error 6: "nodemon: command not found"

**Masalah:** Nodemon belum terinstall.

**Solusi:**
```bash
cd backend
npm install
```

Atau gunakan:
```bash
npm start
```

---

### Error 7: Backend jalan tapi Frontend masih "Failed to fetch"

**Masalah:** CORS atau port tidak match.

**Solusi:**

1. **Cek backend jalan di port 3001:**
   Buka browser: http://localhost:3001/health

2. **Cek CORS di backend/.env:**
   ```env
   CORS_ORIGIN=http://localhost:5173
   ```

3. **Restart backend:**
   Ctrl+C di terminal backend, lalu:
   ```bash
   npm run dev
   ```

4. **Cek Console di browser (F12):**
   Lihat error message lengkap.

---

## 📋 CHECKLIST DEBUG

Cek satu per satu:

- [ ] MySQL service running → `net start MySQL80`
- [ ] Database exists → `mysql -u root -p -e "SHOW DATABASES;"`
- [ ] File `.env` exists → `ls backend/.env` atau cek di VSCode
- [ ] Password correct in `.env` → Edit `backend/.env`
- [ ] Dependencies installed → `cd backend && npm install`
- [ ] Database connection OK → `node test-connection.js`
- [ ] Backend server running → `npm run dev`
- [ ] Backend API accessible → Browser: http://localhost:3001/health
- [ ] Frontend running → `npm run dev` (di root folder)
- [ ] Frontend accessible → Browser: http://localhost:5173

---

## 🎯 QUICK FIX COMMANDS

Copy-paste semua command ini (satu per satu):

```bash
# 1. Start MySQL
net start MySQL80

# 2. Masuk ke folder backend
cd backend

# 3. Install dependencies
npm install

# 4. Test koneksi (pastikan .env sudah diedit!)
node test-connection.js

# 5. Start backend
npm run dev
```

**Terminal BARU:**
```bash
# 6. Start frontend
npm run dev
```

**Browser:**
```
http://localhost:3001/health
http://localhost:5173
```

---

## 📞 MASIH ERROR?

Jika masih error setelah semua step di atas:

1. **Screenshot error** di terminal backend
2. **Screenshot error** di Console browser (F12)
3. **Copy-paste output** dari `node test-connection.js`
4. **Check:**
   ```bash
   # Apakah MySQL jalan?
   net start MySQL80
   
   # Apakah database ada?
   mysql -u root -p -e "SHOW DATABASES;"
   
   # Apakah backend jalan?
   curl http://localhost:3001/health
   ```

Kirim semua info di atas dan saya akan bantu fix!

---

## ✅ SUCCESS!

Jika semua jalan, Anda akan lihat:

**Terminal Backend:**
```
✅ Database connected successfully
🚀 Server is running on port 3001
```

**Browser (http://localhost:3001/health):**
```json
{"status":"OK","message":"Gereja Damai Kristus API is running"}
```

**Browser (http://localhost:5173 → Finance menu):**
- Tabel transaksi muncul
- Chart muncul
- Summary cards muncul
- Bisa Record Transaction
- Bisa Export Excel

🎉 **SELAMAT! Finance Management sudah jalan dengan MySQL!** 🎉
