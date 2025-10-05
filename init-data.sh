#!/bin/bash
set -e;

if [ -n "${POSTGRES_N8N_USER:-}" ] && [ -n "${POSTGRES_N8N_PASSWORD:-}" ]; then
        psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
                CREATE USER ${POSTGRES_N8N_USER} WITH PASSWORD '${POSTGRES_N8N_PASSWORD}';
                GRANT ALL PRIVILEGES ON DATABASE ${POSTGRES_DB} TO ${POSTGRES_N8N_USER};
                GRANT CREATE ON SCHEMA public TO ${POSTGRES_N8N_USER};
        EOSQL
else
        echo "SETUP INFO: No Environment variables given!"
fi
