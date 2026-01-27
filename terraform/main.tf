provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name = "pacerpro-app"
  }
}

resource "aws_sns_topic" "alerts" {
  name = "performance-alerts"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda-remediation-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_lambda_function" "remediation" {
  function_name = "auto-remediate-latency"
  runtime       = "python3.10"
  handler       = "lambda_function.lambda_handler"
  role          = aws_iam_role.lambda_role.arn
  filename      = "lambda.zip"

  environment {
    variables = {
      INSTANCE_ID   = aws_instance.app.id
      SNS_TOPIC_ARN = aws_sns_topic.alerts.arn
    }
  }
}

