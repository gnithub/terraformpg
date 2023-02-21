terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

variable "env" {}

resource "aws_security_group" "secg_1" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.cidr]
  }

 ingress {
    description      = "TLS from VPC"
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = [var.cidr]
  }
}

resource "aws_instance" "prod_instance" {
   ami                     = "ami-0e742cca61fb65051"
   instance_type           = "t2.large"
   count                   = var.env=="prod" ? 1 : 0
   tags                    = { 
      Name = "Count = ${count.index}"
    }
}


resource "aws_instance" "test_instance" {
   ami                     = "ami-0e742cca61fb65051"
   instance_type           = "t2.micro"
   count                   = var.env=="test" ? 3 : 0
}
