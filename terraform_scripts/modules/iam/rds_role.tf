// Allow RDS to interact with necessary AWS services

resource "aws_iam_role" "rds" {
  name = "rds_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = "RDSAssumeRolePolicy"
      }
    ]
  })
}

resource "aws_iam_policy" "rds" {
  name = "rds_policy"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowRDSDescribeActions",
        Action   = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters"
        ],
        Resource = "*",
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds_policy_attachment" {
  role       = aws_iam_role.rds.name
  policy_arn = aws_iam_policy.rds.arn
}