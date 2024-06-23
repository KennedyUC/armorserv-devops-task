module "iam_setup" {
  source                        = "./modules/iam"
  project_name                  = var.project_name
  env                           = var.env
  artifact_bucket_name          = var.artifact_bucket_name
}

module "network_setup" {
  source                        = "./modules/network"
  project_name                  = var.project_name
  env                           = var.env
  az_count                      = var.az_count
  vpc_cidr                      = var.vpc_cidr
  subnet_bits                   = var.subnet_bits
  enable_vpc_dns                = var.enable_vpc_dns

  depends_on = [module.iam_setup]
}

module "lambda_setup" {
  source                        = "./modules/compute"
  project_name                  = var.project_name
  env                           = var.env
  backend_file_name             = var.backend_file_name
  lambda_function_name          = var.lambda_function_name
  lambda_iam_arn                = module.network_setup.lambda_iam_arn
  lambda_runtime                = var.lambda_runtime

  depends_on = [module.network_setup]
}

module "rds_setup" {
  source                        = "./modules/database"
  project_name                  = var.project_name
  env                           = var.env
  private_subnet_ids            = module.network_setup.private_subnet_ids
  db_storage                    = var.db_storage
  db_engine                     = var.db_engine
  db_instance                   = var.db_instance
  db_name                       = var.db_name
  db_username                   = var.db_username
  db_password                   = var.db_password
  rds_sg_id                     = module.network_setup.rds_sg_id
  rds_sg_name                   = module.network_setup.rds_sg_name

  depends_on = [module.network_setup]
}