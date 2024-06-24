resource "aws_security_group" "lambda_sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_route.private_internet_route]

  tags = {
    Name = "${var.project_name}-${var.env}-lambda"
    Env  = var.env
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.vpc.id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  depends_on = [aws_route.private_internet_route]

  tags = {
    Name = "${var.project_name}-${var.env}-rds"
    Env  = var.env
  }
}