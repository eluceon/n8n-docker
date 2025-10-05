#!/bin/bash
set -e

BACKUP_DIR="/backup/n8n"
DATE=$(date +%Y%m%d_%H%M%S)
ENV_FILE="$HOME/n8n-docker/.env"

if [ -f "$ENV_FILE" ]; then
    export $(grep -v '^#' $ENV_FILE | xargs)
else
    echo "Error: .env file not found at $ENV_FILE"
    exit 1
fi

mkdir -p ${BACKUP_DIR}

docker exec n8n_postgres pg_dump -U ${POSTGRES_N8N_USER} ${POSTGRES_DB} | gzip > ${BACKUP_DIR}/n8n_db_${DATE}.sql.gz

docker run --rm \
  -v n8n-docker_n8n_data:/source:ro \
  -v ${BACKUP_DIR}:/backup \
  alpine \
  tar -czf /backup/n8n_data_${DATE}.tar.gz -C /source .

find ${BACKUP_DIR} -type f -mtime +7 -delete

echo "Backup completed: ${DATE}"
