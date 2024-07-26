output "public_ip" {
    description = "EC2 public IP details"
value = aws_instance.example.public_ip
}