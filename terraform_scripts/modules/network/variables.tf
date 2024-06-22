variable "project_name" {
  description = "name of the project"
  type        = string
}

variable "env" {
  description = "environment"
  type        = string
}

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