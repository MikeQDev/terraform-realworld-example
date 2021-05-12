### Experimenting with TerraForm

Creates a lambda function from `code.zip` (not included in repo). Upon execution, Lambda triggers a success messages to SNS topic, which forwards to subscriber (email). Lambda execution logs are sent to CLoudWatch when lambda is invoked

Other ideas: forward message to SQS for processing by EC2 instance, lambda write to DynamoDB, add CloudWatch logs for SNS, use API gateway to trigger lambda function

Sample lambda trigger: `aws lambda invoke --cli-binary-format raw-in-base64-out --function-name addition --invocation-type Event --payload '{"num1":3,"num2":9}' response.json`
