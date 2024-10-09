# TODO: Define the variable for aws_region

variable "region" {
  type = string
  default = "us-east-1"
}

variable "lambda_function_name" {
  type = string
  default = "greet_lambda"
}

variable "lambda_output_path" {
  type = string
  default = "greet_lambda.zip"
}