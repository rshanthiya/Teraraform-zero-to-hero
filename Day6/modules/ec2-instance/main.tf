provider "aws" {
  region = "us-east-1"
}

variable "ami" {
    description = "value"
  
}

variable "instance_type" {
  description = "instance type"
}

resource "aws_instance" "exe1" {
  ami = var.ami
  instance_type = var.instance_type
}