provider "aws" {
  region = "us-east-1" # Specify the AWS region
}

# Generate an SSH key pair
resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "this" {
  key_name   = var.key_name
  public_key = tls_private_key.this.public_key_openssh
}

# Create a security group to allow SSH access
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh_edited"                                   // EDITED
  description = "Allow SSH inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh_edited"              // EDITED
  }
}

# Launch an EC2 instance
resource "aws_instance" "web" {
  ami           = "ami-0e2c8caa4b6378d8c" #var.ami_id  Specify your desired AMI ID
  instance_type = "t2.micro"
  key_name      = aws_key_pair.this.key_name

  vpc_security_group_ids = [aws_security_group.allow_ssh.id]

  tags = {
    Name = "Terraform-EC2-Instance"
  }
}

# Output the instance's public IP
output "instance_public_ip" {
  value = aws_instance.web.public_ip
}

# Output the private key content
output "private_key" {
  value     = tls_private_key.this.private_key_pem
  sensitive = true
}
