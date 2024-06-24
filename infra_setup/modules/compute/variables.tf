variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "env" {
  description = "project environment"
  type        = string
}

variable "backend_file_name" {
  description = "backend file name without extension"
  type        = string
}

variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}

variable "lambda_iam_arn" {
  description = "lambda function iam role arn"
  type        = string
}

variable "lambda_runtime" {
  description = "lambda function runtime (e.g. nodejs18.x)"
  type        = string
}