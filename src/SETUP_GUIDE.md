# Setup Guide - Gereja Damai Kristus Finance Management System

## Prerequisites

Pastikan Anda sudah menginstall:
- ✅ Node.js (v16 atau lebih tinggi)
- ✅ MySQL (v5.7 atau lebih tinggi)
- ✅ npm atau yarn

## 🗄️ Setup Database MySQL

### 1. Install MySQL
Jika belum punya MySQL, download dan install dari:
- **Windows/Mac**: https://dev.mysql.com/downloads/mysql/
- **Linux**: `sudo apt-get install mysql-server`

### 2. Start MySQL Service
```bash
# Windows
net start MySQL

# Mac
brew services start mysql

# Linux
sudo systemctl start mysql
```

### 3. Login ke MySQL
```bash
mysql -u root -p
```

### 4. Buat Database dan Table
```bash
# Jalankan schema.sql
mysql -u root -p < database/schema.sql

# Atau copy-paste isi file schema.sql di MySQL prompt
```

### 5. Insert Data Sample
```bash
# Jalankan seed.sql
mysql -u root -p gereja_damai_kristus < database/seed.sql

# Atau copy-paste isi file seed.sql di MySQL prompt
```

### 6. Verifikasi Database
```sql
USE gereja_damai_kristus;

-- Lihat tabel yang sudah dibuat
SHOW TABLES;

-- Cek data di tabel finance
SELECT COUNT(*) FROM finance;

-- Lihat beberapa data sample
SELECT * FROM finance LIMIT 10;
```

## 🚀 Setup Backend API

### 1. Navigate to Backend Directory
```bash
cd backend
```

### 2. Install Dependencies
```bash
npm install
```

### 3. Setup Environment Variables
```bash
# Copy file .env.example menjadi .env
cp .env.example .env

# Edit file .env dan sesuaikan dengan konfigurasi MySQL Anda
nano .env
```

Isi file `.env`:
```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_mysql_password
DB_NAME=gereja_damai_kristus
DB_PORT=3306

PORT=3001
NODE_ENV=development

CORS_ORIGIN=http://localhost:5173
```

### 4. Test Database Connection
```bash
node -e "require('./config/database')"
```

Jika berhasil, akan muncul: `✅ Database connected successfully`

### 5. Start Backend Server
```bash
# Development mode (dengan auto-reload)
npm run dev

# Production mode
npm start
```

Server akan berjalan di: `http://localhost:3001`

### 6. Test API
Buka browser atau gunakan curl:
```bash
# Health check
curl http://localhost:3001/health

# Get all transactions
curl http://localhost:3001/api/finance/transactions

# Get summary
curl http://localhost:3001/api/finance/summary
```

## 💻 Setup Frontend

### 1. Navigate to Project Root
```bash
cd ..  # Kembali ke root directory
```

### 2. Install xlsx untuk Excel Export
```bash
npm install xlsx
```

### 3. Update API_BASE_URL (Jika Perlu)
Buka `/components/Finance.tsx` dan pastikan `API_BASE_URL` sesuai:
```typescript
const API_BASE_URL = 'http://localhost:3001/api/finance';
```

### 4. Start Frontend
```bash
npm run dev
```

Frontend akan berjalan di: `http://localhost:5173`

## 📊 Testing

### 1. Test Frontend-Backend Connection
1. Buka browser: `http://localhost:5173`
2. Klik menu "Finance"
3. Data seharusnya muncul dari database MySQL

### 2. Test Record Transaction
1. Klik tombol "Record Transaction"
2. Isi form dengan data:
   - Type: Pemasukan
   - Tanggal: Hari ini
   - Deskripsi: Test Persembahan
   - Kategori: Persembahan
   - Jumlah: 1000000
   - Catatan: Testing
3. Klik "Simpan"
4. Data baru seharusnya muncul di tabel

### 3. Test Export to Excel
1. Klik tombol "Export to Excel"
2. File Excel seharusnya terdownload otomatis
3. Buka file Excel dan verifikasi data

## 🔧 Troubleshooting

### Problem: "Access denied for user 'root'@'localhost'"
**Solution**: 
```sql
-- Reset password MySQL
ALTER USER 'root'@'localhost' IDENTIFIED BY 'new_password';
FLUSH PRIVILEGES;
```

### Problem: "Cannot connect to MySQL server"
**Solution**:
```bash
# Cek status MySQL
sudo systemctl status mysql

# Start MySQL
sudo systemctl start mysql
```

### Problem: "CORS Error"
**Solution**:
- Pastikan backend sudah jalan di port 3001
- Cek `CORS_ORIGIN` di file `.env` backend
- Pastikan match dengan port frontend

### Problem: "Module 'xlsx' not found"
**Solution**:
```bash
npm install xlsx
```

### Problem: Backend error "Cannot find module 'express'"
**Solution**:
```bash
cd backend
npm install
```

## 📁 Project Structure

```
├── backend/                    # Backend API (Express.js)
│   ├── config/
│   │   └── database.js        # MySQL connection
│   ├── routes/
│   │   └── finance.js         # Finance API routes
│   ├── .env                   # Environment variables (create this)
│   ├── .env.example           # Environment template
│   ├── package.json
│   └── server.js              # Main server file
│
├── database/                  # Database files
│   ├── schema.sql            # Database schema
│   └── seed.sql              # Sample data
│
├── components/
│   ├── Finance.tsx           # Finance component (updated)
│   └── ...
│
└── ...
```

## 🔐 Security Best Practices

1. **Jangan commit file `.env`** ke Git
   ```bash
   # Tambahkan ke .gitignore
   echo "backend/.env" >> .gitignore
   ```

2. **Gunakan password yang kuat** untuk MySQL

3. **Untuk production**:
   - Gunakan environment variables
   - Setup HTTPS
   - Implementasi authentication/authorization
   - Rate limiting
   - Input validation

## 📝 API Endpoints

### Transactions
- `GET /api/finance/transactions` - Get all transactions
- `GET /api/finance/transactions/:id` - Get single transaction
- `POST /api/finance/transactions` - Create new transaction
- `PUT /api/finance/transactions/:id` - Update transaction
- `DELETE /api/finance/transactions/:id` - Delete transaction

### Summary & Reports
- `GET /api/finance/summary` - Get financial summary
- `GET /api/finance/monthly` - Get monthly data for charts
- `GET /api/finance/categories` - Get all categories

### Query Parameters
```
?type=income|expense        # Filter by type
?startDate=2025-01-01      # Filter by start date
?endDate=2025-12-31        # Filter by end date
?limit=50                  # Limit results
?year=2025                 # Filter by year
?month=1                   # Filter by month
```

## 🎯 Next Steps

1. ✅ Setup database
2. ✅ Setup backend API
3. ✅ Setup frontend
4. ✅ Test all features
5. 🔜 Deploy to production (optional)
6. 🔜 Add user authentication (optional)
7. 🔜 Add backup automation (optional)

## 📞 Support

Jika ada masalah, cek:
1. MySQL service sudah running
2. Backend server sudah running di port 3001
3. Frontend dev server sudah running di port 5173
4. Semua dependencies sudah terinstall
5. File `.env` sudah dikonfigurasi dengan benar

---

**Selamat menggunakan Finance Management System!** 🎉
