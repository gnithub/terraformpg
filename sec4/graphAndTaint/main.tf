terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.55.0"
    }
  }
}

variable "cidr" {
  default = "192.68.1.1/32"
}

variable "env" {
  default = "prod"
}

data "aws_ami" "amz_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }
}

resource "aws_instance" "dev_instance" {
  ami                    = data.aws_ami.amz_ami.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sec1.id]
  count                  = var.env == "prod" ? 3 : 2
}

output "instance_arn" {
  value = aws_instance.dev_instance[*].arn
}


resource "aws_security_group" "sec1" {
  name        = "allowed_tls"
  description = "Allow TLS inbound traffic example"

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.cidr]
  }

}



