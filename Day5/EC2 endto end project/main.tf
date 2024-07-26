provider "aws" {
  region = "us-east-1"
}

variable "cidr" {
  default = "10.0.0.0/16"
}

resource "aws_key_pair" "exe" {
key_name = "shanthiya"
public_key = file("~/.ssh/id_rsa.pub")

}

resource "aws_vpc" "vpc1" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
vpc_id = aws_vpc.vpc1.id
cidr_block ="10.0.0.0/24"
availability_zone = "us-east-1a"
map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "ig" {
  vpc_id = aws_vpc.vpc1.id
}

resource "aws_route_table" "rt1" {
  vpc_id = aws_vpc.vpc1.id

  route{
cidr_block = "0.0.0.0/0"
gateway_id = aws_internet_gateway.ig.id

  }
}

resource "aws_route_table_association" "route_ass" {
    route_table_id = aws_route_table.rt1.id
    subnet_id = aws_subnet.sub1.id

}

resource "aws_security_group" "sg1" {
  vpc_id = aws_vpc.vpc1.id

  ingress {
    description = " HTTP from VPC"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {

    description = " SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

egress {

    from_port = 0
    to_port = 0
    protocol = -1
    cidr_blocks = ["0.0.0.0/0"]
}

tags = {
    name = "web-sg"
}

}

resource "aws_instance" "exa1" {
  ami ="ami-0261755bbcb8c4a84"
  instance_type = "t2.micro"
  key_name = aws_key_pair.exe.key_name
  vpc_security_group_ids = [aws_security_group.sg1.id]
  subnet_id = aws_subnet.sub1.id


  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa") 
    host = self.public_ip
  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ubuntu/app.py"
  }

    provisioner "remote-exec" {
        inline = [ 
            "echo 'Hello from the remote instance'",
            "sudo apt update -y",
            "sudo apt-get install python3-pip -y",
            "cd /home/ubuntu",
            "sudo pip3 install flask",
            "sudo python3 app,py &"


         ]
    }

    
  }




