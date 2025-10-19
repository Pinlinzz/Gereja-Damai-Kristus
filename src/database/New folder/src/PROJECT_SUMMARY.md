# 📊 Gereja Damai Kristus - Finance Management System

## ✅ Project Complete!

Sistem management keuangan untuk Gereja Damai Kristus dengan MySQL database integration.

---

## 🎯 Apa yang Sudah Dibuat

### ✅ Frontend (React + TypeScript + Tailwind)
- **Dashboard** - Overview dengan 3 summary cards (Total Umat, Persembahan Bulanan, Upcoming Events)
- **Events** - Management event gereja
- **Finance** - Management keuangan lengkap dengan MySQL integration
- **Settings** - Pengaturan sistem

### ✅ Backend (Express.js + MySQL)
- REST API lengkap untuk CRUD operations
- MySQL database connection
- API endpoints untuk transaksi, summary, dan reports
- CORS enabled untuk frontend integration

### ✅ Database (MySQL)
- Schema lengkap untuk finance management
- Sample data 6 bulan terakhir
- Table untuk transaksi dan kategori
- Indexes untuk performa optimal

### ✅ Features Finance Module
1. **Record Transaction** - Form untuk input pemasukan/pengeluaran
2. **Export to Excel** - Download laporan ke Excel (XLSX)
3. **Filter & Search** - Filter berdasarkan tipe transaksi
4. **Charts** - Visualisasi bar chart dan line chart
5. **Summary Cards** - 4 metrics utama keuangan
6. **Transaction History** - Table dengan semua transaksi
7. **Real-time Data** - Data sync dengan MySQL database

---

## 📁 Struktur Project

```
gereja-damai-kristus/
│
├── 📄 QUICKSTART.md              ← START HERE! Panduan cepat
├── 📄 SETUP_GUIDE.md             ← Setup lengkap step-by-step
├── 📄 INSTALL_FRONTEND.md        ← Install xlsx library
├── 📄 CHANGELOG.md               ← Daftar perubahan
├── 📄 IMPLEMENTATION_GUIDE.md    ← Panduan implementasi
│
├── 📂 backend/                   ← Backend API
│   ├── config/
│   │   └── database.js          ← MySQL connection
│   ├── routes/
│   │   └── finance.js           ← Finance API routes
│   ├── .env.example             ← Template environment variables
│   ├── .gitignore
│   ├── README.md
│   ├── package.json
│   └── server.js                ← Main server
│
├── 📂 database/                  ← Database files
│   ├── schema.sql               ← Database structure
│   └── seed.sql                 ← Sample data (6 bulan)
│
├── 📂 components/                ← React components
│   ├── Dashboard.tsx            ← Updated (3 summary cards)
│   ├── Events.tsx
│   ├── Finance.tsx              ← NEW! MySQL integration
│   ├── Settings.tsx
│   └── ui/                      ← ShadCN components
│
├── 📂 styles/
│   └── globals.css
│
└── App.tsx                      ← Main app (4 menu)
```

---

## 🚀 Cara Menjalankan

### Quick Start (Singkat)
```bash
# 1. Setup MySQL Database
mysql -u root -p < database/schema.sql
mysql -u root -p gereja_damai_kristus < database/seed.sql

# 2. Start Backend (terminal 1)
cd backend
npm install
cp .env.example .env
# Edit .env dengan password MySQL Anda
npm run dev

# 3. Start Frontend (terminal 2)
npm install xlsx
npm run dev

# 4. Buka browser
# Frontend: http://localhost:5173
# Backend: http://localhost:3001
```

### Detailed Setup
Lihat **SETUP_GUIDE.md** untuk panduan lengkap.

---

## 🔧 Technology Stack

### Frontend
- ⚛️ React 18
- 📘 TypeScript
- 🎨 Tailwind CSS
- 🎯 ShadCN UI Components
- 📊 Recharts (untuk grafik)
- 📑 XLSX (untuk export Excel)

### Backend
- 🚀 Express.js
- 🗄️ MySQL2 (MySQL client)
- 🔐 CORS
- 📦 dotenv
- 🔄 nodemon (development)

### Database
- 🗄️ MySQL 5.7+
- 📊 3 tables: finance, finance_categories, monthly_summary
- 📈 Sample data: 60+ transaksi

---

## 📊 Finance Module Features

