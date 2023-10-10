module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "single-instance"

  instance_type          = "t2.micro"
  key_name               = "labsuser"
  monitoring             = true
  vpc_security_group_ids = ["sg-0c4d74681873f802a"]
  subnet_id              = "subnet-0f63d16f8187970cb*"

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
