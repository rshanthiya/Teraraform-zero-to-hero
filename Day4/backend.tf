terraform {
  backend "s3" {
    bucket = "shanthiyakavi-abc"
    region = "us-east-1"
    key = "shanthiya/terraform.tfstate"
    dynamodb_table = "terraform-lock"
  }
}