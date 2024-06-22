data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../backend/${backend_file_name}.js"
  output_path = "../backend/${backend_file_name}.zip"
}

resource "aws_lambda_function" "backend" {
  filename      = "../backend/${backend_file_name}.zip"
  function_name = var.lambda_function_name
  role          = var.lambda_iam_arn
  handler       = "index.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.lambda_runtime

  environment {
    variables = {
      Env = var.env
    }
  }
}