data "aws_ssm_parameter" "ubuntu_20_04" {
  name = "/aws/service/canonical/ubuntu/server/20.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}


resource "aws_instance" "my_ec2_instance" {
ami = data.aws_ssm_parameter.ubuntu_20_04.value
instance_type = var.instance_type
key_name = aws_key_pair.my_key.key_name
vpc_security_group_ids = [aws_security_group.ec2_security_group.id]


}

resource "aws_security_group" "ec2_security_group" {
  name        = "ec2_security_group"
  description = "allow ssh"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description= "HTTP"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["${var.my_ip}/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "my_key" {

    key_name = "my-ec2-key"
    public_key = file("~/.ssh/my-aws-key.pub")
}


