provider "aws" {
  region = "us-east-1"
}

variable "ami_id" {
    description = "AMI value"
    type = string
  
}

variable "instance_type_id" {
  description = "instance type value"
  type = string
  default = "t2.micro"
}

resource "aws_instance" "example" {
  ami = var.ami_id
  instance_type = var.instance_type_id
}
output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example.public_ip
}
