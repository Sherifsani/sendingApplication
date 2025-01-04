resource "aws_api_gateway_rest_api" "sending_api" {
  name        = "sending_api"
  description = "API for sending message or email"

}

resource "aws_api_gateway_resource" "send" {
  rest_api_id = aws_api_gateway_rest_api.sending_api.id
  parent_id   = aws_api_gateway_rest_api.sending_api.root_resource_id
  path_part   = "send"
}

resource "aws_api_gateway_method" "sending_api_method" {
  rest_api_id   = aws_api_gateway_rest_api.sending_api.id
  resource_id   = aws_api_gateway_resource.send.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "sending_api_integration" {
  rest_api_id             = aws_api_gateway_rest_api.sending_api.id
  resource_id             = aws_api_gateway_resource.send.id
  http_method             = aws_api_gateway_method.sending_api_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.api_handler_function.invoke_arn
}

resource "aws_api_gateway_deployment" "sending_api_deployment" {
  depends_on  = [aws_api_gateway_method.sending_api_method]
  rest_api_id = aws_api_gateway_rest_api.sending_api.id
}

resource "aws_api_gateway_stage" "sending_api_stage_name" {
  stage_name    = "dev"
  rest_api_id   = aws_api_gateway_rest_api.sending_api.id
  deployment_id = aws_api_gateway_deployment.sending_api_deployment.id
}

resource "aws_lambda_permission" "api_gateway_permission" {
  statement_id  = "AllowExecutionFromApiGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.api_handler_function.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.sending_api.execution_arn}/*/*"

}