data "aws_ami" "amz_ami" {
  most_recent = true
  filter {
    name   = "name"
    values = ["*amazon-ecs-optimized"]
  }
}


resource "aws_instance" "base" {
  ##  description = "Base instance no.${count.index)"
  ami           = data.aws_ami.amz_ami.id
  instance_type = var.instance_type
  tags          = local.my_tags
  count         = 2
}
