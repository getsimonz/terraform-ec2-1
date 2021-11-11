provider "aws" {
  region = var.aws_region
}

# Create AWS ec2 instance
resource "aws_instance" "tf_Instance_1" {
  ami           = var.ami_id
  key_name = var.key_name
  instance_type = var.instance_type
  security_groups= [var.security_group]
  tags= {
    Name = var.tag_name
  }
}

# Create Elastic IP address
resource "aws_eip" "tf_Instance_1" {
  vpc      = true
  instance = aws_instance.tf_Instance_1.id
tags= {
    Name = "my_elastic_ip"
  }
}

# Output ip address to local file
resource "local_file" "public_ip" {
    content  = aws_instance.tf_Instance_1.public_dns
    filename = "dev.inv"
}
