# n8n Docker Setup with PostgreSQL

n8n workflow automation setup using Docker Compose with PostgreSQL database and automated backups.

## Features
- 🐳 Docker Compose setup with PostgreSQL
- 🔒 Secure database configuration with separate users
- 📦 Named volumes for data persistence
- 🔄 Automated daily backups with 7-day retention
- 🌐 Subdirectory deployment support (`/automation/`)
- ♻️ Auto-restart on system reboot

## Prerequisites
- Ubuntu (or similar Linux distribution)
- Docker and Docker Compose installed
- Domain name pointing to your server

## Quick Start

### 1. Clone the repository
`git clone git@github.com:eluceon/n8n-docker.git`
`cd n8n-docker`


### 2. Configure environment variables (.env)
#### Update the following variables:
- `POSTGRES_USER` - PostgreSQL admin username
- `POSTGRES_PASSWORD` - PostgreSQL admin password
- `POSTGRES_DB` - Database name
- `POSTGRES_N8N_USER` - n8n database user
- `POSTGRES_N8N_PASSWORD` - n8n database password
- `DOMAIN_NAME` - Your domain (e.g., example.com)
- `GENERIC_TIMEZONE` - Your timezone (e.g., Europe/Moscow)

### 3. Make scripts executable
`chmod +x init-data.sh`
`chmod +x backup-n8n.sh`

### 4. Start the services
`docker compose up -d`

### 5. Automated Backups
#### Setup cron job

`crontab -e`
##### Add this line for daily backups at 3:00 AM:
`0 3 * * * /root/backup-n8n.sh >> /var/log/n8n-backup.log 2>&1`
