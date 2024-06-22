// Allow Lambda function to interact with CloudWatch Logs and RDS

resource "aws_iam_role" "lambda" {
  name = "lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = "LambdaAssumeRolePolicy"
      }
    ]
  })
}

resource "aws_iam_policy" "lambda" {
  name = "lambda_policy"
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid      = "AllowCloudWatchLogs",
        Action   = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:*:*:*",
        Effect   = "Allow"
      },
      {
        Sid      = "AllowRDSDescribeActions",
        Action   = [
          "rds:DescribeDBInstances",
          "rds:DescribeDBClusters",
          "rds:DescribeDBSnapshots",
          "rds:DescribeDBSubnetGroups",
          "rds:DescribeEngineDefaultParameters",
          "rds:DescribeEventCategories",
          "rds:DescribeEventSubscriptions",
          "rds:DescribeOptionGroups",
          "rds:DescribeOrderableDBInstanceOptions",
          "rds:DescribePendingMaintenanceActions",
          "rds:DescribeReservedDBInstances",
          "rds:DescribeReservedDBInstancesOfferings"
        ],
        Resource = "*",
        Effect   = "Allow"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda" {
  role       = aws_iam_role.lambda.name
  policy_arn = aws_iam_policy.lambda.arn
}