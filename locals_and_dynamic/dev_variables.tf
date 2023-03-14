variable "instance_type" {
  default = "t2.micro"
}

variable "ingress_ports" {
  type    = list(any)
  default = ["443", "8080", "8443", "80"]
}
