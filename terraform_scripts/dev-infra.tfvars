project_name            = "devops-1470"
env                     = "dev"
az_count                = 2
vpc_cidr                = "10.0.0.0/16"
enable_vpc_dns          = true
subnet_bits             = 8
backend_file_name       = "backend"
lambda_function_name    = "node-backend"
lambda_runtime          = "nodejs18.x"
db_storage              = 30
db_engine               = "mysql"
db_instance             = "db.t3.micro"