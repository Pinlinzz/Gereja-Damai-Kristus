# 🚀 Quick Start Guide

Panduan cepat untuk menjalankan Finance Management System Gereja Damai Kristus.

## ⚡ TL;DR

```bash
# 1. Setup Database
mysql -u root -p < database/schema.sql
mysql -u root -p gereja_damai_kristus < database/seed.sql

# 2. Setup Backend
cd backend
npm install
cp .env.example .env
# Edit .env dengan konfigurasi MySQL Anda
npm run dev

# 3. Setup Frontend (terminal baru)
cd ..
npm install xlsx
npm run dev
```

## 📋 Checklist

### Prerequisites
- [ ] MySQL installed and running
- [ ] Node.js v16+ installed
- [ ] npm installed

### Database Setup
- [ ] MySQL service running
- [ ] Database `gereja_damai_kristus` created
- [ ] Tables created (schema.sql)
- [ ] Sample data inserted (seed.sql)
- [ ] Can connect to MySQL

### Backend Setup
- [ ] Dependencies installed (`npm install`)
- [ ] `.env` file created and configured
- [ ] Database connection successful
- [ ] Server running on port 3001
- [ ] API responding (`http://localhost:3001/health`)

### Frontend Setup
- [ ] xlsx library installed
- [ ] Frontend running on port 5173
- [ ] Can access Finance page
- [ ] Data loads from database
- [ ] Can create new transaction
- [ ] Can export to Excel

## 🎯 Test Everything Works

### 1. Backend Test
```bash
curl http://localhost:3001/health
# Should return: {"status":"OK", ...}

curl http://localhost:3001/api/finance/transactions
# Should return: {"success":true,"data":[...]}
```

### 2. Frontend Test
1. Buka: `http://localhost:5173`
2. Klik menu "Finance"
3. Lihat data muncul di tabel
4. Klik "Record Transaction" dan buat transaksi baru
5. Klik "Export to Excel" dan download file

## 🔧 If Something Goes Wrong

### MySQL tidak jalan
```bash
# Windows
net start MySQL

# Mac
brew services start mysql

# Linux
sudo systemctl start mysql
```

### Backend error
```bash
cd backend
rm -rf node_modules
npm install
npm run dev
```

### Frontend error
```bash
rm -rf node_modules
npm install
npm install xlsx
npm run dev
```

## 📞 Help

Lihat dokumentasi lengkap:
- **Full Setup**: `SETUP_GUIDE.md`
- **Backend**: `backend/README.md`
- **Frontend**: `INSTALL_FRONTEND.md`
- **Database**: `database/schema.sql` dan `database/seed.sql`

## 🎉 Success!

Jika semua checklist ✅, Finance Management System sudah siap digunakan!

**Default Access:**
- Frontend: http://localhost:5173
- Backend API: http://localhost:3001
- Database: localhost:3306

**Default Credentials:**
- MySQL user: root
- MySQL password: (sesuai instalasi Anda)
- Database: gereja_damai_kristus
