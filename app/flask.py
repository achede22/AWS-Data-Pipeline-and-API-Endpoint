import sys
import sys
!{sys.executable} -m pip install boto3

import boto3
from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/data', methods=['GET'])
def get_data():
    client = boto3.client('athena')

    # Use the provided database name and table name in your query
    query = "SELECT * FROM {}".format(var.database_name)  # replace with your actual SQL query
    database = var.database_name  # replace with your actual Athena database
    s3_output = "s3://{}/query_results/".format(var.bucket_name)  # replace with your actual S3 bucket

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

    return jsonify(result_data)

if __name__ == '__main__':
    app.run(debug=True)
