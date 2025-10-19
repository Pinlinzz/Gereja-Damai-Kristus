# 🚀 Setup Backend & Frontend - SEKARANG!

## ✅ Database sudah siap!

Sekarang kita setup backend dan frontend.

---

## 📋 STEP 1: Setup Backend

### 1. Buka Terminal di VSCode
**Windows**: `Ctrl + ~`  
**Mac**: `Cmd + ~`

### 2. Edit file `.env` di folder backend

File sudah dibuat: `backend/.env`

**PENTING**: Buka file itu dan edit password MySQL Anda!

```env
DB_PASSWORD=           ← KOSONGKAN jika tidak ada password
                          atau ISI dengan password MySQL Anda
```

Contoh jika password MySQL = `admin123`:
```env
DB_PASSWORD=admin123
```

Contoh jika TIDAK ADA password (default):
```env
DB_PASSWORD=
```

### 3. Install Dependencies Backend

```bash
cd backend
npm install
```

Dependencies yang akan diinstall:
- express
- mysql2
- cors
- dotenv
- body-parser
- nodemon (dev)

**Tunggu sampai selesai!** ⏳

### 4. Test Database Connection

```bash
node -e "require('./config/database')"
```

Jika berhasil akan muncul:
```
✅ Database connected successfully
```

Jika muncul error, cek:
- MySQL service sudah jalan?
- Password di `.env` sudah benar?
- Database `gereja_damai_kristus` sudah dibuat?

### 5. Start Backend Server

```bash
npm run dev
```

Akan muncul:
```
🚀 Server is running on port 3001
📊 API endpoint: http://localhost:3001/api/finance
💚 Health check: http://localhost:3001/health
✅ Database connected successfully
```

**JANGAN TUTUP TERMINAL INI!** Backend harus tetap jalan.

---

## 📋 STEP 2: Setup Frontend

### 1. Buka Terminal BARU di VSCode

Klik icon **+** di terminal untuk buka terminal baru.

### 2. Kembali ke Root Directory

```bash
cd ..
```

Atau jika masih di backend:
```bash
cd ..
```

### 3. Install Library XLSX

```bash
npm install xlsx
```

### 4. Start Frontend

```bash
npm run dev
```

Akan muncul:
```
  VITE v5.x.x  ready in xxx ms

  ➜  Local:   http://localhost:5173/
```

---

## 📋 STEP 3: Test Aplikasi

### 1. Buka Browser

Buka: **http://localhost:5173**

### 2. Klik Menu "Finance"

Data dari database MySQL seharusnya muncul!

### 3. Test Fitur

✅ **View Data** - Lihat transaksi dari database  
✅ **Record Transaction** - Tambah transaksi baru  
✅ **Export to Excel** - Download laporan  
✅ **Filter** - Filter by income/expense  
✅ **Charts** - Lihat grafik keuangan  

---

## 🔧 Troubleshooting

### Problem 1: "Cannot find module 'express'"
**Solution**:
```bash
cd backend
npm install
```

### Problem 2: "Error connecting to database"
**Solution**:
1. Cek MySQL service jalan:
   ```bash
   # Windows
   net start MySQL80
   
   # Mac
   brew services start mysql
   ```

2. Cek password di `backend/.env` sudah benar

3. Test manual:
   ```bash
   mysql -u root -p gereja_damai_kristus
   ```

### Problem 3: "Module 'xlsx' not found"
**Solution**:
```bash
npm install xlsx
```

### Problem 4: Data tidak muncul di Finance
**Solution**:
1. Cek backend jalan di terminal (ada tulisan "Server is running")
2. Test API: buka browser `http://localhost:3001/health`
3. Buka Console di browser (F12) → cek ada error?
4. Verifikasi data di MySQL:
   ```sql
   mysql -u root -p
   USE gereja_damai_kristus;
   SELECT COUNT(*) FROM finance;
   ```

### Problem 5: CORS Error
**Solution**:
Backend sudah jalan? Port 3001?
```bash
# Terminal backend - pastikan ada tulisan ini:
✅ Database connected successfully
🚀 Server is running on port 3001
```

---

## 📂 Terminal Setup

Seharusnya Anda punya **2 terminal** aktif:

**Terminal 1 - Backend:**
```
gereja-damai/backend> npm run dev

> gereja-damai-kristus-backend@1.0.0 dev
> nodemon server.js

[nodemon] starting `node server.js`
🚀 Server is running on port 3001
✅ Database connected successfully
```

**Terminal 2 - Frontend:**
```
gereja-damai> npm run dev

  VITE v5.x.x  ready in 234 ms

  ➜  Local:   http://localhost:5173/
  ➜  Network: use --host to expose
```

---

## ✅ Success Checklist

- [ ] MySQL service running
- [ ] Database `gereja_damai_kristus` exists
- [ ] Data sudah ada di table `finance`
- [ ] File `backend/.env` sudah diedit (password)
- [ ] Backend dependencies installed (`npm install`)
- [ ] Backend server running (port 3001)
- [ ] XLSX library installed (`npm install xlsx`)
- [ ] Frontend running (port 5173)
- [ ] Browser terbuka: http://localhost:5173
- [ ] Menu Finance menampilkan data dari database

---

## 🎯 Quick Commands

**Start Backend:**
```bash
cd backend
npm run dev
```

**Start Frontend (terminal baru):**
```bash
npm run dev
```

**Test API:**
```bash
# Browser
http://localhost:3001/health
http://localhost:3001/api/finance/transactions

# atau curl
curl http://localhost:3001/health
```

**Verifikasi Database:**
```bash
mysql -u root -p -e "USE gereja_damai_kristus; SELECT COUNT(*) FROM finance;"
```

---

## 🎊 Selesai!

Jika semua berjalan lancar:
- ✅ Backend API running di port 3001
- ✅ Frontend running di port 5173  
- ✅ Data dari MySQL muncul di menu Finance
- ✅ Bisa tambah transaksi baru
- ✅ Bisa export ke Excel

**Selamat! Finance Management System sudah jalan!** 🎉

---

**Masih ada masalah?**
Screenshot error dan tanyakan! 📸
