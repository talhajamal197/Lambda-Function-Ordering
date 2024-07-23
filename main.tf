# module "add_order_lambda" {
#   source        = "./lambda"
#   function_name = "AddOrderLambda"
#   handler       = "add_order.handler"
#   role          = "add_order_lambda_role"
#   environment = {
#     QUEUE_URL = module.order_queue.url
#   }
# }


terraform {
  backend "s3" {
    bucket = "aws-scalable-dev-statefiles"
    key    = "order_application/process_orders_application.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}