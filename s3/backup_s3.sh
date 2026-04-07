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
