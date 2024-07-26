provider "aws" {
  region = "us-east-1"
}

module "ec2_instance" {
    source = "./module-ec2-implementation"
    ami_value = "ami-04b70fa74e45c3917"
    instance_type_value = "t2.micro"
}

output "public_ip" {
    description = "EC2 public IP details"
value =module.ec2_instance.public_ip
}
