resource "aws_db_subnet_group" "default" {
  name       = "main-subnet-group"
  subnet_ids = [aws_subnet.database-subnet-1.id, aws_subnet.database-subnet-2.id] # Fixed duplicate subnet IDs

  tags = {
    Name = "My subnet group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql" # Fixed quotation marks
  engine_version         = "8.0.39"
  instance_class         = "db.t4g.micro"
  multi_az               = true # Fixed boolean value (removed quotes)
  db_name                = "mydb"
  username               = "new_username" # Change the username here
  password               = "new_password" # Change the password here
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database-sg.id] # Corrected security group name
}
