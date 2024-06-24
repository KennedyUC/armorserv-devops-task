data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../backend/${var.backend_file_name}.js"
  output_path = "../backend/${var.backend_file_name}.zip"
}

resource "aws_lambda_function" "backend" {
  filename      = "../backend/${var.backend_file_name}.zip"
  function_name = var.lambda_function_name
  role          = var.lambda_iam_arn
  handler       = "backend.handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = var.lambda_runtime

  tags = {
    Name = "${var.project_name}-${var.env}-node"
    Env  = var.env
  }
}