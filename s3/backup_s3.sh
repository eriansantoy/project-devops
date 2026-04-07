#!/bin/bash

DIRECTORY=$1
BUCKET=$2

# Validar parámetros
if [ -z "$DIRECTORY" ] || [ -z "$BUCKET" ]; then
    echo "Uso: ./backup_s3.sh <directorio> <bucket>"
    exit 1
fi

# Validar que el directorio exista
if [ ! -d "$DIRECTORY" ]; then
    echo "El directorio no existe"
    exit 1
fi

echo "Parámetros válidos"

# Nombre del archivo comprimido
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

# Comprimir directorio
tar -czf $BACKUP_NAME $DIRECTORY

echo "Backup creado: $BACKUP_NAME"

# Subir a S3
aws s3 cp $BACKUP_NAME s3://$BUCKET/

echo "Backup subido a S3: s3://$BUCKET/$BACKUP_NAME"

# Crear carpeta logs si no existe
mkdir -p logs

# Archivo de log
LOG_FILE="logs/backup.log"

# Guardar log
echo "$(date) - Backup creado: $BACKUP_NAME" >> $LOG_FILE
echo "$(date) - Backup subido a S3: s3://$BUCKET/$BACKUP_NAME" >> $LOG_FILE
