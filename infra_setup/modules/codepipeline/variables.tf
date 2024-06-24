variable "env" {
  description = "project environment"
  type        = string
}

variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "codepipeline_iam_arn" {
  description = "codepipeline iam arn"
  type        = string
}

variable "artifact_bucket" {
  description = "bucket for artifacts storage"
  type        = string
}

variable "github_owner" {
  description = "github owner account name"
  type        = string
}

variable "github_repo" {
  description = "github repo name"
  type        = string
}

variable "github_branch" {
  description = "github branch name"
  type        = string
}

variable "github_token" {
  description = "github token for connection"
  type        = string
  sensitive   = true
}

variable "amplify_app_id" {
  description = "amplify app id"
  type        = string
}

variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}

variable "backend_build_name" {
  description = "codebuild name for backend"
  type        = string
}

variable "frontend_build_name" {
  description = "codebuild name for frontend"
  type        = string
}