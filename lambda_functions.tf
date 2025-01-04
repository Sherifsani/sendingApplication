resource "aws_lambda_function" "email_function" {
  role             = aws_iam_role.email_function_role.arn
  function_name    = "email_function"
  runtime          = "python3.13"
  handler          = "email_handler.lambda_handler"
  filename         = "lambda/email_handler.zip"
  source_code_hash = filebase64sha256("lambda/email_handler.zip")

}
resource "aws_lambda_function" "sms_function" {
  role             = aws_iam_role.sms_function_role.arn
  function_name    = "sms_function"
  runtime          = "python3.13"
  handler          = "sms_handler.lambda_handler"
  filename         = "lambda/sms_handler.zip"
  source_code_hash = filebase64sha256("lambda/sms_handler.zip")
}

resource "aws_lambda_function" "api_handler_function" {
  role = aws_iam_role.api_handler_function.arn
  function_name = "api_handler_function"
  runtime = "python3.13"
  filename = "lambda/api_handler.zip"
  source_code_hash = filebase64sha256("lambda/api_handler.zip")
  
}