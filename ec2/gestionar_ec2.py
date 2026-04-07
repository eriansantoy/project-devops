import boto3
import sys

ec2 = boto3.client('ec2')

def listar():
    response = ec2.describe_instances()
    print(response)

def iniciar(instance_id):
    ec2.start_instances(InstanceIds=[instance_id])
    print("Instancia iniciada")

def detener(instance_id):
    ec2.stop_instances(InstanceIds=[instance_id])
    print("Instancia detenida")

def terminar(instance_id):
    ec2.terminate_instances(InstanceIds=[instance_id])
    print("Instancia terminada")
