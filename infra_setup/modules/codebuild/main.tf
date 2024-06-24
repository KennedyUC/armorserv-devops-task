resource "aws_codebuild_project" "frontend" {
  name          = "frontend-build"
  service_role  = var.codebuild_arn
  artifacts {
    type = "S3"
    location = var.artifact_bucket
    path = "frontend/"
  }
  environment {
    compute_type = var.compute_instance
    image = var.compute_image_name
    type = var.compute_image_type
  }
  source {
    type = "GITHUB"
    location = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    buildspec = file("amplify_buildspec.yml")
  }
}

resource "aws_codebuild_project" "backend" {
  name          = "backend-build"
  service_role  = var.codebuild_iam_arn
  artifacts {
    type = "S3"
    location = var.artifact_bucket
    path = "backend/"
  }
  environment {
    compute_type = var.compute_instance
    image = var.compute_image_name
    type = var.compute_image_type
    environment_variable {
      name  = "function_name"
      value = var.lambda_function_name
    }
    environment_variable {
      name  = "alias_name"
      value = var.env
    }
  }
  source {
    type = "GITHUB"
    location = "https://github.com/${var.github_owner}/${var.github_repo}.git"
    buildspec = file("lambda_buildspec.yml")
  }

  tags = {
    Name = "${var.project_name}-${var.env}-codebuild"
    Env  = var.env
  }
}