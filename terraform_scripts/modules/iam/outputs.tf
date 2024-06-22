output "lambda_iam_arn" {
  value       = aws_iam_role.lambda.arn
  description = "lambda iam role arn"
}

output "amplify_iam_arn" {
  value       = aws_iam_role.amplify.arn
  description = "amplify iam role arn"
}

output "rds_iam_arn" {
  value       = aws_iam_role.rds.arn
  description = "rds iam role arn"
}