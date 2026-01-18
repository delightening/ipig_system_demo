# ==============================================
# iPig System Demo - Database Initialization Script
# ==============================================
# Usage: .\scripts\init_demo_db.ps1
# ==============================================

param(
    [string]$ProjectRoot = (Split-Path -Parent $PSScriptRoot)
)

Write-Host ""
Write-Host "==============================================`n"
Write-Host "  iPig System Demo - Initialization Script"
Write-Host "`n=============================================="
Write-Host ""

# Change to project root
Set-Location $ProjectRoot
Write-Host "[1/5] Working directory: $ProjectRoot"

# Create .env from .env.demo if missing
if (!(Test-Path "$ProjectRoot\.env")) {
    if (Test-Path "$ProjectRoot\.env.demo") {
        Copy-Item "$ProjectRoot\.env.demo" "$ProjectRoot\.env"
        Write-Host "[2/5] Created .env from .env.demo"
    } else {
        Write-Host "[2/5] ERROR: .env.demo not found!" -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "[2/5] .env already exists, skipping..."
}

# Start database container
Write-Host "[3/5] Starting database container..."
docker compose -f docker-compose.demo.yml up -d db

# Wait for database to be ready
Write-Host "[4/5] Waiting for database to be ready..."
$maxRetries = 30
$retryCount = 0
while ($retryCount -lt $maxRetries) {
    $result = docker compose -f docker-compose.demo.yml exec -T db pg_isready -U postgres -d ipig_demo 2>$null
    if ($LASTEXITCODE -eq 0) {
        Write-Host "      Database is ready!"
        break
    }
    $retryCount++
    Write-Host "      Waiting... ($retryCount/$maxRetries)"
    Start-Sleep -Seconds 2
}

if ($retryCount -ge $maxRetries) {
    Write-Host "[4/5] ERROR: Database did not become ready in time!" -ForegroundColor Red
    exit 1
}

# Start all services
Write-Host "[5/5] Starting all services..."
docker compose -f docker-compose.demo.yml up -d --build

Write-Host ""
Write-Host "=============================================="
Write-Host "  Demo environment is ready!"
Write-Host "=============================================="
Write-Host ""
Write-Host "  Frontend: http://localhost:8080"
Write-Host "  Backend:  http://localhost:8000"
Write-Host ""
Write-Host "  Demo Account:"
Write-Host "  - Username: demo_admin"
Write-Host "  - Password: demo_admin"
Write-Host ""
Write-Host "  View logs: docker compose -f docker-compose.demo.yml logs -f"
Write-Host "  Stop:      docker compose -f docker-compose.demo.yml down"
Write-Host ""
