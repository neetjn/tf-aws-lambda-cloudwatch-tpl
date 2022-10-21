data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "../foobar-lambda/dist/"
  output_path = "lambda.js.zip"
}

resource "aws_lambda_function" "foobar_lambda" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "foobar"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = "lambda.handler"
  runtime          = "nodejs16.x"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  ephemeral_storage {
    size = 10240
  }
}
