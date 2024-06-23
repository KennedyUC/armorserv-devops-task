#### common ####

variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

#### network ####

variable "az_count" {
  description = "Number of availability zones to deploy"
  type        = number
}

variable "vpc_cidr" {
  description = "cidr block for the VPC"
  type        = string
}

variable "enable_vpc_dns" {
  description = "enable vpc dns"
  type        = bool
}

variable "subnet_bits" {
  description = "number of subnet bits to use for the subnet"
  type        = number
}

#### compute ####

variable "backend_file_name" {
  description = "backend file name without extension"
  type        = string
}

variable "lambda_function_name" {
  description = "lambda function name"
  type        = string
}

variable "lambda_runtime" {
  description = "lambda function runtime (e.g. nodejs18.x)"
  type        = string
}

#### database ####

variable "db_storage" {
  description = "db storage size"
  type        = number
}

variable "db_engine" {
  description = "db engine type (e.g. mysql)"
  type        = string
}

variable "db_instance" {
  description = "db instance class"
  type        = string
}

variable "db_name" {
  description = "db name"
  type        = string
}

variable "db_username" {
  description = "db username"
  type        = string
}

variable "db_password" {
  description = "db password"
  type        = string
  sensitive   = true
}

#### provider ####
variable "aws_region" {
  description = "aws region"
  type        = string
}

variable "access_key" {
  description = "aws user access key"
  type        = string
  sensitive   = true
}

variable "secret_key" {
  description = "aws user secret key"
  type        = string
  sensitive   = true
}

variable "artifact_bucket_name" {
  description = "artifact bucket"
  type        = string
}