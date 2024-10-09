provider "aws" {
  profile = "default"
  region     = var.region
  access_key = ""
  secret_key = ""
}

data "archive_file" "archive_lambda" {
  type        = "zip"
  source_file = "greet_lambda.py"
  output_path = var.lambda_output_path
}

resource "aws_iam_role" "udacity_lambda_role" {
  name = "udacity_lambda_role"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole",
      "Principal" : {
        "Service" : "lambda.amazonaws.com"
      },
      "Effect" : "Allow",
      "Sid" : ""
    }]
  })
}

resource "aws_iam_role_policy_attachment" "udacity_lambda_attachment" {
  role       = aws_iam_role.udacity_lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "udacity_lambda_log" {
  name        = "udacity_lambda_log"
  path        = "/"
  description = "IAM for Lambda logging"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : "arn:aws:logs:*:*:*",
        "Effect" : "Allow"
      }
    ]
  })
}

resource "aws_lambda_function" "great_lambda" {
  filename         = var.lambda_output_path
  function_name    = var.lambda_function_name
  handler          = "${var.lambda_function_name}.lambda_handler"
  runtime          = "python3.12"
  role             = aws_iam_role.udacity_lambda_role.arn
  source_code_hash = data.archive_file.archive_lambda.output_base64sha256
  depends_on       = [aws_iam_role_policy_attachment.udacity_lambda_attachment]
  environment {
    variables = {
      greeting = "Duck"
    }
  }
}
