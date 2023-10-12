# resource "aws_instance" "ec2_instance" {
#   ami=var.AMIS[var.AWS_REGION] 
#   instance_type = "t2.micro"
#   associate_public_ip_address = true
#   tags = {
#     Name = "Terraform_test_ec2"
#   }
# }
# output public_ip{
#   value=aws_instance.ec2_instance.public_ip
# }
# resource "aws_instance" "webserver" {
#   for_each = var.webservers
#     ami=var.AMIS[var.AWS_REGION] 
#     instance_type = "t2.micro"
#     associate_public_ip_address = true
#     tags = {
#       Name = each.value["name"]
#     }
# }

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

#Provider profile and region in which all the resources will create
provider "aws" {
  profile = "default"
  region  = "us-west-2"
}
# Instance Configuration
# Instance Configuration
resource "aws_instance" "provisioner-remoteVM"{
    ami = "ami-0d2017e886fc2c0ab"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "remote-instance"
    }
   } 

  module "s32_bucket" {
  source = "terraform-aws-modules/s32-bucket/aws"

  bucket = "my-s32-bucket"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = true
  }
}