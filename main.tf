provider "aws" {
  region = "eu-west-1"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "ec2_cluster" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name  = "my-cluster"
  count = 2

  ami                    = "ami-d834aba1"
  instance_type          = "t2.micro"
  key_name               = "ignas-ireland-ignasmo"
  monitoring             = true
  vpc_security_group_ids = ["sg-a8d2e9cc"]
  subnet_id              = "subnet-b6df2bd2"

  tags = {
    Terraform = "true"

    # Environment = "dev"
  }
}

output "ec2_instance_ids" {
  value = "${module.ec2_cluster.id}"
}