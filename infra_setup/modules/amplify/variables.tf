variable "env" {
  description = "project environment"
  type        = string
}

variable "project_name" {
  description = "project name"
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

variable "github_token" {
  description = "github token"
  type        = string
  sensitive   = true
}

variable "github_branch" {
  description = "github branch name"
  type        = string
}