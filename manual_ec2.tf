# Generate a new key pair
resource "aws_key_pair" "my_key_pair" {
  key_name   = "my-new-key"
  public_key = file("~/.ssh/id_rsa.pub") # Path to your public key
}

# Create a new EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-0ddc798b3f1a5117e" # Update with your preferred AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key_pair.key_name

  tags = {
    Name = "MyEC2Instance"
  }
}

output "instance_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}
