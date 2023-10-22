import os
import json
import boto3
import pandas as pd
from io import StringIO

#### required permissions ####
# "s3:GetObject",

def lambda_handler(event, context):
    s3 = boto3.client('s3')

    # Get the environment variables
    bucket_name = os.getenv('BUCKET_NAME')
    file_name = os.getenv('FILE_NAME')  # Name of the file in your S3 bucket

    # Use the provided bucket name and file name to get the object from S3
    obj = s3.get_object(Bucket=bucket_name, Key=file_name)
    
    # Read the CSV data from the S3 object
    data = pd.read_csv(StringIO(obj['Body'].read().decode('utf-8')))

    # Extract the first 20 rows from the DataFrame
    result_data = data.head(20).to_dict()

    return {
        'statusCode': 200,
        'body': json.dumps(result_data)
    }
