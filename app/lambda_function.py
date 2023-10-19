import json
import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')

    bucket = 'hdbucketchallenge'
    key = 'test1'
    body = json.dumps(event)  # esto convierte el evento en una cadena JSON

    try:
        s3.put_object(Bucket=bucket, Key=key, Body=body)
        print(f'Archivo escrito con éxito en {bucket}/{key}')
    except Exception as e:
        print(f'Error al escribir en S3: {e}')
