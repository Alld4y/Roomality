# Roomality Backend API Server

Backend API server สำหรับ Roomality Flutter app

## 🚀 การติดตั้ง

### 1. ติดตั้ง Dependencies
```bash
npm install
```

### 2. ตั้งค่า Environment Variables
```bash
cp env.example .env
# แก้ไขไฟล์ .env ตามการตั้งค่าของคุณ
```

### 3. ตั้งค่า Database
```bash
# ติดตั้ง PostgreSQL
sudo apt update
sudo apt install postgresql postgresql-contrib

# สร้าง Database และ User
sudo -u postgres psql
CREATE DATABASE roomality;
CREATE USER roomality_user WITH PASSWORD 'your_secure_password';
GRANT ALL PRIVILEGES ON DATABASE roomality TO roomality_user;
\q

# สร้าง Tables (รัน SQL scripts)
psql -h localhost -U roomality_user -d roomality -f database/schema.sql
```

### 4. รัน Server
```bash
# Development
npm run dev

# Production
npm start
```

## 🔧 การตั้งค่า Production

### 1. ใช้ PM2 สำหรับ Process Management
```bash
npm install -g pm2
pm2 start server.js --name "roomality-api"
pm2 startup
pm2 save
```

### 2. ตั้งค่า Nginx Reverse Proxy
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        proxy_cache_bypass $http_upgrade;
    }
}
```

### 3. ตั้งค่า SSL (Let's Encrypt)
```bash
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

## 📡 API Endpoints

### Authentication
ทุก request ต้องมี Authorization header:
```
Authorization: Bearer your_api_key
```

### Rooms
- `POST /api/rooms` - สร้างห้องใหม่
- `GET /api/rooms` - ดึงรายการห้องทั้งหมด

### HorPuk
- `POST /api/horpuk` - สร้างหอพักใหม่
- `GET /api/horpuk` - ดึงรายการหอพักทั้งหมด

### Sync
- `POST /api/sync` - Sync ข้อมูล

### Health Check
- `GET /api/health` - ตรวจสอบสถานะ server

## 🔒 Security Features

- **Helmet.js** - Security headers
- **CORS** - Cross-origin resource sharing
- **Rate Limiting** - ป้องกัน DDoS
- **API Key Authentication** - ตรวจสอบสิทธิ์
- **Input Validation** - ตรวจสอบข้อมูล input
- **SQL Injection Protection** - ใช้ parameterized queries

## 📊 Monitoring

### Logs
```bash
# PM2 logs
pm2 logs roomality-api

# Nginx logs
sudo tail -f /var/log/nginx/access.log
sudo tail -f /var/log/nginx/error.log
```

### Database Monitoring
```bash
# Check connections
psql -h localhost -U roomality_user -d roomality -c "SELECT * FROM pg_stat_activity;"

# Check table sizes
psql -h localhost -U roomality_user -d roomality -c "SELECT schemaname, tablename, pg_size_pretty(pg_total_relation_size(schemaname||'.'||tablename)) AS size FROM pg_tables WHERE schemaname = 'public';"
```

## 🔄 Backup

### Database Backup
```bash
# Create backup
pg_dump -h localhost -U roomality_user roomality > backup_$(date +%Y%m%d_%H%M%S).sql

# Restore backup
psql -h localhost -U roomality_user roomality < backup_file.sql
```

### Auto Backup Script
```bash
#!/bin/bash
BACKUP_DIR="/path/to/backups"
DATE=$(date +%Y%m%d_%H%M%S)
pg_dump -h localhost -U roomality_user roomality > $BACKUP_DIR/backup_$DATE.sql

# Keep only last 7 days
find $BACKUP_DIR -name "backup_*.sql" -mtime +7 -delete
```

## 🚨 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - ตรวจสอบ PostgreSQL service: `sudo systemctl status postgresql`
   - ตรวจสอบ connection settings ใน .env

2. **Permission Denied**
   - ตรวจสอบ file permissions: `chmod 600 .env`
   - ตรวจสอบ database user permissions

3. **Port Already in Use**
   - ตรวจสอบ process: `lsof -i :3000`
   - Kill process: `kill -9 PID`

4. **CORS Error**
   - ตรวจสอบ ALLOWED_ORIGINS ใน .env
   - ตรวจสอบ Nginx configuration 