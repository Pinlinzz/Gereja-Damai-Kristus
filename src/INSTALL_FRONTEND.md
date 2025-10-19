# Frontend Setup - Gereja Damai Kristus

## Install Excel Export Library

Untuk fitur export ke Excel, install library xlsx:

```bash
npm install xlsx
```

Atau dengan yarn:
```bash
yarn add xlsx
```

## Verifikasi Installation

Setelah install, cek apakah library sudah terinstall:

```bash
npm list xlsx
```

Output seharusnya:
```
gereja-damai-kristus@x.x.x
└── xlsx@0.18.5
```

## Development

```bash
npm run dev
```

Frontend akan berjalan di: `http://localhost:5173`

## Build for Production

```bash
npm run build
```

## Troubleshooting

### Problem: "Cannot find module 'xlsx'"
**Solution**:
```bash
# Hapus node_modules dan install ulang
rm -rf node_modules
npm install
npm install xlsx
```

### Problem: Export tidak berfungsi
**Solution**:
- Pastikan browser mendukung download file
- Cek console browser untuk error
- Pastikan ada data di tabel sebelum export

## Features

✅ Export transaksi ke Excel
✅ Record transaksi baru
✅ View riwayat transaksi
✅ Filter by type (income/expense)
✅ Chart visualisasi keuangan
✅ Real-time data dari MySQL

## API Configuration

File: `/components/Finance.tsx`

```typescript
const API_BASE_URL = 'http://localhost:3001/api/finance';
```

Untuk production, update URL sesuai dengan server backend Anda.

## Browser Support

- Chrome (recommended)
- Firefox
- Safari
- Edge

## Notes

- Pastikan backend sudah running sebelum start frontend
- Backend harus running di port 3001 (default)
- Data akan sync real-time dengan MySQL database
