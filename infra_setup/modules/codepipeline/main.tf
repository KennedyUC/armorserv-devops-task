resource "aws_codepipeline" "codepipeline" {
  name     = "test-codepipeline"
  role_arn = var.codepipeline_iam_arn

  artifact_store {
    location = var.artifact_bucket
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "ThirdParty"
      provider         = "GitHub"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        Owner  = var.github_owner
        Repo   = var.github_repo
        Branch = var.github_branch
        OAuthToken = var.github_token
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "BuildFrontend"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["frontend_build_output"]

      configuration = {
        ProjectName = var.frontend_build_name
      }
    }

    action {
      name             = "BuildBackend"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["backend_build_output"]

      configuration = {
        ProjectName = var.backend_build_name
      }
    }
  }

  stage {
    name = "DeployFrontend"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "Amplify"
      input_artifacts  = ["frontend_build_output"]

      configuration = {
        AppId = var.amplify_app_id
        BranchName = var.github_branch
      }
    }
  }

  stage {
    name = "DeployBackend"

    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "Lambda"
      input_artifacts  = ["backend_build_output"]

      configuration = {
        FunctionName = var.lambda_function_name
      }
    }
  }

  tags = {
    Name = "${var.project_name}-${var.env}-pipeline"
    Env  = var.env
  }
}