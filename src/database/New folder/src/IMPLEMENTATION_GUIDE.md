# Implementation Guide - Finance Module

## 1. Setup Excel Export

### Install Dependencies
```bash
npm install xlsx
npm install @types/xlsx --save-dev
```

### Update Finance.tsx untuk Export Functionality

Tambahkan import di bagian atas file:
```typescript
import * as XLSX from 'xlsx';
```

Update fungsi `exportToExcel`:
```typescript
const exportToExcel = () => {
  // Prepare data for export
  const exportData = financeData.map(item => ({
    'Tanggal': new Date(item.date).toLocaleDateString('id-ID'),
    'Deskripsi': item.description,
    'Tipe': item.type === 'income' ? 'Pemasukan' : 'Pengeluaran',
    'Kategori': item.category,
    'Jumlah': item.amount
  }));

  // Create worksheet
  const ws = XLSX.utils.json_to_sheet(exportData);
  
  // Create workbook
  const wb = XLSX.utils.book_new();
  XLSX.utils.book_append_sheet(wb, ws, 'Laporan Keuangan');
  
  // Generate filename with current date
  const fileName = `Laporan_Keuangan_${new Date().toLocaleDateString('id-ID').replace(/\//g, '-')}.xlsx`;
  
  // Save file
  XLSX.writeFile(wb, fileName);
};
```

## 2. Database Integration dengan Supabase

### Setup Supabase (Recommended)

1. **Create Table in Supabase**:
```sql
CREATE TABLE finance (
  id SERIAL PRIMARY KEY,
  date DATE NOT NULL,
  description TEXT NOT NULL,
  type VARCHAR(20) CHECK (type IN ('income', 'expense')) NOT NULL,
  category VARCHAR(100) NOT NULL,
  amount DECIMAL(15, 2) NOT NULL,
  notes TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Add index for better performance
CREATE INDEX idx_finance_date ON finance(date DESC);
CREATE INDEX idx_finance_type ON finance(type);
```

2. **Install Supabase Client**:
```bash
npm install @supabase/supabase-js
```

3. **Create Supabase Client** (`/lib/supabase.ts`):
```typescript
import { createClient } from '@supabase/supabase-js';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const supabaseKey = process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY || '';

export const supabase = createClient(supabaseUrl, supabaseKey);
```

4. **Update Finance.tsx dengan Supabase**:

```typescript
import { supabase } from '../lib/supabase';
import { useEffect, useState } from 'react';

export function Finance() {
  const [financeData, setFinanceData] = useState([]);
  const [loading, setLoading] = useState(true);

  // Fetch data from database
  useEffect(() => {
    fetchFinanceData();
  }, []);

  const fetchFinanceData = async () => {
    try {
      setLoading(true);
      const { data, error } = await supabase
        .from('finance')
        .select('*')
        .order('date', { ascending: false });

      if (error) throw error;
      
      setFinanceData(data || []);
    } catch (error) {
      console.error('Error fetching finance data:', error);
      alert('Error loading data');
    } finally {
      setLoading(false);
    }
  };

  const handleRecordSubmit = async (formData) => {
    try {
      const { data, error } = await supabase
        .from('finance')
        .insert([
          {
            date: formData.date,
            description: formData.description,
            type: formData.type,
            category: formData.category,
            amount: parseFloat(formData.amount),
            notes: formData.notes
          }
        ]);

      if (error) throw error;

      alert('Transaction saved successfully!');
      setIsRecordDialogOpen(false);
      
      // Refresh data
      fetchFinanceData();
    } catch (error) {
      console.error('Error saving transaction:', error);
      alert('Error saving transaction');
    }
  };

  // ... rest of component
}
```

## 3. Alternative: Local Database dengan SQL

Jika menggunakan database lokal (MySQL/PostgreSQL):

### Create API Routes

**Backend (Express.js example)**:

```javascript
// routes/finance.js
const express = require('express');
const router = express.Router();
const db = require('../config/database');

// GET all transactions
router.get('/transactions', async (req, res) => {
  try {
    const [rows] = await db.query(
      'SELECT * FROM finance ORDER BY date DESC'
    );
    res.json(rows);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
}); 

// POST new transaction
router.post('/transactions', async (req, res) => {
  try {
    const { date, description, type, category, amount, notes } = req.body;
    
    const [result] = await db.query(
      'INSERT INTO finance (date, description, type, category, amount, notes) VALUES (?, ?, ?, ?, ?, ?)',
      [date, description, type, category, amount, notes]
    );
    
    res.json({ success: true, id: result.insertId });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

module.exports = router;
```

**Frontend (Finance.tsx)**:

```typescript
const handleRecordSubmit = async () => {
  const formData = {
    date: document.getElementById('date').value,
    description: document.getElementById('description').value,
    type: transactionType,
    category: document.getElementById('category').value,
    amount: document.getElementById('amount').value,
    notes: document.getElementById('notes').value
  };

  try {
    const response = await fetch('/api/finance/transactions', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(formData)
    });

    if (!response.ok) throw new Error('Failed to save');

    alert('Transaction saved successfully!');
    setIsRecordDialogOpen(false);
    
    // Refresh data
    fetchFinanceData();
  } catch (error) {
    console.error('Error:', error);
    alert('Error saving transaction');
  }
};
```

## 4. Import Data dari finance.sql

Jika Anda sudah punya file `finance.sql`:

1. **Via MySQL Command Line**:
```bash
mysql -u username -p database_name < finance.sql
```

2. **Via Supabase Dashboard**:
- Go to SQL Editor
- Paste your SQL content
- Run query

## 5. Testing

### Test Export Function
```typescript
// Add test data
const testData = [
  { date: '2025-01-26', description: 'Test', type: 'income', category: 'Persembahan', amount: 1000000 }
];

// Click Export button and verify Excel file is downloaded
```

### Test Database Integration
```typescript
// Test inserting data
// Test fetching data
// Test updating data
// Test filtering data
```

## 6. Environment Variables

Create `.env.local` file:
```env
NEXT_PUBLIC_SUPABASE_URL=your_supabase_url
NEXT_PUBLIC_SUPABASE_ANON_KEY=your_supabase_anon_key

# Or for custom API
API_BASE_URL=http://localhost:3001/api
```

## Next Steps

1. ✅ Setup database (Supabase or local)
2. ✅ Install xlsx library for Excel export
3. ✅ Implement API endpoints or Supabase integration
4. ✅ Test Export to Excel functionality
5. ✅ Test Record Transaction with database
6. ✅ Import existing data from finance.sql
7. ✅ Add error handling and loading states
8. ✅ Add data validation

## Notes

- Pastikan format tanggal konsisten (YYYY-MM-DD)
- Validasi input amount (harus angka positif)
- Tambahkan confirmation dialog untuk hapus data
- Implementasikan pagination untuk data yang banyak
- Tambahkan filter berdasarkan tanggal range
