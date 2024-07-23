# Processing Order with AWS-TerraformIntegration
 
## The application demonstrates how AWS API-Gateway | AWS SQS | AWS Lambda | AWS Cloudwatch services can be leveraged in Terraform.

### Project Overview
This project demonstrates how AWS services can seamlessly integrate using infrastructure as code with Terraform. The objective is to establish a functional system on AWS for processing orders, which includes deploying two Lambda functions, an SQS queue, and an API Gateway for receiving requests.

### Key Features
- Utilizes AWS Lambda, SQS, IAM, and API Gateway services within Terraform for infrastructure setup.
- Configures two Lambda functions: one for receiving orders and another for processing orders, interconnected via an SQS queue trigger.
- Employs API Gateway to forward messages to the AddOrder-Lambda for order reception, which subsequently transfers the message to an SQS queue.
- The ProcessOrder-Lambda handles message consumption from the queue and logs an associated message ID on CloudWatch logs.

![system_diagram](https://github.com/akshatra/API-Gateway-SQS-Lambda/assets/47113617/4b3ed998-41d5-43d5-9a75-7418b8d01513)

### Interacting with the API Gateway Service

**Step 1:** Execute `terraform apply` to create the infrastructure.

**Step 2:** Copy the API Gateway URL displayed in the terminal and paste it into the `endpoint` variable within `src/REST-Interface.py`.

**Step 3:** Run the `REST-Interface.py` script to activate the API Gateway.