### Summary Cards
1. **Total Persembahan Bulanan** - Total pemasukan bulan ini
2. **Total Pengeluaran Bulanan** - Total pengeluaran bulan ini
3. **Total Pengeluaran Tahunan** - Akumulasi pengeluaran tahun ini
4. **Operasional Gereja** - Total biaya operasional

### Charts
1. **Bar Chart** - Perbandingan pemasukan vs pengeluaran per bulan
2. **Line Chart** - Trend keuangan bulanan

### Transaction Management
- ✅ View all transactions
- ✅ Filter by type (income/expense)
- ✅ Add new transaction
- ✅ Real-time sync dengan database

### Export
- ✅ Export semua transaksi ke Excel
- ✅ Format: XLSX dengan kolom lengkap
- ✅ Auto-download dengan nama file berdasarkan tanggal

---

## 🎨 Branding

- **Nama Aplikasi**: Report Gereja Damai
- **Nama Gereja**: Gereja Damai Kristus
- **Mata Uang**: Rupiah (Rp)
- **Format Tanggal**: Indonesia (DD/MM/YYYY)

---

## 📝 Menu Navigasi

1. **Dashboard** - Overview gereja
2. **Events** - Management acara
3. **Finance** - Management keuangan (NEW!)
4. **Settings** - Pengaturan sistem

**Menu yang dihapus:**
- ❌ Members (dihapus sepenuhnya)
- ❌ Communications (dihapus sepenuhnya)
- ❌ Volunteers (dihapus sepenuhnya)

---

## 🗄️ Database Schema

### Table: finance
| Column | Type | Description |
|--------|------|-------------|
| id | INT | Primary key |
| date | DATE | Tanggal transaksi |
| description | VARCHAR(255) | Deskripsi |
| type | ENUM | 'income' atau 'expense' |
| category | VARCHAR(100) | Kategori |
| amount | DECIMAL(15,2) | Jumlah uang |
| notes | TEXT | Catatan tambahan |
| created_at | TIMESTAMP | Waktu dibuat |
| updated_at | TIMESTAMP | Waktu update |

### Sample Categories
**Income:**
- Persembahan
- Perpuluhan
- Sumbangan Khusus
- Building Fund

**Expense:**
- Operasional
- Gaji
- Utilitas
- Pemeliharaan
- Program Gereja
- Sosial

---

## 🔌 API Endpoints

### Base URL: `http://localhost:3001/api/finance`

| Method | Endpoint | Description |
|--------|----------|-------------|
| GET | /transactions | Get all transactions |
| GET | /transactions/:id | Get single transaction |
| POST | /transactions | Create transaction |
| PUT | /transactions/:id | Update transaction |
| DELETE | /transactions/:id | Delete transaction |
| GET | /summary | Get financial summary |
| GET | /monthly | Get monthly data |
| GET | /categories | Get all categories |

---

## ✨ Next Steps (Optional)

### Fitur Tambahan yang Bisa Ditambahkan:
1. 🔐 **User Authentication** - Login system
2. 📧 **Email Notifications** - Auto email report
3. 📱 **Responsive Mobile** - Better mobile UI
4. 🔍 **Advanced Filtering** - Filter by date range, category
5. 📈 **More Reports** - Year-over-year comparison
6. 💾 **Backup Automation** - Auto database backup
7. 🖨️ **Print Reports** - PDF export
8. 📊 **Dashboard Analytics** - More detailed charts
9. 👥 **Multi-user** - Different user roles
10. 🌐 **Deploy to Cloud** - AWS, Heroku, or Vercel

---

## 📞 Support & Documentation

### Dokumentasi
- **Quick Start**: `QUICKSTART.md` - Start here!
- **Full Setup**: `SETUP_GUIDE.md` - Detailed setup
- **Backend**: `backend/README.md` - API documentation
- **Frontend**: `INSTALL_FRONTEND.md` - Frontend setup
- **Changes**: `CHANGELOG.md` - What changed

### Troubleshooting
Lihat section "Troubleshooting" di:
- `SETUP_GUIDE.md`
- `backend/README.md`

---

## 🎉 You're All Set!

Finance Management System untuk Gereja Damai Kristus sudah lengkap dengan:
- ✅ MySQL Database integration
- ✅ Full CRUD operations
- ✅ Export to Excel
- ✅ Beautiful charts
- ✅ Real-time data sync
- ✅ Complete documentation

**Happy Managing! 🙏**

---

## 📄 License

Private - Gereja Damai Kristus  
© 2025 All rights reserved

---

**Need Help?**  
Refer to `QUICKSTART.md` or `SETUP_GUIDE.md`
