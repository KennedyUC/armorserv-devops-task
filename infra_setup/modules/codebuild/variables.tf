variable "env" {
  description = "project environment"
  type        = string
}

variable "project_name" {
  description = "project name"
  type        = string
}

variable "codebuild_iam_arn" {
  description = "codebuild iam arn"
  type        = string
}

variable "artifact_bucket" {
  description = "s3 bucket for artifact storage"
  type        = string
}

variable "compute_instance" {
  description = "codebuild compute instance class"
  type        = string
}

variable "compute_image_name" {
  description = "codebuild compute instance image name"
  type        = string
}

variable "compute_image_type" {
  description = "codebuild compute instance image type"
  type        = string
}

variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}

variable "github_owner" {
  description = "github owner name"
  type        = string
}

variable "github_repo" {
  description = "github repo name"
  type        = string
}