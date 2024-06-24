resource "aws_db_subnet_group" "rds" {
  name       = "rds"
  subnet_ids = var.private_subnet_ids
}

resource "aws_db_instance" "rds" {
  count                   = len(var.az_zones)
  availability_zone       = element(var.az_zones, count.index)
  identifier              = "${var.project_name}-${var.env}-db-${count.index}"
  allocated_storage       = var.db_storage
  max_allocated_storage   = var.max_db_storage
  engine                  = var.db_engine
  instance_class          = var.db_instance
  username                = var.db_username
  password                = var.db_password
  vpc_security_group_ids  = [var.rds_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.rds.name
  skip_final_snapshot     = true
  backup_retention_period = 7
  storage_encrypted       = true

  blue_green_update {
    enabled = true
  }

  timeouts {
    create = "3h"
    delete = "3h"
    update = "3h"
  }

  tags = {
    Name = "${var.project_name}-${var.env}-db"
    Env  = var.env
  }
}