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
