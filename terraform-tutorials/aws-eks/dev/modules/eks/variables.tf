variable "eks_cluster_name" {
    description = "Existing vpc to use"
    default = "dev-cluster"
}

variable "eks_vpc_id" {
    description = "Existing vpc to use"
    default = "d1234556abcdef"
}

variable "worker_group_ec2_type" {
    description = "Existing vpc to use"
    default = "t2.small"
}