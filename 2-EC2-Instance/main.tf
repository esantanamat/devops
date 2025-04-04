terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws"
      version = "~> 5.0"
    }
    
    }
}


provider "aws" {
    region = "us-east-1"
}


resource "aws_instance" "my_ec2_instance" {
ami = "ami-00a929b66ed6e0de6"
instance_type = "t2.micro"
key_name = aws_key_pair.my_key.key_name
vpc_security_group_ids = [aws_security_group.ec2_security_group.id]


}

resource "aws_security_group" "ec2_security_group" {
name = "ec2_security_group"
description = "allow ssh"
ingress {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
}


}

resource "aws_key_pair" "my_key" {

    key_name = "my-ec2-key"
    public_key = file("~/.ssh/my-aws-key.pub")
}


output "instance_public_ip" {
  value = aws_instance.my_ec2_instance.public_ip
}
