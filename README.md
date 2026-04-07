Este proyecto tiene como objetivo crear scripts para manejar instancias EC2 y respaldos en S3, además de un script de orquestación (deploy.sh) para simular un flujo de CI/CD. La idea es que todo sea reutilizable, sin hardcodear valores, y que se pueda cambiar la configuración sin tocar el código.

Flujo de ramas

Trabajo con tres tipos de ramas:

main → versión estable
develop → integración
feature/* → desarrollo de funcionalidades

Yo creé ramas tipo feature/ec2-script, feature/s3-script y feature/deploy-script.
El flujo fue así:

Crear la rama feature
Desarrollar la funcionalidad
Hacer commits pequeños y claros
Hacer push a GitHub
Hacer merge a develop
Hacer merge a main

Esto permite mantener el proyecto organizado y evitar romper la versión estable.

Commits progresivos

Cada parte del código la fui agregando en commits pequeños, para que sea más fácil de entender y seguir el progreso.

Por ejemplo, en EC2 hice:

feat: estructura inicial del script EC2
feat: listar instancias EC2
feat: iniciar instancia EC2
feat: detener instancia EC2
feat: validación de parámetros
feat: manejo de errores

En S3:

feat: estructura inicial script backup
feat: validación de directorio
feat: compresión de archivos
feat: subida a S3
feat: generación de logs

Y para el deploy:

feat: script base deploy.sh
feat: integración con EC2
feat: integración con S3
feat: manejo de errores
feat: logs de ejecución
Script EC2

El script gestionar_ec2.py puede:

Listar instancias
Iniciar, detener o terminar instancias
Recibir parámetros desde la terminal

Ejemplos de uso:

python3 ec2/gestionar_ec2.py listar
python3 ec2/gestionar_ec2.py iniciar i-013dcf0d1b13d13a6
Script S3

El script backup_s3.sh hace lo siguiente:

Recibe parámetros: directorio y bucket
Comprime archivos
Sube archivos a S3
Genera logs

Ejemplo de uso:

bash s3/backup_s3.sh ./data devops-backup-eriansantoy-2026
Script deploy.sh

deploy.sh orquesta todo el flujo:

Recibe parámetros (acción, instance ID, directorio, bucket)
Llama al script de Python para EC2
Llama al script de S3
Valida errores
Genera logs

Ejemplo:

./deploy.sh iniciar i-013dcf0d1b13d13a6 ./data devops-backup-eriansantoy-2026

Con esto puedo simular un flujo DevOps completo: feature → commit → push → merge → deploy → AWS.
Todo se hace sin hardcodear valores, todo se pasa por parámetros o por archivo de configuración.

Configuración

Modifique el archivo config.env donde guardo los valores de configuración:

INSTANCE_ID=i-013dcf0d1b13d13a6
BUCKET_NAME=devops-backup-eriansantoy-2026
DIRECTORY=./data
REGION=us-east-1

En deploy.sh uso estos valores así:

source config/config.env
python3 ec2/gestionar_ec2.py iniciar $INSTANCE_ID
bash s3/backup_s3.sh $DIRECTORY $BUCKET_NAME

Beneficios de esto:

Separar configuración del código
Cambiar valores sin modificar scripts
Scripts más reutilizables y seguros
