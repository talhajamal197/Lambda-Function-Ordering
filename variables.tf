variable "aws_region" {
  type        = string
  description = "AWS region to launch services"
}

variable "app_env" {
  type        = string
  description = "Common prefix for all terraform created resources"
}

variable "handler" {
  type        = string
  description = "The entry point for the Lambda function"
}

variable "process_order_function_name" {
  type        = string
  description = "Name for process order lambda function"
}

variable "add_order_function_name" {
  type        = string
  description = "Name for add order lambda function"
}

variable "queue_name" {
  type        = string
  description = "The name of the SQS queue"
}

variable "api_gateway_name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "account_id" {
  type        = string
  description = "The value for account id"
}
