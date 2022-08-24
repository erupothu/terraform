data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}


module "network" {
  source = "../vpc"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"

  cluster_version = "1.21"
  cluster_name    = "my-cluster"
  # vpc_id          = "vpc-1234556abcdef"
  subnets         = [module.network.aws_subnet.dev1-subnet.id,module.vpc.aws_subnet.dev2-subnet.id]
  vpc_id          = "${module.network.aws_vpc.dev-vpc.id}"

  worker_groups = [
    {
      name = "dev-worker-group-1"
      instance_type = "t2.small"
      asg_min_size = 1
      asg_desired_capacity = 2
      asg_max_size  = 3
      additional_security_group_ids = "${[module.network.aws_security_group.allow-web-traffic.id]}"
    }
  ]
}