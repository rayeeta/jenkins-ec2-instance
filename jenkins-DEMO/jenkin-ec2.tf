provider "aws" {
  region = "us-east-1" # Change to your desired AWS region
}

# Variable for Ubuntu AMI
variable "ami_id" {
  default = "ami-0c02fb55956c7d316" # Ubuntu 20.04 LTS AMI for us-east-1
}

# Security Group to allow port 8080 and port 22
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_security_group"
  description = "Allow port 8080 for Jenkins and port 22 for SSH"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust to restrict access if needed
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Adjust to restrict access if needed
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Key Pair
resource "tls_private_key" "jenkin_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "jenkin_key_pair" {
  key_name   = "jenkinKey"
  public_key = tls_private_key.jenkin_key.public_key_openssh
}

# EC2 Instance
resource "aws_instance" "jenkins_instance" {
  ami           = var.ami_id
  instance_type = "t2.medium"
  key_name      = aws_key_pair.jenkin_key_pair.key_name

  security_groups = [
    aws_security_group.jenkins_sg.name
  ]

  tags = {
    Name = "Jenkins-Instance"
  }
}

# Output private key content
output "private_key_pem" {
  description = "The private key content to SSH into the Jenkins EC2 instance."
  value       = tls_private_key.jenkin_key.private_key_pem
  sensitive   = true
}

# Output instance public IP
output "instance_public_ip" {
  description = "The public IP of the Jenkins EC2 instance."
  value       = aws_instance.jenkins_instance.public_ip
}

