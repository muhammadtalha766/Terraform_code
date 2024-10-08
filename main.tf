#provider block
provider "aws" {
    region = "eu-north-1"
    access_key = "xxxxx"
    secret_key = "xxxxxxxx"
}
#resurce block
resource "aws_instance" "first_instance" {
    ami = "ami-04cdc91e49cb06165"
    instance_type = "t3.micro"
    #security group attach
    vpc_security_group_ids = [ aws_security_group.first_security_group.id ]
    key_name = "ansible key pair"
    root_block_device {
    volume_size = 20  # Size in GB
    }
    user_data = file("${path.module}/user-data.sh") 
    tags = {
      Name = "Instance_from_Terraform"
    }
}
 #security-group block
 resource "aws_security_group" "first_security_group" {
  name        = "first_security_group"
  ingress{
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port   = 8090
    to_port     = 8091
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  
  }
  ingress{
    from_port   = 5000
    to_port     = 5001
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 }

 #output block
 output "instance_id" {
  value = aws_instance.first_instance.public_ip
  }

  