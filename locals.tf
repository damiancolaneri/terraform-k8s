locals {
  region = "us-east-1"

  common_tags = {
    Name        = "k8s-profe"
    Terraform   = "true"
    Environment = "dev"
  }
}
