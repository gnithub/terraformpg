data "aws_availability_zones" "available" {
  state = "available"

  filter {
    name   = "zone-type"
    values = ["availability-zone"]
  }
}

data "aws_region" "current" { }

output "aws_region" {
  description = "AWS region"
  value       = data.aws_region.current.name
}	


