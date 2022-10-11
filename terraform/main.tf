terraform {
  required_providers {
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.2.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.33.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_iam_role" "iam_for_lambda" {
  name = "iam_for_lambda"

  assume_role_policy = jsonencode({
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
  })
}

resource "aws_iam_policy" "function_logging_policy" {
  name   = "function-logging-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        Action : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect : "Allow",
        Resource : "arn:aws:logs:*:*:*"
      }
    ]
  })
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../foobar-lambda/dist/"
  output_path = "lambda.js.zip"
}

resource "aws_cloudwatch_log_group" "function_log_group" {
  name              = aws_lambda_function.foobar_lambda.function_name
  retention_in_days = 7
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_lambda_function" "foobar_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "foobar"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda.handler"
  runtime          = "nodejs16.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  ephemeral_storage {
    size = 10240 # Min 512 MB and the Max 10240 MB
  }
}

resource "aws_iam_role_policy_attachment" "function_logging_policy_attachment" {
  role = aws_iam_role.iam_for_lambda.id
  policy_arn = aws_iam_policy.function_logging_policy.arn
}
