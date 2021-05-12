variable "lambda_func_name" {
    type = string
}

resource "aws_lambda_function_event_invoke_config" "lambda_dest" {
  function_name = var.lambda_func_name
  destination_config {
    on_success {
      destination = aws_sns_topic.sns_lambda_destination_topic.arn
    }
  }
}

resource "aws_sns_topic" "sns_lambda_destination_topic" {
  name = "sns_lambda_destination_topic"
}

resource "aws_sns_topic_subscription" "sns_subscription" {
  endpoint = "your@email.com"
  protocol = "email"
  topic_arn = aws_sns_topic.sns_lambda_destination_topic.arn
}