#!/bin/bash

echo "Iniciando deploy..."

ACTION=$1
INSTANCE_ID=$2
DIRECTORY=$3
BUCKET=$4

if [ -z "$ACTION" ] || [ -z "$INSTANCE_ID" ] || [ -z "$DIRECTORY" ] || [ -z "$BUCKET" ]; then
    echo "Uso: ./deploy.sh <accion> <instance_id> <directorio> <bucket>"
    exit 1
fi

echo "Ejecutando acción EC2..."
python3 ec2/gestionar_ec2.py $ACTION $INSTANCE_ID

echo "Ejecutando backup S3..."
bash s3/backup_s3.sh $DIRECTORY $BUCKET

mkdir -p logs

LOG_FILE="logs/deploy.log"

echo "$(date) - Acción: $ACTION en instancia $INSTANCE_ID" >> $LOG_FILE
echo "$(date) - Backup ejecutado en $BUCKET" >> $LOG_FILE
