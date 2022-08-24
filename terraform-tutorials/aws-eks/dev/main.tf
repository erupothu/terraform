provider "aws" {
  region = var.aws_region
  # allowed_account_ids = ["${var.allowed_account_ids}"]
}

module "vpc" {
  source = "./modules/vpc"
}

module "eks" {
  source = "./modules/eks"
}

# module "s3" {
#   source = "./modules/s3"
# }

# module "route53" {
#   source = "./modules/route53"
# }

# module "iam" {
#   source = "./modules/iam"
# }

# module "rds" {
#   source = "./modules/iam"
# }

# module "alb" {
#   source = "terraform-aws-modules/alb/aws"
#   version = "v2.0.0"
# }
