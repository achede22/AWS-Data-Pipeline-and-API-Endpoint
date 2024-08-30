# AWS Data Pipeline and API Endpoint

This repository contains the infrastructure for a system to ingest and store data in a database for advanced analysis. The stored data is exposed through an HTTP API for third-party consumption.

## **Branches and Workflow**

Although using a `master` branch and a `develop` branch is requested, we suggest considering Trunk-based Development as a modern and efficient development practice. You can find more information about this workflow [here](https://trunkbaseddevelopment.com/).

## **Infrastructure and IaC**

The infrastructure needed to ingest, store, and expose data includes:

- **Amazon SNS (Simple Notification Service)**: Enables a Pub/Sub schema.
- **Data Storage for Analysis**: A small DataLake is created in S3 and Athena is used to run SQL queries on the data stored in S3, preferring this option over Amazon Redshift for reasons of simplicity and cost.
- **Data Exposure**: A Lambda function is used to create a simple function instead of using API Gateway since no authorization with Cognito or traffic control is needed.

Additionally, an IAM (Identity and Access Management) module is included to manage the necessary permissions.

## **Configuration**

I am using the `us-west-2` region.

As I created some elements manually in the console, I then had to import them into Terraform's `tfstate`:

terraform import module.athena.aws_athena_database.challenge hdbucketchallenge  
terraform import module.lambda.aws_iam_role.challenge hd-lambda-function_execution_role  
terraform import module.s3.aws_s3_bucket.challenge hdbucketchallenge  
terraform import module.lambda.aws_lambda_function.challenge hd-lambda-function  
terraform import module.lambda.aws_lambda_permission.challenge hd-lambda-function/hd-lambda-function_AllowExecutionFromSNS

## **Design Decisions**

1. I created a Python Flask application that queries data through Athena and returns the results.
2. I used AWS API Gateway to create an HTTP endpoint that handles GET requests from the Flask application.

## **How to Use**

To use this system, follow these steps:

1. **Configure your AWS environment**: Ensure you have an AWS account and have set up your AWS credentials on your local environment using the `aws configure` command from the AWS CLI.

2. **Clone this repository**: Clone this repository using the command `git clone https://github.com/achede22/HD-Challenge.git`

3. **Install dependencies**: This project uses several Python libraries. Install them using the command `pip install -r requirements.txt`.

4. **Deploy the infrastructure**: Deploy the infrastructure using the command `terraform apply`. Ensure you are in the correct directory when running this command.

5. **Use the API**: Once the infrastructure is deployed, you can send a GET request to the endpoint `https://9jam985kpl.execute-api.us-west-2.amazonaws.com/default/hd-lambda-function2`.

## **Sample Output**

An example API response:
```
HTTP/1.1 200 OK Date: Sun, 22 Oct 2023 06:25:11 GMT Content-Type: text/plain; charset=utf-8 Content-Length: 1175 Connection: keep-alive Apigw-Requestid: NML7LjL5vHcESyg=

{"passenger_id": {"0": 1, "1": 2, "2": 3, "3": 4, "4": 5, "5": 6, "6": 7, "7": 8, "8": 9, "9": 10, "10": 11, "11": 12, "12": 13, "13": 14, "14": 15, "15": 16, "16": 17, "17": 18, "18": 19, "19": 20}, "flight_id": {"0": 1001, "1": 1002, "2": 1003, "3": 1004, "4": 1005, "5": 1006, "6": 1007, "7": 1008, "8": 1009, "9": 1010, "10": 1011, "11": 1012, "12": 1013, "13": 1014, "14": 1015, "15": 1016, "16": 1017, "17": 1018, "18": 1019, "19": 1020}, "name": {"0": "Juan Perez", "1": "Maria Rodriguez", "2": "Pedro Gonzalez", "3": "Lucia Fernandez", "4": "Ricardo Lopez", "5": "Sofia Torres", "6": "Gabriel Ramirez", "7": "Carmen Morales", "8": "Rafael Medina", "9": "Laura Ortega", "10": "Eduardo Castro", "11": "Teresa Guzman", "12": "Javier Peña", "13": "Susana Rios", "14": "Fernando Reyes", "15": "Rosa Mendoza", "16": "Gustavo Silva", "17": "Marta Romero", "18": "Luis Cordero", "19": "Alicia Delgado"}, "seat_number": {"0": "12A", "1": "12B", "2": "15A", "3": "15B", "4": "16A", "5": "16B", "6": "17A", "7": "17B", "8": "18A", "9": "18B", "10": "19A", "11": "19B", "12": "20A", "13": "20B", "14": "21A", "15": "21B", "16": "22A", "17": "22B", "18": "23A", "19": "23B"}}
```

## **Warning**

The `set-output` command is deprecated. More information [here](https://github.blog/changelog/2022-10-11-github-actions-deprecating-save-state-and-set-output-commands/).

## **Post-data**

I would have liked to continue with ingestion via PUSH, using SNS to activate Pub/Sub, and create the infrastructure diagram with LucidCharts. At one point, I had the Dockerfile built and uploaded to ECR but went back to using the Python code on Lambda.

In an enterprise environment, I would use EKS with its respective liveness and readiness checks and integration tests. I would collect data with Prometheus and work with Grafana Mimir or Thanos, in addition to using Grafana's graphical interface. I would use Terraform workspaces to separate environments (develop, QA, staging, and prod), standardizing object names with prefixes and suffixes.

Grafana allows you to set up alerts and establish an on-call. If we scale the solution to 50 similar systems, we could unlock new metrics and visualization methods. For example, we could add metrics showing the average performance of all systems and display them in a Grafana dashboard. We could also use line charts to show trends over time.

Not properly addressing scalability could lead to several difficulties and limitations in the observability of systems. We could face performance and latency issues with Prometheus, as well as a large amount of false positives or negatives if alerts and thresholds are not configured correctly.

# **Thanks for the opportunity**

---

Invitation Notes:
Our friends at DataArt have forwarded your application for the DevOps position to us. We would like to invite you on an exciting journey through our selection process. Let me explain the stages:

- **Customized Challenge**: We have attached a technical challenge that we challenge you to complete within 10 days. This challenge is an opportunity for you to apply your knowledge on a real project. All instructions are detailed in the attached file.

The maximum delivery time for the challenge is 10 complete calendar days from the receipt of the challenge. For example, if you received the challenge on Thursday, September 21 at 3 pm, you have until Sunday, October 1 at 11:59 pm.

- **Perspective Conversation**: If you successfully complete this challenge, we will schedule an interview where you can share your skills, experience, and projects with some members of our team.

This selection process generally takes between 2 to 3 weeks, so we recommend that you keep this in mind when planning your schedule.

We are excited to see you in action and look forward to learning more about your skills and expectations!

---

Feel free to contribute to this project by submitting issues or pull requests. Your feedback and contributions are welcome!

## **Author**

Achede_HD

---

## **Contact Information**
- GitHub: [achede22](https://github.com/achede22)

---

## **License**

This project is licensed under the MIT License - see the LICENSE file for details.