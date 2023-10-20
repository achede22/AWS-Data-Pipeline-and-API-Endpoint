import os
import boto3

def lambda_handler(event, context):
    sns = boto3.client('sns')
    response = sns.publish(
        TopicArn=os.environ['SNS_TOPIC_ARN'],  # Usa el ARN del SNS desde las variables de entorno de terraform
        Message='Hola Mundo, desde Lambda!', 
    )
