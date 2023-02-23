variable "ports" {
  type    = list(number)
  default = [23, 393, 433, 8080]
}

resource "aws_security_group" "allowed_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"

  dynamic "ingress" {
    for_each = var.ports
    iterator = port
    content {
      description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["192.168.1.1/32"]
    }
  }
}


output "outcome" {
  value = aws_security_group.allowed_tls.name
}
