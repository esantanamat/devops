variable "my_ip" {
  description = "My public ip address"
  type        = string
}

variable "region" {
  description = "AWS resources region"
  type = string
  default = "us-east-1"
}

variable "instance_type" {
  description = "AWS EC2 instance type"
  type = string
  default = "t2.micro"
}