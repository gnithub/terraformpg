terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.54.0"
    }
  }
}

provider "aws" {
  region = "us-west-2"
}

resource "aws_eip" "my_eip" {
  vpc      = true
}



resource "aws_instance" "web" {
  ami           = "ami-0f1a5f5ada0e7da53" # us-west-2
  instance_type = "t2.micro"
}


resource "aws_eip_association" "my_eip_assoc" {
  instance_id   = aws_instance.web.id
  allocation_id = aws_eip.my_eip.id
}

resource "aws_security_group" "my_allow_tls" {
  name        = "allow_tls: Test"
  description = "Allow TLS inbound traffic: TEST"
  #vpc_id      = aws_vpc.main.id

  ingress {
    description      = "TLS from VPC: Test"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["${aws_eip.my_eip.public_ip}/32"]
    #ipv6_cidr_blocks = [aws_vpc.main.ipv6_cidr_block]
  }
}

output "public_ip" {
   value = aws_eip.my_eip.public_ip
}
