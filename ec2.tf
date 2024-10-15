# Create 1st EC2 instance in public subnet
resource "aws_instance" "demonistance" {
  ami                         = "ami-087c17d1fe0178315"
  instance_type               = "t2.micro"
  count                       = 1
  key_name                    = "new"
  vpc_security_group_ids      = [aws_security_group.demosg.id]
  subnet_id                   = aws_subnet.public-subnet-1.id # Ensure you use the correct subnet reference
  associate_public_ip_address = true
  user_data                   = file("data.sh")

  tags = {
    Name = "My public Instance"
  }
}

# Create 2nd EC2 instance in public subnet
resource "aws_instance" "demonistance1" {
  ami                         = "ami-087c17d1fe0178315"
  instance_type               = "t2.micro"
  count                       = 1
  key_name                    = "new"
  vpc_security_group_ids      = [aws_security_group.demosg.id]
  subnet_id                   = aws_subnet.public-subnet-2.id # Ensure you use the correct subnet reference
  associate_public_ip_address = true
  user_data                   = file("package.sh")

  tags = {
    Name = "My public Instance 2"
  }
}

