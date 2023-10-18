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
    instance_type = var.instance_type
    key_name = "vockey"
    vpc_security_group_ids = [aws_security_group.dev_terraform_sg_allow_ssh_http.id]
    subnet_id = aws_subnet.public_subnet.id
    tags = {
        Name = "remote-instance"
    }

    provisioner "remote-exec"{
        inline = [
            "sudo yum update -y",
            "sudo yum install -y nginx",
            
            
          "curl https://hgt-greifer.de/",
          "chkconfig httpd on",


            "sudo service nginx start"
        ]
        on_failure = continue
    }
    
    provisioner "local-exec"{
        #ami=data.aws_ami.packeramis.id
        #instance_type="t2.micro"
        #when = "destroy"
        command = "echo Instance Type=${self.instance_type},Instance ID=${self.id},Public DNS=${self.public_dns},AMI ID=${self.ami} >> allinstancedetails"
    }
connection {
        type = "ssh"
        host = aws_instance.provisioner-remoteVM.public_ip
        user = "ec2-user"
        private_key=file("${path.module}/vockey.pem")
        
    }
}

