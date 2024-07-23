# The AWS API Gateway
resource "aws_api_gateway_rest_api" "order_api" {
  name        = var.api_gateway_name
  description = "REST interface for Order application."
}

# Create `resource` for the API
resource "aws_api_gateway_resource" "order_resource" {
  rest_api_id = aws_api_gateway_rest_api.order_api.id
  parent_id   = aws_api_gateway_rest_api.order_api.root_resource_id
  path_part   = aws_lambda_function.addOrder_lambda.function_name
}

# Create `method` for the API Gateway resource
resource "aws_api_gateway_method" "order_method" {
  rest_api_id   = aws_api_gateway_rest_api.order_api.id
  resource_id   = aws_api_gateway_resource.order_resource.id
  http_method   = "ANY"
  authorization = "NONE"
}

# To enable CORS
# module "cors" {
#   source = "squidfunk/api-gateway-enable-cors/aws"
#   version = "0.3.3"

#   api_id          = aws_api_gateway_rest_api.order_api.id
#   api_resource_id = aws_api_gateway_resource.order_resource.id
# }

# The integration between the API Gateway and Lambda function
resource "aws_api_gateway_integration" "order_integration" {
  rest_api_id             = aws_api_gateway_rest_api.order_api.id
  resource_id             = aws_api_gateway_resource.order_resource.id
  http_method             = aws_api_gateway_method.order_method.http_method
  integration_http_method = "ANY"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.addOrder_lambda.invoke_arn
}

# adding required permission to lambda
resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.addOrder_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "arn:aws:execute-api:${var.aws_region}:${var.account_id}:${aws_api_gateway_rest_api.order_api.id}/*/${aws_api_gateway_method.order_method.http_method}${aws_api_gateway_resource.order_resource.path}"
}

# Deploy API Gateway, so can access via browser
resource "aws_api_gateway_deployment" "order_deployment" {
  depends_on = [aws_api_gateway_method.order_method, aws_api_gateway_integration.order_integration]

  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_resource.order_resource.id,
      aws_api_gateway_method.order_method.id,
      aws_api_gateway_integration.order_integration.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  rest_api_id = aws_api_gateway_rest_api.order_api.id
}


# Stage to dev/qa/prod intemediate URL
resource "aws_api_gateway_stage" "environment" {
  deployment_id = aws_api_gateway_deployment.order_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.order_api.id
  stage_name    = var.app_env
  tags          = local.common_tags
}

