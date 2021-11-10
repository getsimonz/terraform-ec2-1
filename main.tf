provider "aws" {
  region = var.aws_region
}

# Create AWS ec2 instance
resource "aws_instance" "tf_Instance" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "tf_Instance" {
  vpc      = true
  instance = aws_instance.tf_Instance.id
tags= {
    Name = "my_elastic_ip"
  }
}
