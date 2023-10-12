# VPC Creation using CIDR block available in vars.tf
# VPC Creation using CIDR block available in vars.tf change we need
data "aws_availability_zones" "available"{}

resource "aws_vpc" "provisionerVPC"{
    cidr_block = var.vpc_cidr
    enable_dns_hostnames=true
    enable_dns_support = true

    tags = {
        Name = "dev-terraform-vpc"
    }
}

# Public subnet public CIDR block available in vars.tf and provisionersVPC
resource "aws_subnet" "public_subnet"{
    cidr_block = var.vpc_cidr
    vpc_id = aws_vpc.provisionerVPC.id
    map_public_ip_on_launch = true
    availability_zone = data.aws_availability_zones.available.names[1]
    tags = {
        Name = "dev-public-subnet"
    }    
}
# To access EC2 instance inside a virtual private cloud we need an Internet Gateway and a routing table connecting the subnetto the Internet Gateway
# Creating Internet Gateway
resource "aws_internet_gateway" "gw"{
    vpc_id = aws_vpc.provisionerVPC.id
    tags = {
        Name = "dev-gw"
    }
}
