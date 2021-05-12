provider "aws" {
    region = "us-east-1"
}

module "roles" {
  source = "./roles/"
}

resource "aws_lambda_function" "addition_lambda" {
  function_name = "addition"
  role = module.roles.lambda_role.arn
  filename = "./code.zip"
  runtime = "nodejs12.x"
  handler = "index.handler"
}