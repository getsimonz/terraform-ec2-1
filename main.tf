provider "aws" {
  region = var.aws_region
}

#Create security group with firewall rules
resource "aws_security_group" "tf_security_group_1" {
  name        = var.security_group
  description = "security group for Ec2 instance"

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

 # outbound from jenkis server
  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags= {
    Name = var.security_group
  }
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
resource "aws_eip" "tf_Instance_el" {
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
