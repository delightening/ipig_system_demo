# iPig System Demo

這是一個可執行的公開 Demo，用於展示 Dashboard、HR、考勤等模組的流程與介面。  
不包含正式環境設定與任何敏感資訊。

## Requirements

- [Git](https://git-scm.com/)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

## Quick Start

### Windows (PowerShell)

```powershell
# 1. Clone the repository
git clone https://github.com/delightening/ipig_system_demo.git
cd ipig_system_demo

# 2. Run initialization script
.\scripts\init_demo_db.ps1

# Or manually:
# cp .env.demo .env
# docker compose -f docker-compose.demo.yml up -d --build
```

### Linux / macOS

```bash
# 1. Clone the repository
git clone https://github.com/delightening/ipig_system_demo.git
cd ipig_system_demo

# 2. Setup environment
cp .env.demo .env

# 3. Start services
docker compose -f docker-compose.demo.yml up -d --build
```

## Access

| Service  | URL                     |
|----------|-------------------------|
| Frontend | http://localhost:8080   |
| Backend  | http://localhost:8000   |

## Demo Account

| Role  | Username    | Password    |
|-------|-------------|-------------|
| Admin | demo_admin  | demo_admin  |

## Common Commands

```bash
# View logs
docker compose -f docker-compose.demo.yml logs -f

# Stop all services
docker compose -f docker-compose.demo.yml down

# Rebuild and restart
docker compose -f docker-compose.demo.yml up -d --build

# Clean everything (including data)
docker compose -f docker-compose.demo.yml down -v
```

## Troubleshooting

### Port Conflicts

If ports 8080 or 8000 are already in use, edit `docker-compose.demo.yml`:

```yaml
ports:
  - "8081:8000"  # Change 8000 to another port
```

### Database Connection Issues

```bash
# Check database status
docker compose -f docker-compose.demo.yml ps

# View database logs
docker compose -f docker-compose.demo.yml logs db
```

### Container Startup Issues

```bash
# Rebuild from scratch
docker compose -f docker-compose.demo.yml down -v
docker compose -f docker-compose.demo.yml up -d --build
```

## Features Included

- ✅ Dashboard with widgets
- ✅ HR module (attendance, leave management)
- ✅ User management
- ✅ Role-based access control

## Features Disabled (Demo Mode)

- ❌ Google Calendar sync
- ❌ Email sending (SMTP)
- ❌ External webhooks

---

> **Note**: This is a demo version. All data is for demonstration purposes only.
