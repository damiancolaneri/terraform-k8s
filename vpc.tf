module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.6.0"

  name = "k8s-${var.name}"
  cidr = "10.0.0.0/16"

  enable_dns_hostnames = true

  azs            = ["${local.region}a", "${local.region}b"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
