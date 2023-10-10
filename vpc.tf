# VPC Creation using CIDR block available in vars.tf
# VPC Creation using CIDR block available in vars.tf change we need

resource "aws_vpc" "provisionerVPC"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames=true
    enable_dns_support = true

    tags = {
        Name = "dev-terraform-vpc"
    }
}

