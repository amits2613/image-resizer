resource "aws_s3_bucket" "image_bucket" {
  bucket = var.bucket_name
  acl    = "public-read"
}

resource "aws_lambda_function" "test_lambda" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  image_uri     = aws_ecr_repository.image_repository.image_repository
  package_type  = "image"
}

resource "aws_lambda_function_url" "lambda_url" {
  function_name      = aws_lambda_function.test_lambda.function_name
  authorization_type = "AWS_IAM"

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["GET, POST"]
    allow_headers     = ["date", "keep-alive"]
    expose_headers    = ["keep-alive", "date"]
    max_age           = 86400
  }
}

resource "aws_cloudwatch_log_group" "lambda_log_group" {
  name              = "/aws/lambda/${var.lambda_function_name}"
  retention_in_days = var.log_retention_period
}

resource "aws_ecr_repository" "image_repository" {
  name                 = var.image_name
  image_tag_mutability = var.image_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}


