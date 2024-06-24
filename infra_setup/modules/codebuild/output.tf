output "backend_build_name" {
  value       = aws_codebuild_project.backend.name
  description = "codebuild name for backend"
}

output "frontend_build_name" {
  value       = aws_codebuild_project.frontend.name
  description = "codebuild name for frontend"
}