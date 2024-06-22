variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

variable "private_subnet_ids" {
  description = "private subnets ids"
}

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

variable "rds_sg_id" {
  description = "db security group id"
  type        = string
}

variable "rds_sg_name" {
  description = "db security group name"
  type        = string
}