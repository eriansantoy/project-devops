import boto3
import sys

ec2 = boto3.client('ec2')

def listar():
    response = ec2.describe_instances()
    print(response)

def iniciar(instance_id):
    ec2.start_instances(InstanceIds=[instance_id])
    print("Instancia iniciada")
