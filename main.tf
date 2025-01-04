resource "aws_ses_email_identity" "email" {
  email = "sanisherif11@gmail.com"
}

resource "aws_sns_topic" "sms" {
  name = "sms"
}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.sms.arn
  protocol  = "sms"
  endpoint  = "+2348060517731"
}

resource "aws_sfn_state_machine" "notification_state_machine" {
  name     = "notificationStateMachine"
  role_arn = aws_iam_role.step_functions_role.arn

  definition = <<EOF
{
  "Comment": "State machine for sending message or email",
  "StartAt": "select type of sending",
  "States": {
    "select type of sending": {
      "Type": "Choice",
      "Choices": [
        {
          "Variable": "$.typeOfSending",
          "StringEquals": "email",
          "Next": "Email"
        },
        {
          "Variable": "$.typeOfSending",
          "StringEquals": "sms",
          "Next": "SMS"
        }
      ]
    },
    "Email": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.email_function.arn}",
      "End": true
    },
    "SMS": {
      "Type": "Task",
      "Resource": "${aws_lambda_function.sms_function.arn}",
      "End": true
    }
  }
}
EOF
}

