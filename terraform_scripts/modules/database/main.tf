resource "aws_db_subnet_group" "rds" {
  name       = "rds"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "rds" {
  allocated_storage    = var.db_storage
  engine               = var.db_engine
  instance_class       = var.db_instance
  name                 = var.db_name
  username             = var.db_username
  password             = var.db_password
  vpc_security_group_ids = [var.rds_sg_id]
  db_subnet_group_name = var.rds_sg_name
  skip_final_snapshot  = true

  tags = {
    Name = "${var.project_name}-${var.env}-rds"
    Env  = var.env
  }
}