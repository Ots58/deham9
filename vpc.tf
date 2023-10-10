# VPC Creation using CIDR block available in vars.tf

resource "aws_vpc" "provisionerVPC"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames=true
    enable_dns_support = true

    tags = {
        Name = "dev-terraform-vpc"
    }
}
variable "vpc_cidr"{
    default = "10.0.1.0/24"
}
