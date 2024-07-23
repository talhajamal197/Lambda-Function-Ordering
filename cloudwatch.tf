# cloud watch group for Process Order Lambda.
resource "aws_cloudwatch_log_group" "lambda_loggroup" {
  name              = "/aws/lambda/${var.app_env}/${aws_lambda_function.processOrder_lambda.function_name}"
  tags              = local.common_tags
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}

# cloud watch group for API-Gateway
resource "aws_cloudwatch_log_group" "example" {
  name              = "API-Gateway-Execution-Logs_${aws_api_gateway_rest_api.order_api.id}/${var.app_env}"
  tags              = local.common_tags
  retention_in_days = 1

  lifecycle {
    prevent_destroy = false
  }
}