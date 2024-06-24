module "iam_setup" {
  source                        = "./modules/iam"
  project_name                  = var.project_name
  env                           = var.env
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
  lambda_iam_arn                = module.iam_setup.lambda_iam_arn
  lambda_runtime                = var.lambda_runtime

  depends_on = [module.network_setup]
}

module "rds_setup" {
  source                        = "./modules/database"
  project_name                  = var.project_name
  env                           = var.env
  private_subnet_ids            = module.network_setup.private_subnet_ids
  db_storage                    = var.db_storage
  max_db_storage                = var.max_db_storage
  db_engine                     = var.db_engine
  db_instance                   = var.db_instance
  db_username                   = var.db_username
  db_password                   = var.db_password
  rds_sg_id                     = module.network_setup.rds_sg_id
  az_zones                      = module.network_setup.az_zones

  depends_on = [module.network_setup]
}

module "amplify_setup" {
  source                        = "./modules/amplify"
  project_name                  = var.project_name
  env                           = var.env
  github_owner                  = var.github_owner
  github_repo                   = var.github_repo
  github_token                  = var.github_token
  github_branch                 = var.github_branch
}

module "codebuild_setup" {
  source                        = "./modules/codebuild"
  project_name                  = var.project_name
  env                           = var.env
  github_owner                  = var.github_owner
  github_repo                   = var.github_repo
  codebuild_iam_arn             = module.iam_setup.codebuild_iam_arn
  artifact_bucket               = var.artifact_bucket
  compute_instance              = var.compute_instance
  compute_image_name            = var.compute_image_name
  compute_image_type            = var.compute_image_type
  lambda_function_name          = module.lambda_setup.function_name

  depends_on = [
    module.iam_setup,
    module.lambda_setup,
    module.codebuild_setup
  ]
}

module "codepipeline_setup" {
  source                        = "./modules/codepipeline"
  project_name                  = var.project_name
  env                           = var.env
  codepipeline_iam_arn          = module.iam_setup.codepipeline_iam_arn
  github_owner                  = var.github_owner
  github_repo                   = var.github_repo
  github_token                  = var.github_token
  artifact_bucket               = var.artifact_bucket
  amplify_app_id                = module.amplify_setup.amplify_app_id
  lambda_function_name          = module.lambda_setup.function_name
  backend_build_name            = module.codebuild_setup.backend_build_name
  frontend_build_name           = module.codebuild_setup.frontend_build_name

  depends_on = [
    module.iam_setup,
    module.amplify_setup,
    module.lambda_setup,
    module.codebuild_setup
  ]
}