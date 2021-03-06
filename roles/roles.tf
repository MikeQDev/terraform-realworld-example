resource "aws_iam_role" "lambda_role" {
    name = "my_lambda_role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "all_policy" {
  name        = "lambda_logging_policy"
  path        = "/"
  description = "IAM policy for extensive privileges"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "sns:Publish",
                "lambda:InvokeFunction",
                "logs:PutLogEvents"
            ],
            "Resource": [
                "arn:aws:logs:*:686529668265:log-group:*:log-stream:*",
                "arn:aws:lambda:*:686529668265:function:*",
                "arn:aws:sns:*:686529668265:*"
            ]
        },
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogStream",
                "logs:CreateLogGroup"
            ],
            "Resource": "arn:aws:logs:*:686529668265:log-group:*"
        }
    ]
}
EOF
}

resource "aws_iam_policy_attachment" "lambda_attachment" {
  name = "lambda_log_policy_attachment"
  roles = [  aws_iam_role.lambda_role.name ]
  policy_arn = aws_iam_policy.all_policy.arn
}

output "lambda_role" {
  value = aws_iam_role.lambda_role
}