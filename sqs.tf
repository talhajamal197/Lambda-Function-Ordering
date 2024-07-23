# The SQS queue.
# the var.app_env represents services belonging to that specific environment.
resource "aws_sqs_queue" "order_queue" {
  name                       = "${var.queue_name}-${var.app_env}"
  visibility_timeout_seconds = 20
  max_message_size           = 1024
  message_retention_seconds  = 60
  receive_wait_time_seconds  = 2
  sqs_managed_sse_enabled    = true

  tags = local.common_tags
}