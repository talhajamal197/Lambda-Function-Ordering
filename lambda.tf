# Archieve the code files for addOrderLambda.py
data "archive_file" "addOrderLambda" {
  type        = "zip"
  source_file = "${path.module}/src/lambda-functions/AddOrder.py"
  output_path = "${path.module}/src/lambda-functions/AddOrder_payload.zip"
}

# Archieve the code files for ProcessOrderLambda.py
data "archive_file" "processOrderLambda" {
  type        = "zip"
  source_file = "${path.module}/src/lambda-functions/ProcessOrder.py"
  output_path = "${path.module}/src/lambda-functions/ProcessOrder_payload.zip"
}

# Consume the addOrderLambda.zip as a payload
resource "aws_lambda_function" "addOrder_lambda" {
  filename      = "${path.module}/src/lambda-functions/AddOrder_payload.zip"
  function_name = "${var.add_order_function_name}-${var.app_env}"
  role          = data.aws_iam_role.assume_role.arn
  handler       = join(".", ["AddOrder", var.handler])

  source_code_hash = data.archive_file.addOrderLambda.output_base64sha256
  timeout          = 10
  runtime          = "python3.9"

  environment {
    variables = {
      QUEUE_URL = aws_sqs_queue.order_queue.url
    }
  }

  tags = local.common_tags
}

# Consume the ProcessOrderLambda.zip as a payload
resource "aws_lambda_function" "processOrder_lambda" {
  filename      = "${path.module}/src/lambda-functions/ProcessOrder_payload.zip"
  function_name = "${var.process_order_function_name}-${var.app_env}"
  role          = data.aws_iam_role.assume_role.arn
  handler       = join(".", ["ProcessOrder", var.handler])

  source_code_hash = data.archive_file.processOrderLambda.output_base64sha256
  timeout          = 10
  runtime          = "python3.9"

  tags = local.common_tags
}

# Set the sqs as a trigger for processOrder Lambda
resource "aws_lambda_event_source_mapping" "event_source_mapping" {
  event_source_arn = aws_sqs_queue.order_queue.arn
  enabled          = true
  function_name    = aws_lambda_function.processOrder_lambda.arn
  batch_size       = 1
}