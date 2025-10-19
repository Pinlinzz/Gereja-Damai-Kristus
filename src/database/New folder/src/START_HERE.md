# 🚨 MENDAPAT ERROR "FAILED TO FETCH"?

## Baca file ini: **FIX_FAILED_TO_FETCH.md**

Error tersebut berarti backend belum jalan. Ikuti panduan di file `FIX_FAILED_TO_FETCH.md` untuk fix.

---

## ⚡ QUICK START (Jika sudah setup)

### Terminal 1 - Backend:
```bash
cd backend
npm run dev
```

### Terminal 2 - Frontend:
```bash
npm run dev
```

### Browser:
```
http://localhost:5173
```

---

## 🆕 FIRST TIME SETUP

### 1. Start MySQL Service

**Windows:**
```bash
net start MySQL80
```

**Mac:**
```bash
brew services start mysql
```

### 2. Edit Backend .env

Buka file: `backend/.env`

Ganti password MySQL:
```env
DB_PASSWORD=your_mysql_password_here
```

Jika tidak ada password, kosongkan:
```env
DB_PASSWORD=
```

### 3. Install Backend Dependencies

```bash
cd backend
npm install
```

### 4. Test Database Connection

```bash
npm test
```

Atau:
```bash
node test-connection.js
```

Harus muncul:
```
✅ Database connected successfully!
📊 Finance table has 30 records
🎉 Everything looks good!
```

### 5. Start Backend

```bash
npm run dev
```

Harus muncul:
```
🚀 Server is running on port 3001
✅ Database connected successfully
```

**JANGAN TUTUP TERMINAL INI!**

### 6. Test Backend API

Buka browser: **http://localhost:3001/health**

Harus muncul:
```json
{"status":"OK","message":"Gereja Damai Kristus API is running"}
```

### 7. Start Frontend (Terminal Baru)

```bash
# Kembali ke root folder
cd ..

# Install xlsx jika belum
npm install xlsx

# Start frontend
npm run dev
```

### 8. Open Application

Browser: **http://localhost:5173**

Klik menu **Finance** → Data harus muncul!

---

## 📁 FILE PANDUAN LENGKAP

1. **FIX_FAILED_TO_FETCH.md** ⭐ Baca ini jika error!
2. **SETUP_NOW.md** - Setup lengkap step-by-step
3. **JALANKAN_SEKARANG.txt** - Commands copy-paste
4. **PROJECT_SUMMARY.md** - Overview project

---

## 🔍 VERIFIKASI

### Backend Running?
```bash
# Buka browser
http://localhost:3001/health

# Atau curl
curl http://localhost:3001/health
```

### Database OK?
```bash
cd backend
npm test
```

### MySQL Running?
```bash
# Windows
net start MySQL80

# Test login
mysql -u root -p
```

---

## ❌ TROUBLESHOOTING

### Error: "Failed to fetch"
→ **Backend tidak jalan!** Baca: `FIX_FAILED_TO_FETCH.md`

### Error: "Cannot find module 'express'"
```bash
cd backend
npm install
```

### Error: "Access denied for user"
→ **Password salah!** Edit `backend/.env`

### Error: "Unknown database"
→ **Database belum dibuat!** Jalankan:
```bash
mysql -u root -p < database/schema.sql
mysql -u root -p gereja_damai_kristus < database/seed.sql
```

### Error: "connect ECONNREFUSED"
→ **MySQL tidak jalan!** Start MySQL:
```bash
net start MySQL80  # Windows
brew services start mysql  # Mac
```

---

## ✅ CHECKLIST

Setup berhasil jika:
- [ ] MySQL service running
- [ ] Database `gereja_damai_kristus` exists
- [ ] File `backend/.env` dengan password benar
- [ ] `npm install` di folder backend selesai
- [ ] `npm test` di folder backend berhasil
- [ ] Backend running di port 3001
- [ ] http://localhost:3001/health returns JSON
- [ ] Frontend running di port 5173
- [ ] http://localhost:5173 → Finance menu shows data

---

## 🎯 DAILY USE

Setiap kali mau pakai aplikasi:

```bash
# Terminal 1
cd backend
npm run dev

# Terminal 2 (baru)
npm run dev

# Browser
http://localhost:5173
```

---

## 📞 BANTUAN

Masih error? Screenshot dan kirim:
1. Output dari `npm test` di folder backend
2. Error message di terminal backend
3. Error message di Console browser (F12)
4. Output dari `net start MySQL80`

---

**MULAI DARI SINI:**
👉 Baca file **FIX_FAILED_TO_FETCH.md** untuk fix error Anda! 👈
