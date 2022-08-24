variable "vpc_cidr_block" {
    description = "Existing vpc to use"
    default = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
    description = "Existing vpc to use"
    default = "10.0.0.0/24"
}

variable "route_cidr_block" {
    description = "Existing vpc to use"
    default = "0.0.0.0/0"
}

variable "route_apv6_cidr_block" {
    description = "Existing vpc to use"
    default = "::/0"
}

variable "nic_private_ip" {
    description = "Existing vpc to use"
    type = list
    default = ["10.0.1.50"]
}

variable "eip" {
    description = "Existing vpc to use"
    default = "10.0.1.50"
}


variable "subnet_azs_a" {
    description = "Existing vpc to use"
    default = "ap-south-1a"
}

variable "subnet_azs_b" {
    description = "Existing vpc to use"
    default = "ap-south-1a"
}

variable "vpc_tag_name" {
    description = "Existing vpc to use"
    default = "development"
}

variable "subnet1_tag_name" {
    description = "Existing vpc to use"
    default = "dev1-subnet"
}

variable "subnet2_tag_name" {
    description = "Existing vpc to use"
    default = "dev2-subnet"
}

variable "igw_tag_name" {
    description = "Existing vpc to use"
    default = "dev2-subnet"
}

variable "route_tag_name" {
    description = "Existing vpc to use"
    default = "dev-rt"
}

variable "security_group_tag_name" {
    description = "Allow web traffic"
    default = "allow_tls"
}