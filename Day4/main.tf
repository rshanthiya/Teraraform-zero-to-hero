provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "exe2" {
  ami ="ami-04b70fa74e45c3917" 
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = "shanthiyakavi-abc"
}

resource "aws_dynamodb_table" "terraform_lock" {
  name           = "terraform-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}





