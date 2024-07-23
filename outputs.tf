# The API Gateway URL
output "api_gateway_url" {
  value = "${aws_api_gateway_deployment.order_deployment.invoke_url}devl/${aws_api_gateway_resource.order_resource.path_part}"
}