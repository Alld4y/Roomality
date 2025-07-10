const express = require('express');
const cors = require('cors');
const helmet = require('helmet');
const rateLimit = require('express-rate-limit');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Security middleware
app.use(helmet());
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || ['http://localhost:3000'],
  credentials: true
}));

// Rate limiting
const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
app.use(limiter);

// Body parsing middleware
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// Authentication middleware
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'Access token required' });
  }

  // ตรวจสอบ API key (สำหรับตัวอย่างนี้ใช้แบบง่าย)
  if (token !== process.env.API_KEY) {
    return res.status(403).json({ error: 'Invalid token' });
  }

  next();
};

// Database connection
const { Pool } = require('pg');
const pool = new Pool({
  user: process.env.DB_USER || 'roomality_user',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'roomality',
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT || 5432,
  ssl: process.env.NODE_ENV === 'production' ? { rejectUnauthorized: false } : false
});

// Test database connection
pool.query('SELECT NOW()', (err, res) => {
  if (err) {
    console.error('Database connection error:', err);
  } else {
    console.log('Database connected successfully');
  }
});

// Routes

// Health check
app.get('/api/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Rooms API
app.post('/api/rooms', authenticateToken, async (req, res) => {
  try {
    const { roomName, monthlyPrice, roomStatus, createdAt } = req.body;
    
    // ตรวจสอบ duplicate
    const checkDuplicate = await pool.query(
      'SELECT id FROM rooms WHERE room_name = $1',
      [roomName]
    );
    
    if (checkDuplicate.rows.length > 0) {
      return res.status(409).json({ error: 'Room name already exists' });
    }

    const result = await pool.query(
      'INSERT INTO rooms (room_name, monthly_price, room_status, created_at) VALUES ($1, $2, $3, $4) RETURNING *',
      [roomName, monthlyPrice, roomStatus, createdAt || new Date()]
    );

    res.status(201).json(result.rows[0]);
  } catch (error) {
    console.error('Error creating room:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

app.get('/api/rooms', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT room_name, monthly_price, room_status FROM rooms ORDER BY created_at DESC'
    );
    res.json(result.rows);
  } catch (error) {
    console.error('Error getting rooms:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// HorPuk API
app.post('/api/horpuk', authenticateToken, async (req, res) => {
  const client = await pool.connect();
  try {
    await client.query('BEGIN');
    
    const { horPukName, rows, createdAt } = req.body;
    
    // ตรวจสอบ duplicate
    const checkDuplicate = await client.query(
      'SELECT id FROM horpuk WHERE horpuk_name = $1',
      [horPukName]
    );
    
    if (checkDuplicate.rows.length > 0) {
      await client.query('ROLLBACK');
      return res.status(409).json({ error: 'HorPuk name already exists' });
    }

    // Insert horpuk
    const horpukResult = await client.query(
      'INSERT INTO horpuk (horpuk_name, created_at) VALUES ($1, $2) RETURNING id',
      [horPukName, createdAt || new Date()]
    );
    
    const horpukId = horpukResult.rows[0].id;
    
    // Insert rows, floors, and rooms
    for (const row of rows) {
      const rowResult = await client.query(
        'INSERT INTO horpuk_rows (horpuk_id, row_name) VALUES ($1, $2) RETURNING id',
        [horpukId, row.rowName]
      );
      
      const rowId = rowResult.rows[0].id;
      
      for (const floor of row.floor) {
        const floorResult = await client.query(
          'INSERT INTO horpuk_floors (row_id, floor_name) VALUES ($1, $2) RETURNING id',
          [rowId, floor.floorName]
        );
        
        const floorId = floorResult.rows[0].id;
        
        for (const room of floor.rooms) {
          await client.query(
            'INSERT INTO sub_rooms (floor_id, room_name, monthly_price, deposit_price, rental_start_unix, contract, payment_status) VALUES ($1, $2, $3, $4, $5, $6, $7)',
            [floorId, room.roomName, room.monthlyPrice, room.depositPrice, room.rentalStartUnix, room.contract, room.paymentStatus]
          );
        }
      }
    }
    
    await client.query('COMMIT');
    res.status(201).json({ message: 'HorPuk created successfully', id: horpukId });
  } catch (error) {
    await client.query('ROLLBACK');
    console.error('Error creating horpuk:', error);
    res.status(500).json({ error: 'Internal server error' });
  } finally {
    client.release();
  }
});

app.get('/api/horpuk', authenticateToken, async (req, res) => {
  try {
    const result = await pool.query(`
      SELECT 
        h.id, h.horpuk_name, hr.id as row_id, hr.row_name, 
        hf.id as floor_id, hf.floor_name,
        sr.room_name, sr.monthly_price, sr.deposit_price, 
        sr.rental_start_unix, sr.contract, sr.payment_status
      FROM horpuk h
      LEFT JOIN horpuk_rows hr ON h.id = hr.horpuk_id
      LEFT JOIN horpuk_floors hf ON hr.id = hf.row_id
      LEFT JOIN sub_rooms sr ON hf.id = sr.floor_id
      ORDER BY h.created_at DESC, hr.id, hf.id, sr.id
    `);
    
    // Group results by horpuk
    const horpukMap = new Map();
    
    result.rows.forEach(row => {
      if (!horpukMap.has(row.id)) {
        horpukMap.set(row.id, {
          horPukName: row.horpuk_name,
          rows: []
        });
      }
      
      // Add row, floor, and room data
      // (This is simplified - you'll need to implement proper grouping logic)
    });
    
    res.json(Array.from(horpukMap.values()));
  } catch (error) {
    console.error('Error getting horpuk:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Sync endpoint
app.post('/api/sync', authenticateToken, async (req, res) => {
  try {
    const { timestamp } = req.body;
    console.log(`Sync requested at: ${timestamp}`);
    
    // Implement sync logic here
    // เช่น การ sync ข้อมูลระหว่าง devices
    
    res.json({ message: 'Sync completed', timestamp });
  } catch (error) {
    console.error('Error during sync:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: 'Something broke!' });
});

// 404 handler
app.use('*', (req, res) => {
  res.status(404).json({ error: 'Route not found' });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
  console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
}); 