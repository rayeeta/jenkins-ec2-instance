variable "key_name" {
  description = "The name for the SSH key pair"
  type        = string
  default     = "terraform-ec2-key"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0e2c8caa4b6378d8c" # Example AMI ID for Ubuntu
}
