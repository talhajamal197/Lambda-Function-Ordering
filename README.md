# Handling Orders with AWS and Terraform Integration







## The application illustrates how to utilize AWS API Gateway, AWS SQS, AWS Lambda, and AWS CloudWatch services with Terraform.
### Project Overview
This project demonstrates how AWS services can seamlessly integrate using infrastructure as code with Terraform. The objective is to establish a functional system on AWS for processing orders, which includes deploying two Lambda functions, an SQS queue, and an API Gateway for receiving requests.

### Key Features
Implements AWS Lambda, SQS, IAM, and API Gateway services using Terraform for infrastructure setup.
Configures two Lambda functions: one for receiving orders and another for processing orders. These functions are linked through an SQS queue trigger.
API Gateway forwards incoming messages to the AddOrder Lambda function, which then places the messages into an SQS queue.
The ProcessOrder Lambda function processes messages from the SQS queue and logs the corresponding message IDs in CloudWatch Logs.


### Interacting with the API Gateway Service

##### Execute `terraform apply` to create the infrastructure.

##### Copy the API Gateway URL displayed in the terminal and paste it into the `endpoint` variable within `src/REST-Interface.py`.

##### Run the `REST-Interface.py` script to activate the API Gateway.
