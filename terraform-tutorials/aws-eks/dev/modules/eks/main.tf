data "aws_eks_cluster" "dev" {
  name = module.dev_eks.cluster_id
}

data "aws_eks_cluster_auth" "dev" {
  name = module.dev_eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.dev.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.dev.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.dev.token
}


module "network" {
  source = "../vpc"
}

module "dev_eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = var.eks_cluster_name
  # vpc_id          = var.eks_vpc_id
  # subnets         = [module.network.aws_subnet.dev1-subnet.id,module.vpc.aws_subnet.dev2-subnet.id]
  # public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  subnets         = ["subnet-abcde012", "subnet-bcde012a", "subnet-fghi345a"]
  vpc_id          = module.network.vpc_id

  worker_groups = [
    {
      name = "dev-worker-group-1"
      instance_type = var.worker_group_ec2_type
      asg_min_size = 1
      asg_desired_capacity = 2
      asg_max_size  = 3
      additional_security_group_ids = [module.network.aws_security_group_traffice_id]
    }
  ]
}