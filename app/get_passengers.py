import os
import json
import boto3

def lambda_handler(event, context):
    client = boto3.client('athena')

    # Get the environment variables
    database_name = os.getenv('DATABASE_NAME')
    bucket_name = os.getenv('BUCKET_NAME')

    # Use the provided database name and table name in your query
    query = "SELECT * FROM passengers"  # simple SQL query
    database = database_name  # AWS Athena database
    s3_output = "s3://{}/query_results/".format(bucket_name)  # S3 bucket

    response = client.start_query_execution(
        QueryString=query,
        QueryExecutionContext={
            'Database': database
        },
        ResultConfiguration={
            'OutputLocation': s3_output,
        }
    )

    query_execution_id = response['QueryExecutionId']

    result_data = client.get_query_results(QueryExecutionId=query_execution_id)
    # Extract the data from the Athena query results...

    return {
        'statusCode': 200,
        'body': json.dumps(result_data)
    }
