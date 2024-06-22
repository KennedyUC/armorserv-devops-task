// Allow Amplify to access S3 and CloudFront

resource "aws_iam_role" "amplify" {
  name = "amplify_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "amplify.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = "AmplifyAssumeRolePolicy"
      }
    ]
  })
}

resource "aws_iam_policy" "amplify" {
  name = "amplify_policy"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowS3Access",
        Action   = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}/*",
        Effect   = "Allow"
      },
      {
        Sid      = "AllowCloudFrontInvalidation",
        Action   = [
          "cloudfront:CreateInvalidation"
        ],
        Resource = "*",
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "amplify" {
  role       = aws_iam_role.amplify.name
  policy_arn = aws_iam_policy.amplify.arn
}