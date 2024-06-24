resource "aws_amplify_app" "amplify_app" {
  name = "amplify-app"

  repository = "https://github.com/${var.github_owner}/${var.github_repo}"
  oauth_token = var.github_token

  environment_variables = {
    _LIVE_PACKAGE_SCAN = "false"
  }

  build_spec = file("amplify_buildspec.yml")

  custom_rules {
    source = "</^[^.]+$|\\.(?!(css|gif|ico|jpg|js|png|txt|svg|woff|woff2)$)([^.]+$)/>"
    target = "/index.html"
    status = "200"
  }

  tags = {
    Name = "${var.project_name}-${var.env}-frontend"
    Env  = var.env
  }
}

resource "aws_amplify_branch" "github" {
  app_id = aws_amplify_app.amplify_app.id
  branch_name = var.github_branch

  environment_variables = {
    STAGE = var.env
  }

  enable_auto_build = true
  framework = "React"

  depends_on = [aws_amplify_app.amplify_app]
}