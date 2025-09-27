# rds.tf

# Create a subnet group for RDS, indicating in which private subnets it can operate.
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "RDS Subnet Group"
  }
}

# Create the RDS database instance
resource "aws_db_instance" "postgres_db" {
  identifier           = "microtalent-db"
  allocated_storage    = 20 # Gb
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "16.10"
  instance_class       = "db.t3.micro"
  db_name              = "microtalentdb"
  username             = var.db_username
  password             = var.db_password
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  
  # Very important! Prevents the DB from being accessible from the internet.
  publicly_accessible  = false 
  skip_final_snapshot  = true
}
