# Backend API - Gereja Damai Kristus Finance Management

Backend API menggunakan Express.js dan MySQL untuk mengelola data keuangan gereja.

## Quick Start

### 1. Install Dependencies
```bash
npm install
```

### 2. Setup Environment
```bash
cp .env.example .env
# Edit .env dengan konfigurasi MySQL Anda
```

### 3. Setup Database
```bash
# Jalankan dari root directory project
mysql -u root -p < ../database/schema.sql
mysql -u root -p gereja_damai_kristus < ../database/seed.sql
```

### 4. Start Server
```bash
# Development
npm run dev

# Production
npm start
```

## API Endpoints

### Health Check
```
GET /health
```

### Transactions

**Get All Transactions**
```
GET /api/finance/transactions
Query params: ?type=income|expense&startDate=2025-01-01&endDate=2025-12-31&limit=50
```

**Get Single Transaction**
```
GET /api/finance/transactions/:id
```

**Create Transaction**
```
POST /api/finance/transactions
Body: {
  "date": "2025-01-26",
  "description": "Persembahan Minggu",
  "type": "income",
  "category": "Persembahan",
  "amount": 5000000,
  "notes": "Optional notes"
}
```

**Update Transaction**
```
PUT /api/finance/transactions/:id
Body: { same as create }
```

**Delete Transaction**
```
DELETE /api/finance/transactions/:id
```

### Summary & Reports

**Get Summary**
```
GET /api/finance/summary
Query params: ?year=2025&month=1
```

**Get Monthly Data**
```
GET /api/finance/monthly
Query params: ?year=2025
```

**Get Categories**
```
GET /api/finance/categories
Query params: ?type=income|expense
```

## Environment Variables

```env
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=your_password
DB_NAME=gereja_damai_kristus
DB_PORT=3306

PORT=3001
NODE_ENV=development

CORS_ORIGIN=http://localhost:5173
```

## Database Schema

### finance table
- `id` - Primary key
- `date` - Transaction date
- `description` - Description
- `type` - 'income' or 'expense'
- `category` - Category name
- `amount` - Amount (DECIMAL)
- `notes` - Optional notes
- `created_at` - Timestamp
- `updated_at` - Timestamp

### finance_categories table
- `id` - Primary key
- `name` - Category name
- `type` - 'income' or 'expense'
- `description` - Optional description
- `created_at` - Timestamp

## Response Format

**Success Response**
```json
{
  "success": true,
  "data": { ... }
}
```

**Error Response**
```json
{
  "success": false,
  "error": "Error message"
}
```

## Testing

### Using curl
```bash
# Get all transactions
curl http://localhost:3001/api/finance/transactions

# Create new transaction
curl -X POST http://localhost:3001/api/finance/transactions \
  -H "Content-Type: application/json" \
  -d '{
    "date": "2025-01-26",
    "description": "Test",
    "type": "income",
    "category": "Persembahan",
    "amount": 1000000
  }'
```

### Using Postman
Import collection dan test semua endpoints.

## Dependencies

- **express** - Web framework
- **mysql2** - MySQL client
- **cors** - Enable CORS
- **dotenv** - Environment variables
- **body-parser** - Parse request body

## Development

```bash
npm run dev  # Run with nodemon (auto-reload)
```

## Production

```bash
npm start  # Run with node
```

## License

Private - Gereja Damai Kristus
